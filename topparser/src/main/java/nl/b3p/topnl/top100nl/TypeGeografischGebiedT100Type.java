//
// This file was generated by the JavaTM Architecture for XML Binding(JAXB) Reference Implementation, v2.2.8-b130911.1802 
// See <a href="http://java.sun.com/xml/jaxb">http://java.sun.com/xml/jaxb</a> 
// Any modifications to this file will be lost upon recompilation of the source schema. 
// Generated on: 2016.12.07 at 02:40:39 PM CET 
//


package nl.b3p.topnl.top100nl;

import javax.xml.bind.annotation.XmlEnum;
import javax.xml.bind.annotation.XmlEnumValue;
import javax.xml.bind.annotation.XmlType;


/**
 * <p>Java class for TypeGeografischGebiedT100Type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * <p>
 * <pre>
 * &lt;simpleType name="TypeGeografischGebiedT100Type">
 *   &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string">
 *     &lt;enumeration value="bosgebied"/>
 *     &lt;enumeration value="buurtschap"/>
 *     &lt;enumeration value="eiland"/>
 *     &lt;enumeration value="geul, vaargeul"/>
 *     &lt;enumeration value="huizengroep"/>
 *     &lt;enumeration value="kaap, hoek"/>
 *     &lt;enumeration value="plaats, bewoond oord"/>
 *     &lt;enumeration value="terp"/>
 *     &lt;enumeration value="woonwijk"/>
 *     &lt;enumeration value="zeegat, zeearm"/>
 *     &lt;enumeration value="overig"/>
 *   &lt;/restriction>
 * &lt;/simpleType>
 * </pre>
 * 
 */
@XmlType(name = "TypeGeografischGebiedT100Type", namespace = "http://register.geostandaarden.nl/gmlapplicatieschema/top100nl/1.1.0")
@XmlEnum
public enum TypeGeografischGebiedT100Type {

    @XmlEnumValue("bosgebied")
    BOSGEBIED("bosgebied"),
    @XmlEnumValue("buurtschap")
    BUURTSCHAP("buurtschap"),
    @XmlEnumValue("eiland")
    EILAND("eiland"),
    @XmlEnumValue("geul, vaargeul")
    GEUL_VAARGEUL("geul, vaargeul"),
    @XmlEnumValue("huizengroep")
    HUIZENGROEP("huizengroep"),
    @XmlEnumValue("kaap, hoek")
    KAAP_HOEK("kaap, hoek"),
    @XmlEnumValue("plaats, bewoond oord")
    PLAATS_BEWOOND_OORD("plaats, bewoond oord"),
    @XmlEnumValue("terp")
    TERP("terp"),
    @XmlEnumValue("woonwijk")
    WOONWIJK("woonwijk"),
    @XmlEnumValue("zeegat, zeearm")
    ZEEGAT_ZEEARM("zeegat, zeearm"),
    @XmlEnumValue("overig")
    OVERIG("overig");
    private final String value;

    TypeGeografischGebiedT100Type(String v) {
        value = v;
    }

    public String value() {
        return value;
    }

    public static TypeGeografischGebiedT100Type fromValue(String v) {
        for (TypeGeografischGebiedT100Type c: TypeGeografischGebiedT100Type.values()) {
            if (c.value.equals(v)) {
                return c;
            }
        }
        throw new IllegalArgumentException(v);
    }

}