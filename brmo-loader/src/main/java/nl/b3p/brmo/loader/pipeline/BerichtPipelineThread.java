package nl.b3p.brmo.loader.pipeline;

import java.util.concurrent.BlockingQueue;
import java.util.concurrent.LinkedBlockingQueue;
import java.util.concurrent.TimeUnit;
import nl.b3p.brmo.loader.BerichtenHandler;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.javasimon.SimonManager;
import org.javasimon.Split;

/**
 *
 * @author Matthijs Laan
 */
public abstract class BerichtPipelineThread extends Thread {
    final Log log;

    private final BlockingQueue<BerichtWorkUnit> queue;
    final BerichtenHandler handler;
    private final String stopwatchPrefix;

    private boolean stopWhenQueueEmpty = false;
    private boolean abort = false;

    public BerichtPipelineThread(BerichtenHandler handler, int capacity, String stopwatchPrefix) {
        log = LogFactory.getLog(this.getClass());
        this.queue = new LinkedBlockingQueue(capacity);
        this.handler = handler;
        this.stopwatchPrefix = stopwatchPrefix;
    }

    public void stopWhenQueueEmpty() {
        this.stopWhenQueueEmpty = true;
    }

    public void setAbortFlag() {
        this.abort = true;
    }

    public BlockingQueue<BerichtWorkUnit> getQueue() {
        return queue;
    }

    abstract void work(BerichtWorkUnit workUnit) throws Exception;

    @Override
    public void run() {
        log.info("started, waiting for work");

        while(true) {
            BerichtWorkUnit workUnit = null;
            try {
                Split poll = SimonManager.getStopwatch(stopwatchPrefix + ".poll").start();
                workUnit = queue.poll(1, TimeUnit.SECONDS);
                poll.stop();
            } catch(InterruptedException e) {
                log.info("interrupted while polling work queue");
            }

            if(abort) {
                log.info("aborting!");
                return;
            }

            if(stopWhenQueueEmpty && workUnit == null) {
                log.info("work queue empty, stopping");
                return;
            }
            if(workUnit == null) {
                continue;
            }
            if(log.isDebugEnabled()) {
                log.info(String.format("processing %s for work unit bericht id %d, %s (queue size %d)",
                        workUnit.getTypeOfWork().toString(),
                        workUnit.getBericht().getId(),
                        workUnit.getBericht().getObjectRef(),
                        queue.size()));
            }
            try {
                work(workUnit);
            } catch(Exception e) {
                // Do not log stacktrace, in database bericht.opmerking
                log.error("work method threw exception (continuing): " + e.getClass() + ": " + e.getMessage());
            }
            try {
                if(workUnit.getRunAfterWork() != null) {
                    workUnit.getRunAfterWork().run();
                    workUnit.setRunAfterWork(null);
                }
            } catch(Exception e) {
                // Do not log stacktrace, in database bericht.opmerking
                log.error("run after work method threw exception, aborting", e);
                return;
            }
        }
    }
}
