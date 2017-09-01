package nl.b3p.brmo.stufbg204;

import javax.jws.HandlerChain;
import javax.jws.WebService;
import nl.egem.stuf.sector.bg._0204.AsynchroonAntwoordBericht;
import nl.egem.stuf.sector.bg._0204.KennisgevingsBericht;
import nl.egem.stuf.sector.bg._0204.VraagBericht;
import nl.egem.stuf.stuf0204.BevestigingsBericht;
import nl.egem.stuf.stuf0204.FoutBericht;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

/**
 * @author mprins
 */
@WebService(
        serviceName = "StUFBGAsynchroon",
        portName = "StUFBGAsynchronePort",
        endpointInterface = "nl.egem.stuf.sector.bg._0204.StUFBGAsynchroonPortType",
        targetNamespace = "http://www.egem.nl/StUF/sector/bg/0204",
        wsdlLocation = "WEB-INF/wsdl/bg0204.wsdl"
)
@HandlerChain(file = "/handler-chain.xml")
public class Stufbg204Service {

    private static final Log LOG = LogFactory.getLog(Stufbg204Service.class);

    public BevestigingsBericht ontvangAsynchroneVraag(VraagBericht vraag) {
        LOG.debug("Er is vraag ontvangen van soort: " + vraag.getStuurgegevens().getBerichtsoort());

        BevestigingsBericht b = new BevestigingsBericht();
        b.setStuurgegevens(vraag.getStuurgegevens());

        return b;
    }

    public BevestigingsBericht ontvangAsynchroonAntwoord(AsynchroonAntwoordBericht asynchroonAntwoord) {
        LOG.debug("Er is antwoord ontvangen van soort: " + asynchroonAntwoord.getStuurgegevens().getBerichtsoort());

        BevestigingsBericht b = new BevestigingsBericht();
        b.setStuurgegevens(asynchroonAntwoord.getStuurgegevens());

        return b;
    }

    public BevestigingsBericht ontvangFout(FoutBericht fout) {
        LOG.debug("Er is fout ontvangen van soort: " + fout.getStuurgegevens().getBerichtsoort());

        BevestigingsBericht b = new BevestigingsBericht();
        b.setStuurgegevens(fout.getStuurgegevens());

        return b;
    }

    public BevestigingsBericht ontvangKennisgeving(KennisgevingsBericht kennisgeving) {
        LOG.debug("Er is kennisgeving ontvangen van soort: " + kennisgeving.getStuurgegevens().getBerichtsoort());

        BevestigingsBericht b = new BevestigingsBericht();
        b.setStuurgegevens(kennisgeving.getStuurgegevens());

        return b;
    }

}
