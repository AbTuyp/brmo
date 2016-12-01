/*
 * Copyright (C) 2016 B3Partners B.V.
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */
package nl.b3p.topnl.converters;

import com.vividsolutions.jts.geom.LineString;
import com.vividsolutions.jts.geom.Point;
import java.io.IOException;
import java.io.InputStream;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Collections;
import java.util.List;
import javax.xml.bind.JAXBException;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.transform.TransformerException;
import nl.b3p.topnl.Processor;
import nl.b3p.topnl.TopNLType;
import nl.b3p.topnl.entities.FunctioneelGebied;
import nl.b3p.topnl.entities.GeografischGebied;
import nl.b3p.topnl.entities.Hoogte;
import nl.b3p.topnl.entities.TopNLEntity;
import org.junit.After;
import org.junit.AfterClass;
import org.junit.Before;
import org.junit.BeforeClass;
import org.junit.Test;
import static org.junit.Assert.*;
import org.xml.sax.SAXException;

/**
 *
 * @author meine
 */
public class Top250NLConverterTest {
    
    private final Top250NLConverter instance;
    private final Processor processor;
    
    private SimpleDateFormat sdf;
    
    public Top250NLConverterTest() throws JAXBException {
        this.processor = new Processor(null);
        this.instance = new Top250NLConverter();
        sdf = new SimpleDateFormat("yyyy-MM-dd");
    }
    
    @BeforeClass
    public static void setUpClass() {
    }
    
    @AfterClass
    public static void tearDownClass() {
    }
    
    @Before
    public void setUp() {
    }
    
    @After
    public void tearDown() {
    }

    /**
     * Test of convert method, of class Top250NLConverter.
     */
    @Test
    public void testConvertFeatureCollection() throws IOException, SAXException, ParserConfigurationException, TransformerException, JAXBException{
        System.out.println("convert");
        Hoogte hoogte = new Hoogte();
        InputStream in = Top250NLConverterTest.class.getResourceAsStream("top250nl/FeatureCollectionHoogte.xml");
        Object jaxb = processor.parse(in);
        
        List<TopNLEntity> expResult = Collections.singletonList(hoogte);
        List<TopNLEntity> result = instance.convert(jaxb);
        assertNotNull(result);
        assertEquals(expResult.size(), result.size());
        assertEquals(expResult.get(0).getClass(), result.get(0).getClass());
    }
    
    @Test
    public void testConvertNoFeatureCollection() throws IOException, SAXException, ParserConfigurationException, TransformerException,JAXBException {
        System.out.println("convert");
        Hoogte hoogte = new Hoogte();
        InputStream in = Top250NLConverterTest.class.getResourceAsStream("top250nl/Hoogte.xml");
        Object jaxb = processor.parse(in);
        
        List<TopNLEntity> expResult = Collections.singletonList(hoogte);
        List<TopNLEntity> result = instance.convert(jaxb);
        assertNotNull(result);
        assertEquals(expResult.size(), result.size());
        assertEquals(expResult.get(0).getClass(), result.get(0).getClass());
    }

    /**
     * Test of convertHoogte method, of class Top250NLConverter.
     */
    @Test
    public void testConvertHoogte() throws IOException, SAXException, ParserConfigurationException, TransformerException,JAXBException, ParseException {
        System.out.println("convert");
        TopNLEntity expected = getStandardTestTopNLEntity();
        
        expected.setVisualisatieCode(new Long("45550"));
        
        
        TopNLEntity entity = getEntity("top250nl/Hoogte.xml");
        
        assertNotNull(entity);
        assertTrue(entity instanceof Hoogte);
        
        
        testTopNLEntity(entity, entity);
        Hoogte h = (Hoogte)entity;
          
        assertEquals( "hoogwaterlijn",h.getTypeHoogte());
        assertNotNull(h.getGeometrie());
        assertEquals( LineString.class,h.getGeometrie().getClass());
    }
    
    @Test
    public void testConvertFunctioneelGebied()throws IOException, SAXException, ParserConfigurationException, TransformerException,JAXBException, ParseException {
        System.out.println("testConvertFunctioneelGebied");
        TopNLEntity entity = getEntity("top250nl/FunctioneelGebied.xml");
        
        TopNLEntity expected = getStandardTestTopNLEntity();
        
        expected.setObjectBeginTijd( sdf.parse("2016-09-12"));
        expected.setVisualisatieCode(new Long("49390"));
        
        assertNotNull(entity);
        assertTrue(entity instanceof FunctioneelGebied);
        
        FunctioneelGebied real = (FunctioneelGebied)entity;
        
        testTopNLEntity(expected, real);
        assertEquals("productie-installatie", real.getTypeFunctioneelGebied());
        assertEquals(Point.class, real.getGeometrie().getClass());
    }
    
     @Test
    public void testConvertGeografischGebied()throws IOException, SAXException, ParserConfigurationException, TransformerException,JAXBException, ParseException {
        System.out.println("testConvertGeografischGebied");
        TopNLEntity entity = getEntity("top250nl/GeografischGebied.xml");
        
        TopNLEntity expected = getStandardTestTopNLEntity();
        
        expected.setVisualisatieCode(new Long("48190"));
        
        assertNotNull(entity);
        assertTrue(entity instanceof GeografischGebied);
        
        GeografischGebied real = (GeografischGebied)entity;
        
        testTopNLEntity(expected, real);
        assertEquals("zeegat, zeearm", real.getTypeGeografischGebied());
        assertEquals("Waddenzee", real.getNaamNL());
        assertEquals(Point.class, real.getGeometrie().getClass());
    }
    
    
    public void testTopNLEntity(TopNLEntity expected, TopNLEntity real){
        assertEquals( expected.getTopnltype(),real.getTopnltype());
        
        assertEquals( expected.getId(),real.getId());
        assertEquals( expected.getIdentificatie(),real.getIdentificatie());
        assertEquals( expected.getBrontype(),real.getBrontype());
        assertEquals( expected.getBronactualiteit(),real.getBronactualiteit());
        assertEquals( expected.getBronbeschrijving(),real.getBronbeschrijving());
        assertEquals( expected.getBronnauwkeurigheid(),real.getBronnauwkeurigheid());
        assertEquals( expected.getObjectBeginTijd(),real.getObjectBeginTijd());
        assertEquals( expected.getObjectEindTijd(),real.getObjectEindTijd());
        assertEquals( expected.getVisualisatieCode(),real.getVisualisatieCode());
    }
    
    
    /*
    top250nl:FunctioneelGebied
    top250nl:Hoogte
    top250nl:Gebouw
    top250nl:Inrichtingselement
    top250nl:Plaats
    top250nl:GeografischGebied
    
    top250nl:RegistratiefGebied
    top250nl:Relief
    top250nl:Spoorbaandeel
    top250nl:Terrein
    top250nl:Waterdeel
    top250nl:Wegdeel

    */
    
    private TopNLEntity getEntity(String file) throws JAXBException, IOException, SAXException, ParserConfigurationException, TransformerException{
        InputStream in = Top250NLConverterTest.class.getResourceAsStream(file);
        Object jaxb = processor.parse(in);
        TopNLEntity entity = instance.convertObject(jaxb);
        return entity;
    }
    
    private TopNLEntity getStandardTestTopNLEntity() throws ParseException{
        TopNLEntity expected = new TopNLEntity() {};
        
        expected.setIdentificatie( "NL.TOP250NL.16R09-0000084248");
        expected.setTopnltype(TopNLType.TOP250NL.getType());
        expected.setBrontype("TOP50NL");
        expected.setBronactualiteit( sdf.parse("2016-09-01"));
        expected.setBronbeschrijving("TOP50NL wordt als bron gebruikt bij het bijwerken van EuroRegionalMap (ERM). Via een automatisch proces worden de gegevens van ERM omgezet naar TOP250NL");
        expected.setBronnauwkeurigheid(125.0);
        expected.setObjectBeginTijd( sdf.parse("2016-09-12"));
        return expected;
    }
}
