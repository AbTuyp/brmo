//
// This file was generated by the JavaTM Architecture for XML Binding(JAXB) Reference Implementation, v2.2.8-b130911.1802 
// See <a href="http://java.sun.com/xml/jaxb">http://java.sun.com/xml/jaxb</a> 
// Any modifications to this file will be lost upon recompilation of the source schema. 
// Generated on: 2016.12.07 at 01:58:16 PM CET 
//


package nl.b3p.topnl.top250nl;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlType;


/**
 * <p>Java class for BRTVlakLijnOfPuntPropertyType complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType name="BRTVlakLijnOfPuntPropertyType">
 *   &lt;complexContent>
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType">
 *       &lt;sequence>
 *         &lt;element ref="{http://register.geostandaarden.nl/gmlapplicatieschema/brt-algemeen/1.2.0}BRTVlakLijnOfPunt"/>
 *       &lt;/sequence>
 *     &lt;/restriction>
 *   &lt;/complexContent>
 * &lt;/complexType>
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "BRTVlakLijnOfPuntPropertyType", namespace = "http://register.geostandaarden.nl/gmlapplicatieschema/brt-algemeen/1.2.0", propOrder = {
    "brtVlakLijnOfPunt"
})
public class BRTVlakLijnOfPuntPropertyType {

    @XmlElement(name = "BRTVlakLijnOfPunt", required = true)
    protected BRTVlakLijnOfPuntType brtVlakLijnOfPunt;

    /**
     * Gets the value of the brtVlakLijnOfPunt property.
     * 
     * @return
     *     possible object is
     *     {@link BRTVlakLijnOfPuntType }
     *     
     */
    public BRTVlakLijnOfPuntType getBRTVlakLijnOfPunt() {
        return brtVlakLijnOfPunt;
    }

    /**
     * Sets the value of the brtVlakLijnOfPunt property.
     * 
     * @param value
     *     allowed object is
     *     {@link BRTVlakLijnOfPuntType }
     *     
     */
    public void setBRTVlakLijnOfPunt(BRTVlakLijnOfPuntType value) {
        this.brtVlakLijnOfPunt = value;
    }

}
