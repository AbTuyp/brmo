//
// This file was generated by the JavaTM Architecture for XML Binding(JAXB) Reference Implementation, v2.2.8-b130911.1802 
// See <a href="http://java.sun.com/xml/jaxb">http://java.sun.com/xml/jaxb</a> 
// Any modifications to this file will be lost upon recompilation of the source schema. 
// Generated on: 2016.12.07 at 02:40:39 PM CET 
//


package nl.b3p.topnl.top100nl;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlAnyElement;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlSchemaType;
import javax.xml.bind.annotation.XmlType;
import org.w3c.dom.Element;


/**
 * <p>Java class for RegistratiefGebiedType complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType name="RegistratiefGebiedType">
 *   &lt;complexContent>
 *     &lt;extension base="{http://register.geostandaarden.nl/gmlapplicatieschema/top100nl/1.1.0}_Top100nlObjectType">
 *       &lt;sequence>
 *         &lt;element name="geometrie" type="{http://register.geostandaarden.nl/gmlapplicatieschema/top100nl/1.1.0}VlakOfMultivlakPropertyType"/>
 *         &lt;element name="naamFries" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="naamNL" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="nummer" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="typeRegistratiefGebied" type="{http://register.geostandaarden.nl/gmlapplicatieschema/top100nl/1.1.0}TypeRegistratiefGebiedT100Type"/>
 *       &lt;/sequence>
 *     &lt;/extension>
 *   &lt;/complexContent>
 * &lt;/complexType>
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "RegistratiefGebiedType", namespace = "http://register.geostandaarden.nl/gmlapplicatieschema/top100nl/1.1.0", propOrder = {
    "geometrie",
    "naamFries",
    "naamNL",
    "nummer",
    "typeRegistratiefGebied"
})
public class RegistratiefGebiedType
    extends Top100NlObjectType
{

    @XmlAnyElement
    protected Element geometrie;
    protected String naamFries;
    protected String naamNL;
    protected String nummer;
    @XmlElement(required = true)
    @XmlSchemaType(name = "string")
    protected TypeRegistratiefGebiedT100Type typeRegistratiefGebied;

    /**
     * Gets the value of the geometrie property.
     * 
     * @return
     *     possible object is
     *     {@link Element }
     *     
     */
    public Element getGeometrie() {
        return geometrie;
    }

    /**
     * Sets the value of the geometrie property.
     * 
     * @param value
     *     allowed object is
     *     {@link Element }
     *     
     */
    public void setGeometrie(Element value) {
        this.geometrie = value;
    }

    /**
     * Gets the value of the naamFries property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getNaamFries() {
        return naamFries;
    }

    /**
     * Sets the value of the naamFries property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setNaamFries(String value) {
        this.naamFries = value;
    }

    /**
     * Gets the value of the naamNL property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getNaamNL() {
        return naamNL;
    }

    /**
     * Sets the value of the naamNL property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setNaamNL(String value) {
        this.naamNL = value;
    }

    /**
     * Gets the value of the nummer property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getNummer() {
        return nummer;
    }

    /**
     * Sets the value of the nummer property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setNummer(String value) {
        this.nummer = value;
    }

    /**
     * Gets the value of the typeRegistratiefGebied property.
     * 
     * @return
     *     possible object is
     *     {@link TypeRegistratiefGebiedT100Type }
     *     
     */
    public TypeRegistratiefGebiedT100Type getTypeRegistratiefGebied() {
        return typeRegistratiefGebied;
    }

    /**
     * Sets the value of the typeRegistratiefGebied property.
     * 
     * @param value
     *     allowed object is
     *     {@link TypeRegistratiefGebiedT100Type }
     *     
     */
    public void setTypeRegistratiefGebied(TypeRegistratiefGebiedT100Type value) {
        this.typeRegistratiefGebied = value;
    }

}
