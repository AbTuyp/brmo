//
// This file was generated by the JavaTM Architecture for XML Binding(JAXB) Reference Implementation, v2.2.8-b130911.1802 
// See <a href="http://java.sun.com/xml/jaxb">http://java.sun.com/xml/jaxb</a> 
// Any modifications to this file will be lost upon recompilation of the source schema. 
// Generated on: 2016.12.07 at 02:40:39 PM CET 
//


package nl.b3p.topnl.top100nl;

import java.math.BigInteger;
import java.util.ArrayList;
import java.util.List;
import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlAnyElement;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlSchemaType;
import javax.xml.bind.annotation.XmlType;
import org.w3c.dom.Element;


/**
 * <p>Java class for SpoorbaandeelType complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType name="SpoorbaandeelType">
 *   &lt;complexContent>
 *     &lt;extension base="{http://register.geostandaarden.nl/gmlapplicatieschema/top100nl/1.1.0}_Top100nlObjectType">
 *       &lt;sequence>
 *         &lt;element name="aantalSporen" type="{http://www.w3.org/2001/XMLSchema}integer"/>
 *         &lt;element name="fysiekVoorkomen" type="{http://register.geostandaarden.nl/gmlapplicatieschema/top100nl/1.1.0}FysiekVoorkomenSpoorT100Type" maxOccurs="unbounded" minOccurs="0"/>
 *         &lt;element name="geometrie" type="{http://www.opengis.net/gml/3.2}CurvePropertyType"/>
 *         &lt;element name="hoogteniveau" type="{http://www.w3.org/2001/XMLSchema}integer"/>
 *         &lt;element name="status" type="{http://register.geostandaarden.nl/gmlapplicatieschema/top100nl/1.1.0}StatusT100Type"/>
 *         &lt;element name="typeSpoorbaan" type="{http://register.geostandaarden.nl/gmlapplicatieschema/top100nl/1.1.0}TypeSpoorbaanT100Type"/>
 *       &lt;/sequence>
 *     &lt;/extension>
 *   &lt;/complexContent>
 * &lt;/complexType>
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "SpoorbaandeelType", namespace = "http://register.geostandaarden.nl/gmlapplicatieschema/top100nl/1.1.0", propOrder = {
    "aantalSporen",
    "fysiekVoorkomen",
    "geometrie",
    "hoogteniveau",
    "status",
    "typeSpoorbaan"
})
public class SpoorbaandeelType
    extends Top100NlObjectType
{

    @XmlElement(required = true)
    protected BigInteger aantalSporen;
    @XmlSchemaType(name = "string")
    protected List<FysiekVoorkomenSpoorT100Type> fysiekVoorkomen;
    @XmlAnyElement
    protected Element geometrie;
    @XmlElement(required = true)
    protected BigInteger hoogteniveau;
    @XmlElement(required = true)
    @XmlSchemaType(name = "string")
    protected StatusT100Type status;
    @XmlElement(required = true)
    @XmlSchemaType(name = "string")
    protected TypeSpoorbaanT100Type typeSpoorbaan;

    /**
     * Gets the value of the aantalSporen property.
     * 
     * @return
     *     possible object is
     *     {@link BigInteger }
     *     
     */
    public BigInteger getAantalSporen() {
        return aantalSporen;
    }

    /**
     * Sets the value of the aantalSporen property.
     * 
     * @param value
     *     allowed object is
     *     {@link BigInteger }
     *     
     */
    public void setAantalSporen(BigInteger value) {
        this.aantalSporen = value;
    }

    /**
     * Gets the value of the fysiekVoorkomen property.
     * 
     * <p>
     * This accessor method returns a reference to the live list,
     * not a snapshot. Therefore any modification you make to the
     * returned list will be present inside the JAXB object.
     * This is why there is not a <CODE>set</CODE> method for the fysiekVoorkomen property.
     * 
     * <p>
     * For example, to add a new item, do as follows:
     * <pre>
     *    getFysiekVoorkomen().add(newItem);
     * </pre>
     * 
     * 
     * <p>
     * Objects of the following type(s) are allowed in the list
     * {@link FysiekVoorkomenSpoorT100Type }
     * 
     * 
     */
    public List<FysiekVoorkomenSpoorT100Type> getFysiekVoorkomen() {
        if (fysiekVoorkomen == null) {
            fysiekVoorkomen = new ArrayList<FysiekVoorkomenSpoorT100Type>();
        }
        return this.fysiekVoorkomen;
    }

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
     * Gets the value of the hoogteniveau property.
     * 
     * @return
     *     possible object is
     *     {@link BigInteger }
     *     
     */
    public BigInteger getHoogteniveau() {
        return hoogteniveau;
    }

    /**
     * Sets the value of the hoogteniveau property.
     * 
     * @param value
     *     allowed object is
     *     {@link BigInteger }
     *     
     */
    public void setHoogteniveau(BigInteger value) {
        this.hoogteniveau = value;
    }

    /**
     * Gets the value of the status property.
     * 
     * @return
     *     possible object is
     *     {@link StatusT100Type }
     *     
     */
    public StatusT100Type getStatus() {
        return status;
    }

    /**
     * Sets the value of the status property.
     * 
     * @param value
     *     allowed object is
     *     {@link StatusT100Type }
     *     
     */
    public void setStatus(StatusT100Type value) {
        this.status = value;
    }

    /**
     * Gets the value of the typeSpoorbaan property.
     * 
     * @return
     *     possible object is
     *     {@link TypeSpoorbaanT100Type }
     *     
     */
    public TypeSpoorbaanT100Type getTypeSpoorbaan() {
        return typeSpoorbaan;
    }

    /**
     * Sets the value of the typeSpoorbaan property.
     * 
     * @param value
     *     allowed object is
     *     {@link TypeSpoorbaanT100Type }
     *     
     */
    public void setTypeSpoorbaan(TypeSpoorbaanT100Type value) {
        this.typeSpoorbaan = value;
    }

}
