//
// This file was generated by the JavaTM Architecture for XML Binding(JAXB) Reference Implementation, v2.2.8-b130911.1802 
// See <a href="http://java.sun.com/xml/jaxb">http://java.sun.com/xml/jaxb</a> 
// Any modifications to this file will be lost upon recompilation of the source schema. 
// Generated on: 2017.01.10 at 11:33:39 AM CET 
//


package nl.b3p.topnl.top10nl;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlType;


/**
 * <p>Java class for NEN3610IDType complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType name="NEN3610IDType">
 *   &lt;complexContent>
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType">
 *       &lt;sequence>
 *         &lt;element name="namespace" type="{http://www.w3.org/2001/XMLSchema}string"/>
 *         &lt;element name="lokaalID" type="{http://www.w3.org/2001/XMLSchema}string"/>
 *       &lt;/sequence>
 *     &lt;/restriction>
 *   &lt;/complexContent>
 * &lt;/complexType>
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "NEN3610IDType", namespace = "http://register.geostandaarden.nl/gmlapplicatieschema/brt-algemeen/1.2.0", propOrder = {
    "namespace",
    "lokaalID"
})
public class NEN3610IDType {

    @XmlElement(required = true)
    protected String namespace;
    @XmlElement(required = true)
    protected String lokaalID;

    /**
     * Gets the value of the namespace property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getNamespace() {
        return namespace;
    }

    /**
     * Sets the value of the namespace property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setNamespace(String value) {
        this.namespace = value;
    }

    /**
     * Gets the value of the lokaalID property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getLokaalID() {
        return lokaalID;
    }

    /**
     * Sets the value of the lokaalID property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setLokaalID(String value) {
        this.lokaalID = value;
    }

}