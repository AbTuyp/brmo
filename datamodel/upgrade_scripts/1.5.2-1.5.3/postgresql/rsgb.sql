--
-- upgrade PostgreSQL RSGB datamodel van 1.5.2 naar 1.5.3
--

DROP VIEW v_adres_totaal_vlak;
DROP VIEW v_adres_totaal;
DROP VIEW v_adres_standplaats;
DROP VIEW v_adres_ligplaats;
DROP VIEW v_adres;
DROP VIEW v_ligplaats;
DROP VIEW v_standplaats;
DROP VIEW v_ligplaats_alles;
DROP VIEW v_standplaats_alles;
DROP VIEW v_pand_gebruik_niet_ingemeten;
DROP VIEW v_pand_in_gebruik;
DROP VIEW v_verblijfsobject;
DROP VIEW v_verblijfsobject_gevormd;
DROP VIEW v_verblijfsobject_alles;


drop VIEW V_KAD_EIGENARENKAART;

drop VIEW v_bd_kad_perceel_met_app;
drop VIEW v_bd_kad_perceel_met_app_vlak;
drop VIEW v_bd_kad_perceel_with_app_re;
drop VIEW v_bd_app_re_bij_perceel;
drop VIEW v_bd_app_re_and_kad_perceel;
drop VIEW v_bd_app_re_all_kad_perceel ;
drop VIEW v_bd_app_re_app_re;

drop view v_kad_perceel_in_eigendom;
drop view v_kad_perceel_zr_adressen;
drop view kad_perceel_app_rechten;
drop view v_kad_perceel_eenvoudig;
drop view v_kad_perceel_adres;
drop view v_kad_perceel_zak_recht;
drop VIEW v_aankoopdatum;
drop view v_map_kad_perceel;

alter table ander_btnlnds_niet_nat_prs alter column sc_identif type character varying (255);
alter table ander_nat_prs alter column sc_identif type character varying (255);
alter table app_re alter column fk_2nnp_sc_identif type character varying (255);
alter table ingeschr_niet_nat_prs alter column sc_identif type character varying (255);
alter table ingeschr_nat_prs alter column sc_identif type character varying (255);
alter table ingezetene alter column sc_identif type character varying (255);
alter table kad_onrrnd_zk alter column fk_10pes_sc_identif type character varying (255);
alter table kad_onrrnd_zk_aantek alter column fk_5pes_sc_identif type character varying (255);
alter table maatschapp_activiteit alter column fk_4pes_sc_identif type character varying (255);
alter table nat_prs alter column sc_identif type character varying (255);
alter table niet_ingezetene alter column sc_identif type character varying (255);
alter table niet_nat_prs alter column sc_identif type character varying (255);
alter table prs alter column  sc_identif type character varying (255);
alter table subject alter column identif type character varying (255);
alter table vestg alter column  sc_identif type character varying (255);
alter table vestg alter column fk_18ves_sc_identif type character varying (255);
alter table zak_recht alter column fk_8pes_sc_identif type character varying (255);
alter table zak_recht_aantek alter column fk_6pes_sc_identif type character varying (255);
alter table vestg_naam alter column fk_ves_sc_identif type character varying (255);
alter table huishoudenrel alter column fk_sc_lh_inp_sc_identif type character varying (255);
alter table huw_ger_partn alter column fk_sc_lh_inp_sc_identif type character varying (255);
alter table huw_ger_partn alter column fk_sc_rh_inp_sc_identif type character varying (255);
alter table ouder_kind_rel alter column fk_sc_lh_inp_sc_identif type character varying (255);
alter table ouder_kind_rel alter column fk_sc_rh_inp_sc_identif type character varying (255);
alter table rsdoc_ingeschr_nat_prs alter column fk_nn_rh_inp_sc_identif type character varying (255);
alter table vestg_benoemd_obj alter column fk_nn_lh_ves_sc_identif type character varying (255);

/*
Views for visualizing the BAG data.
25-06-2015
*/
-- DROP VIEWS
-- DROP VIEW v_adres_totaal_vlak;
-- DROP VIEW v_adres_totaal;
-- DROP VIEW v_adres_standplaats;
-- DROP VIEW v_adres_ligplaats;
-- DROP VIEW v_adres;
-- DROP VIEW v_ligplaats;
-- DROP VIEW v_standplaats;
-- DROP VIEW v_ligplaats_alles;
-- DROP VIEW v_standplaats_alles;
-- DROP VIEW v_pand_gebruik_niet_ingemeten;
-- DROP VIEW v_pand_in_gebruik;
-- DROP VIEW v_verblijfsobject;
-- DROP VIEW v_verblijfsobject_gevormd;
-- DROP VIEW v_verblijfsobject_alles;

-------------------------------------------------
-- v_verblijfsobject_alles
-------------------------------------------------
CREATE OR REPLACE VIEW
    v_verblijfsobject_alles
    (
        objectid,
        fid,
        pand_id,
        gemeente,
        woonplaats,
        straatnaam,
        huisnummer,
        huisletter,
        huisnummer_toev,
        postcode,
        status,
        oppervlakte,
        the_geom
    ) AS
SELECT
    (row_number() OVER ())::integer AS objectid,
    vbo.sc_identif              AS fid,
    fkpand.fk_nn_rh_pnd_identif AS pand_id,
    gem.naam                    AS gemeente,
    CASE
        WHEN addrobj.fk_6wpl_identif IS NOT NULL
        -- opzoeken want in andere woonplaats
        THEN  (select naam from wnplts where identif = fk_6wpl_identif)
        ELSE wp.naam
    END                         AS woonplaats,
    geor.naam_openb_rmte        AS straatnaam,
    addrobj.huinummer           AS huisnummer,
    addrobj.huisletter,
    addrobj.huinummertoevoeging AS huisnummer_toev,
    addrobj.postcode,
    vbo.status,
    gobj.oppervlakte_obj AS oppervlakte,
    gobj.puntgeom        AS the_geom
FROM
    ((((((((verblijfsobj vbo
JOIN
    verblijfsobj_pand fkpand
ON
    ((fkpand.fk_nn_lh_vbo_sc_identif = vbo.sc_identif)))
JOIN
    gebouwd_obj gobj
ON
    ((gobj.sc_identif = vbo.sc_identif)))
JOIN
    nummeraand na
ON
    ((na.sc_identif = vbo.fk_11nra_sc_identif)))
JOIN
    addresseerb_obj_aand addrobj
ON
    ((addrobj.identif = na.sc_identif)))
JOIN
    gem_openb_rmte geor
ON
    ((geor.identifcode = addrobj.fk_7opr_identifcode)))
LEFT JOIN
    openb_rmte_wnplts orwp
ON
    ((geor.identifcode = orwp.fk_nn_lh_opr_identifcode)))
LEFT JOIN
    wnplts wp
ON
    ((orwp.fk_nn_rh_wpl_identif = wp.identif)))
LEFT JOIN
    gemeente gem
ON
    ((
            wp.fk_7gem_code = gem.code)))
WHERE
    ((((
                    addrobj.dat_eind_geldh IS NULL)
            AND (
                    geor.datum_einde_geldh IS NULL))
        AND (
                gem.datum_einde_geldh IS NULL))
    AND (
            gobj.datum_einde_geldh IS NULL));
-------------------------------------------------
-- v_verblijfsobject_gevormd
-------------------------------------------------
CREATE OR REPLACE VIEW
    v_verblijfsobject_gevormd
    (
        objectid,
        fid,
        pand_id,
        gemeente,
        woonplaats,
        straatnaam,
        huisnummer,
        huisletter,
        huisnummer_toev,
        postcode,
        --gebruiksdoel,
        status,
        oppervlakte,
        the_geom
    ) AS
SELECT
    objectid,
    fid,
    pand_id,
    gemeente,
    woonplaats,
    straatnaam,
    huisnummer,
    huisletter,
    huisnummer_toev,
    postcode,
    --gebruiksdoel,
    status,
    oppervlakte,
    the_geom
FROM
    v_verblijfsobject_alles
WHERE
    status = 'Verblijfsobject gevormd';
-------------------------------------------------
-- v_verblijfsobject
-------------------------------------------------
CREATE OR REPLACE VIEW
    v_verblijfsobject
    (
        objectid,
        fid,
        pand_id,
        gemeente,
        woonplaats,
        straatnaam,
        huisnummer,
        huisletter,
        huisnummer_toev,
        postcode,
        --gebruiksdoel,
        status,
        oppervlakte,
        the_geom
    ) AS
SELECT
    objectid,
    fid,
    pand_id,
    gemeente,
    woonplaats,
    straatnaam,
    huisnummer,
    huisletter,
    huisnummer_toev,
    postcode,
    --gebruiksdoel,
    status,
    oppervlakte,
    the_geom
FROM
    v_verblijfsobject_alles
WHERE
    status = 'Verblijfsobject in gebruik (niet ingemeten)'
OR  status = 'Verblijfsobject in gebruik';
-------------------------------------------------
-- v_pand_in_gebruik
-------------------------------------------------
CREATE VIEW
    v_pand_in_gebruik
    (
        objectid,
        fid,
        eind_datum_geldig,
        begin_datum_geldig,
        status,
        bouwjaar,
        the_geom
    ) AS
SELECT
    (row_number() OVER ())::integer AS ObjectID,
    p.identif           AS fid,
    p.datum_einde_geldh AS eind_datum_geldig,
    p.dat_beg_geldh     AS begin_datum_geldig,
    p.status,
    p.oorspronkelijk_bouwjaar AS bouwjaar,
    p.geom_bovenaanzicht      AS the_geom
FROM
    pand p
WHERE
    status IN ('Sloopvergunning verleend',
               'Pand in gebruik (niet ingemeten)',
               'Pand in gebruik',
               'Bouw gestart')
AND datum_einde_geldh IS NULL;
-------------------------------------------------
-- v_pand_gebruik_niet_ingemeten
-------------------------------------------------
CREATE OR REPLACE VIEW
    v_pand_gebruik_niet_ingemeten
    (
        objectid,
        fid,
        begin_datum_geldig,
        status,
        bouwjaar,
        the_geom
    ) AS
SELECT
    (row_number() OVER ())::integer AS ObjectID,
    p.identif       AS fid,
    p.dat_beg_geldh AS begin_datum_geldig,
    p.status,
    p.oorspronkelijk_bouwjaar AS bouwjaar,
    p.geom_bovenaanzicht      AS the_geom
FROM
    pand p
WHERE
    status = 'Pand in gebruik (niet ingemeten)'
AND datum_einde_geldh IS NULL;
-------------------------------------------------
-- v_standplaats
-------------------------------------------------
CREATE OR REPLACE VIEW
    v_standplaats
    (
        objectid,
        sc_identif,
        status,
        fk_4nra_sc_identif,
        datum_begin_geldh,
        geometrie
    ) AS
SELECT
    (row_number() OVER ())::integer AS ObjectID,
    sp.sc_identif,
    sp.status,
    sp.fk_4nra_sc_identif,
    bt.dat_beg_geldh,
    bt.geom AS geometrie
FROM
    standplaats sp
LEFT JOIN
    benoemd_terrein bt
ON
    (
        sp.sc_identif = bt.sc_identif);
-------------------------------------------------
-- v_ligplaats
-------------------------------------------------
CREATE OR REPLACE VIEW
    v_ligplaats
    (
        objectid,
        sc_identif,
        status,
        fk_4nra_sc_identif,
        dat_beg_geldh,
        geometrie
    ) AS
SELECT
    (row_number() OVER ())::integer AS ObjectID,
    lp.sc_identif,
    lp.status,
    lp.fk_4nra_sc_identif,
    bt.dat_beg_geldh,
    bt.geom AS geometrie
FROM
    ligplaats lp
LEFT JOIN
    benoemd_terrein bt
ON
    (
        lp.sc_identif = bt.sc_identif) ;
-------------------------------------------------
-- v_ligplaats_alles
-------------------------------------------------
/*
ligplaats met hoofdadres
*/
CREATE OR REPLACE VIEW
    v_ligplaats_alles
    (
        objectid,
        fid,
        gemeente,
        woonplaats,
        straatnaam,
        huisnummer,
        huisletter,
        huisnummer_toev,
        postcode,
        status,
        the_geom
    ) AS
SELECT
    (row_number() OVER ())::integer AS ObjectID,
    lp.sc_identif        AS fid,
    gem.naam             AS gemeente,
    CASE
        WHEN addrobj.fk_6wpl_identif IS NOT NULL
        -- opzoeken want in andere woonplaats
        THEN  (select naam from wnplts where identif = fk_6wpl_identif)
        ELSE wp.naam
    END                  AS woonplaats,
    geor.naam_openb_rmte AS straatnaam,
    addrobj.huinummer    AS huisnummer,
    addrobj.huisletter,
    addrobj.huinummertoevoeging AS huisnummer_toev,
    addrobj.postcode,
    lp.status,
    bt.geom AS the_geom
FROM
    (((((((ligplaats lp
JOIN
    benoemd_terrein bt
ON
    ((lp.sc_identif = bt.sc_identif)))
JOIN
    nummeraand na
ON
    ((na.sc_identif = lp.fk_4nra_sc_identif)))
JOIN
    addresseerb_obj_aand addrobj
ON
    ((addrobj.identif = na.sc_identif)))
JOIN
    gem_openb_rmte geor
ON
    ((geor.identifcode = addrobj.fk_7opr_identifcode)))
LEFT JOIN
    openb_rmte_wnplts orwp
ON
    ((geor.identifcode = orwp.fk_nn_lh_opr_identifcode)))
LEFT JOIN
    wnplts wp
ON
    ((orwp.fk_nn_rh_wpl_identif = wp.identif)))
LEFT JOIN
    gemeente gem
ON
    ((
            wp.fk_7gem_code = gem.code)))
WHERE
    ((((
                    addrobj.dat_eind_geldh IS NULL)
            AND (
                    geor.datum_einde_geldh IS NULL))
        AND (
                gem.datum_einde_geldh IS NULL))
    AND (
            bt.datum_einde_geldh IS NULL));
-------------------------------------------------
-- v_standplaats_alles
-------------------------------------------------
/*
standplaats met hoofdadres
*/
CREATE OR REPLACE VIEW
    v_standplaats_alles
    (
        objectid,
        fid,
        gemeente,
        woonplaats,
        straatnaam,
        huisnummer,
        huisletter,
        huisnummer_toev,
        postcode,
        status,
        the_geom
    ) AS
SELECT
    (row_number() OVER ())::integer AS ObjectID,
    sp.sc_identif        AS fid,
    gem.naam             AS gemeente,
    CASE
        WHEN addrobj.fk_6wpl_identif IS NOT NULL
        -- opzoeken want in andere woonplaats
        THEN  (select naam from wnplts where identif = fk_6wpl_identif)
        ELSE wp.naam
    END                  AS woonplaats,
    geor.naam_openb_rmte AS straatnaam,
    addrobj.huinummer    AS huisnummer,
    addrobj.huisletter,
    addrobj.huinummertoevoeging AS huisnummer_toev,
    addrobj.postcode,
    sp.status,
    bt.geom AS the_geom
FROM
    (((((((standplaats sp
JOIN
    benoemd_terrein bt
ON
    ((sp.sc_identif = bt.sc_identif)))
JOIN
    nummeraand na
ON
    ((na.sc_identif = sp.fk_4nra_sc_identif)))
JOIN
    addresseerb_obj_aand addrobj
ON
    ((addrobj.identif = na.sc_identif)))
JOIN
    gem_openb_rmte geor
ON
    ((geor.identifcode = addrobj.fk_7opr_identifcode)))
LEFT JOIN
    openb_rmte_wnplts orwp
ON
    ((geor.identifcode = orwp.fk_nn_lh_opr_identifcode)))
LEFT JOIN
    wnplts wp
ON
    ((orwp.fk_nn_rh_wpl_identif = wp.identif)))
LEFT JOIN
    gemeente gem
ON
    ((
            wp.fk_7gem_code = gem.code)))
WHERE
    ((((
                    addrobj.dat_eind_geldh IS NULL)
            AND (
                    geor.datum_einde_geldh IS NULL))
        AND (
                gem.datum_einde_geldh IS NULL))
    AND (
            bt.datum_einde_geldh IS NULL));
-------------------------------------------------
-- v_adres
-------------------------------------------------
/*
volledige adressenlijst
standplaats en ligplaats via benoemd_terrein,
waarbij centroide van polygon wordt genomen
plus verblijfsobject via punt object van gebouwd_obj
*/
CREATE OR REPLACE VIEW
    v_adres
    (
        objectid,
        fid,
        gemeente,
        woonplaats,
        straatnaam,
        huisnummer,
        huisletter,
        huisnummer_toev,
        postcode,
        status,
        oppervlakte,
        the_geom
    ) AS
SELECT
    (row_number() OVER ())::integer AS ObjectID,
    vbo.sc_identif       AS fid,
    gem.naam             AS gemeente,
    CASE
        WHEN addrobj.fk_6wpl_identif IS NOT NULL
        -- opzoeken want in andere woonplaats
        THEN  (select naam from wnplts where identif = fk_6wpl_identif)
        ELSE wp.naam
    END                  AS woonplaats,
    geor.naam_openb_rmte AS straatnaam,
    addrobj.huinummer    AS huisnummer,
    addrobj.huisletter,
    addrobj.huinummertoevoeging AS huisnummer_toev,
    addrobj.postcode,
    vbo.status,
    gobj.oppervlakte_obj || ' m2' AS oppervlakte,
    gobj.puntgeom                 AS the_geom
FROM
    verblijfsobj vbo
JOIN
    gebouwd_obj gobj
ON
    (
        gobj.sc_identif = vbo.sc_identif )
LEFT JOIN
    verblijfsobj_nummeraand vna
ON
    (
        vna.fk_nn_lh_vbo_sc_identif = vbo.sc_identif )
LEFT JOIN
    nummeraand na
ON
    (
        na.sc_identif = vbo.fk_11nra_sc_identif)
LEFT JOIN
    addresseerb_obj_aand addrobj
ON
    (
        addrobj.identif = na.sc_identif )
JOIN
    gem_openb_rmte geor
ON
    (
        geor.identifcode = addrobj.fk_7opr_identifcode )
LEFT JOIN
    openb_rmte_wnplts orwp
ON
    (
        geor.identifcode = orwp.fk_nn_lh_opr_identifcode)
LEFT JOIN
    wnplts wp
ON
    (
        orwp.fk_nn_rh_wpl_identif = wp.identif)
LEFT JOIN
    gemeente gem
ON
    (
        wp.fk_7gem_code = gem.code )
WHERE
    na.status = 'Naamgeving uitgegeven'
AND (
        vbo.status = 'Verblijfsobject in gebruik (niet ingemeten)'
    OR  vbo.status = 'Verblijfsobject in gebruik');
-------------------------------------------------
-- v_adres_ligplaats
-------------------------------------------------
CREATE VIEW
    v_adres_ligplaats
    (
        fid,
        gemeente,
        woonplaats,
        straatnaam,
        huisnummer,
        huisletter,
        huisnummer_toev,
        postcode,
        status,
        the_geom,
        centroide
    ) AS
SELECT
    lpa.sc_identif       AS fid,
    gem.naam             AS gemeente,
    CASE
        WHEN addrobj.fk_6wpl_identif IS NOT NULL
        -- opzoeken want in andere woonplaats
        THEN  (select naam from wnplts where identif = fk_6wpl_identif)
        ELSE wp.naam
    END                  AS woonplaats,
    geor.naam_openb_rmte AS straatnaam,
    addrobj.huinummer    AS huisnummer,
    addrobj.huisletter,
    addrobj.huinummertoevoeging AS huisnummer_toev,
    addrobj.postcode,
    lpa.status,
    benter.geom AS the_geom,
    st_centroid(benter.geom)
FROM
    ligplaats lpa
JOIN
    benoemd_terrein benter
ON
    (
        benter.sc_identif = lpa.sc_identif )
LEFT JOIN
    ligplaats_nummeraand lna
ON
    (
        lna.fk_nn_lh_lpl_sc_identif = lpa.sc_identif )
LEFT JOIN
    nummeraand na
ON
    (
        na.sc_identif = lpa.fk_4nra_sc_identif )
LEFT JOIN
    addresseerb_obj_aand addrobj
ON
    (
        addrobj.identif = na.sc_identif )
JOIN
    gem_openb_rmte geor
ON
    (
        geor.identifcode = addrobj.fk_7opr_identifcode )
LEFT JOIN
    openb_rmte_wnplts orwp
ON
    (
        geor.identifcode = orwp.fk_nn_lh_opr_identifcode)
LEFT JOIN
    wnplts wp
ON
    (
        orwp.fk_nn_rh_wpl_identif = wp.identif)
LEFT JOIN
    gemeente gem
ON
    (
        wp.fk_7gem_code = gem.code )
WHERE
    na.status = 'Naamgeving uitgegeven'
AND lpa.status = 'Plaats aangewezen';
-------------------------------------------------
-- v_adres_standplaats
-------------------------------------------------
CREATE VIEW
    v_adres_standplaats
    (
        fid,
        gemeente,
        woonplaats,
        straatnaam,
        huisnummer,
        huisletter,
        huisnummer_toev,
        postcode,
        status,
        the_geom,
        centroide
    ) AS
SELECT
    spl.sc_identif       AS fid,
    gem.naam             AS gemeente,
    CASE
        WHEN addrobj.fk_6wpl_identif IS NOT NULL
        -- opzoeken want in andere woonplaats
        THEN  (select naam from wnplts where identif = fk_6wpl_identif)
        ELSE wp.naam
    END                  AS woonplaats,
    geor.naam_openb_rmte AS straatnaam,
    addrobj.huinummer    AS huisnummer,
    addrobj.huisletter,
    addrobj.huinummertoevoeging AS huisnummer_toev,
    addrobj.postcode,
    spl.status,
    benter.geom AS the_geom,
    st_centroid(benter.geom)
FROM
    standplaats spl
JOIN
    benoemd_terrein benter
ON
    (
        benter.sc_identif = spl.sc_identif )
LEFT JOIN
    standplaats_nummeraand sna
ON
    (
        sna.fk_nn_lh_spl_sc_identif = spl.sc_identif )
LEFT JOIN
    nummeraand na
ON
    (
        na.sc_identif = spl.fk_4nra_sc_identif )
LEFT JOIN
    addresseerb_obj_aand addrobj
ON
    (
        addrobj.identif = na.sc_identif )
JOIN
    gem_openb_rmte geor
ON
    (
        geor.identifcode = addrobj.fk_7opr_identifcode )
LEFT JOIN
    openb_rmte_wnplts orwp
ON
    (
        geor.identifcode = orwp.fk_nn_lh_opr_identifcode)
LEFT JOIN
    wnplts wp
ON
    (
        orwp.fk_nn_rh_wpl_identif = wp.identif)
LEFT JOIN
    gemeente gem
ON
    (
        wp.fk_7gem_code = gem.code )
WHERE
    na.status = 'Naamgeving uitgegeven'
AND spl.status = 'Plaats aangewezen';
-------------------------------------------------
-- v_adres_totaal
-------------------------------------------------
CREATE VIEW
    v_adres_totaal
    (
        objectid,
        fid,
        straatnaam,
        huisnummer,
        huisletter,
        huisnummer_toev,
        postcode,
        gemeente,
        woonplaats,
        the_geom
    ) AS
SELECT
    (row_number() OVER ())::integer AS ObjectID,
    qry.*
    FROM (
        SELECT
            fid,
            straatnaam,
            huisnummer,
            huisletter,
            huisnummer_toev,
            postcode,
            gemeente,
            woonplaats,
            the_geom
        FROM
            v_adres
        UNION ALL
        SELECT
            fid ,
            straatnaam,
            huisnummer,
            huisletter,
            huisnummer_toev,
            postcode,
            gemeente,
            woonplaats,
            centroide AS the_geom
        FROM
            v_adres_ligplaats
        UNION ALL
        SELECT
            fid ,
            straatnaam,
            huisnummer,
            huisletter,
            huisnummer_toev,
            postcode,
            gemeente,
            woonplaats,
            centroide AS the_geom
        FROM
            v_adres_standplaats
    ) qry;

-------------------------------------------------
-- v_adres_pandvlak: adressen met (bovenaanzicht) pandvlak
-------------------------------------------------
CREATE OR REPLACE VIEW
    v_adres_pandvlak
    (
        objectid,
        fid,
        pand_id,
        gemeente,
        woonplaats,
        straatnaam,
        huisnummer,
        huisletter,
        huisnummer_toev,
        postcode,
        status,
        the_geom
    ) AS
SELECT
    (row_number() OVER ())::integer AS ObjectID,
    vbo.sc_identif       AS fid,
    fkpand.fk_nn_rh_pnd_identif AS pand_id,
    gem.naam             AS gemeente,
    CASE
        WHEN addrobj.fk_6wpl_identif IS NOT NULL
        -- opzoeken want in andere woonplaats
        THEN  (select naam from wnplts where identif = fk_6wpl_identif)
        ELSE wp.naam
    END                  AS woonplaats,
    geor.naam_openb_rmte AS straatnaam,
    addrobj.huinummer    AS huisnummer,
    addrobj.huisletter,
    addrobj.huinummertoevoeging AS huisnummer_toev,
    addrobj.postcode,
    vbo.status,
    pand.geom_bovenaanzicht AS the_geom
FROM (
    verblijfsobj vbo
JOIN
    verblijfsobj_pand fkpand
ON
    (fkpand.fk_nn_lh_vbo_sc_identif = vbo.sc_identif)
JOIN
    pand
ON
    (fkpand.fk_nn_rh_pnd_identif = pand.identif)
)
LEFT JOIN
    verblijfsobj_nummeraand vna
ON
    (vna.fk_nn_lh_vbo_sc_identif = vbo.sc_identif)

LEFT JOIN
    nummeraand na
ON
    (na.sc_identif = vbo.fk_11nra_sc_identif)

LEFT JOIN
    addresseerb_obj_aand addrobj
ON
    (addrobj.identif = na.sc_identif)
JOIN
    gem_openb_rmte geor
ON
    ( geor.identifcode = addrobj.fk_7opr_identifcode )

LEFT JOIN
    openb_rmte_wnplts orwp
ON
    ( geor.identifcode = orwp.fk_nn_lh_opr_identifcode)

LEFT JOIN
    wnplts wp
ON
    ( orwp.fk_nn_rh_wpl_identif = wp.identif)

LEFT JOIN
    gemeente gem
ON
    ( wp.fk_7gem_code = gem.code )
WHERE
    na.status = 'Naamgeving uitgegeven'
AND ( vbo.status = 'Verblijfsobject in gebruik (niet ingemeten)'
    OR  vbo.status = 'Verblijfsobject in gebruik');

-------------------------------------------------
-- v_adres_totaal_vlak: adressen met bovenaanzicht vlak van pand
--   of openbare ruimte in geval stand of ligplaats
-------------------------------------------------
CREATE OR REPLACE VIEW v_adres_totaal_vlak
    (
        objectid,
        fid,
        straatnaam,
        huisnummer,
        huisletter,
        huisnummer_toev,
        postcode,
        gemeente,
        woonplaats,
        the_geom
    ) AS
SELECT
    (row_number() OVER ())::integer AS ObjectID,
    qry.*
    FROM (
        SELECT
            fid,
            straatnaam,
            huisnummer,
            huisletter,
            huisnummer_toev,
            postcode,
            gemeente,
            woonplaats,
            the_geom
        FROM
            v_adres_pandvlak
        UNION ALL
        SELECT
            fid ,
            straatnaam,
            huisnummer,
            huisletter,
            huisnummer_toev,
            postcode,
            gemeente,
            woonplaats,
            the_geom
        FROM
            v_adres_ligplaats
        UNION ALL
        SELECT
            fid ,
            straatnaam,
            huisnummer,
            huisletter,
            huisnummer_toev,
            postcode,
            gemeente,
            woonplaats,
            the_geom
        FROM
            v_adres_standplaats
    ) qry;



create view v_map_kad_perceel as
select
   (row_number() OVER ())::integer AS ObjectID,
    p.sc_kad_identif,
    p.begrenzing_perceel,
    p.ka_sectie || ' ' || p.ka_perceelnummer AS aanduiding,
    p.grootte_perceel,
    z.ks_koopjaar,
    z.ks_bedrag,
    z.cu_aard_cultuur_onbebouwd
from kad_perceel p
join kad_onrrnd_zk z on (z.kad_identif = p.sc_kad_identif);

create table prs_eigendom (
    fk_prs_sc_identif varchar(32),
    primary key (fk_prs_sc_identif),
    foreign key (fk_prs_sc_identif) references prs(sc_identif)
);

create or replace view v_kad_perceel_in_eigendom as
select
    (row_number() OVER ())::integer AS ObjectID,
    p.begrenzing_perceel,
    p.sc_kad_identif,
    p.aanduiding,
    p.grootte_perceel,
    p.ks_koopjaar,
    p.ks_bedrag,
    p.cu_aard_cultuur_onbebouwd,
    nnprs.naam
from v_map_kad_perceel p
join zak_recht zr on (zr.fk_7koz_kad_identif = p.sc_kad_identif)
join prs_eigendom prs_e on (prs_e.fk_prs_sc_identif = zr.fk_8pes_sc_identif)
left join niet_nat_prs nnprs on (nnprs.sc_identif = prs_e.fk_prs_sc_identif);

create or replace view v_kad_perceel_adres as
select distinct
        kp.sc_kad_identif,
        kpvbo.FK_NN_LH_TGO_IDENTIF as kad_bag_koppeling_benobj,
        gor.naam_openb_rmte as straat,
        aoa.huinummer as huisnummer,
        aoa.huisletter,
        aoa.huinummertoevoeging as toevoeging,
        aoa.postcode,
        wp.naam as woonplaats
from kad_perceel kp
left join benoemd_obj_kad_onrrnd_zk kpvbo on (kpvbo.FK_NN_RH_KOZ_KAD_IDENTIF = kp.SC_KAD_IDENTIF)
left join verblijfsobj vbo on (vbo.SC_IDENTIF = kpvbo.FK_NN_LH_TGO_IDENTIF)
left join nummeraand na on (na.SC_IDENTIF = vbo.FK_11NRA_SC_IDENTIF)
left join addresseerb_obj_aand aoa on (aoa.IDENTIF = na.SC_IDENTIF)
left join gem_openb_rmte gor on (gor.IDENTIFCODE = aoa.FK_7OPR_IDENTIFCODE)
left join openb_rmte_wnplts oprw on (oprw.fk_nn_lh_opr_identifcode = gor.IDENTIFCODE)
left join wnplts wp on (wp.IDENTIF = oprw.fk_nn_rh_wpl_identif);

create or replace view v_kad_perceel_eenvoudig as
select
        (row_number() OVER ())::integer AS ObjectID,
        p.sc_kad_identif,
        p.begrenzing_perceel,
        p.ka_sectie || ' ' || p.ka_perceelnummer AS aanduiding,
        p.grootte_perceel,
        p_adr.kad_bag_koppeling_benobj,
        p_adr.straat,
        p_adr.huisnummer,
        p_adr.huisletter,
        p_adr.toevoeging,
        p_adr.postcode,
        p_adr.woonplaats
from kad_perceel p
join v_kad_perceel_adres p_adr on (p_adr.sc_kad_identif = p.sc_kad_identif);

create or replace view v_kad_perceel_zak_recht as
  select
    p.sc_kad_identif as Kadaster_identificatie,
    zr.AR_TELLER  as Aandeel_teller,
    zr.AR_NOEMER as Aandeel_noemer,
    zr.FK_3AVR_AAND as Aard_recht_aand,
--    ark.omschr as Aard_recht_omschrijving_verkort, XXX referentielijst niet gevuld
--    ar.omschr_aard_verkregenr_recht as Aard_recht_omschrijving, XXX referentielijst niet gevuld
    case when np.sc_identif is not null then 'Natuurlijk persoon' else 'Niet natuurlijk persoon' end as soort_eigenaar,
    np.NM_GESLACHTSNAAM as Geslachtsnaam,
    np.NM_VOORVOEGSEL_GESLACHTSNAAM as Voorvoegsel,
    np.NM_VOORNAMEN as Voornamen,
    np.GESLACHTSAAND as Geslacht,
    inp.VA_LOC_BESCHRIJVING as Woonadres,
    inp.GB_GEBOORTEDATUM as Geboortedatum,
--    inp.GB_GEBOORTELAND as Code_geboorteland, XXX in XSL conversie naar 2-letterige ISO code
    inp.GB_GEBOORTEPLAATS as Geboorteplaats,
    inp.OL_OVERLIJDENSDATUM as Overlijdensdatum,
    nnp.NAAM as Naam_niet_natuurlijk_persoon,
    innp.RECHTSVORM as Rechtsvorm,
    innp.STATUTAIRE_ZETEL as Statutaire_zetel,
    innp_subject.kvk_nummer
  from kad_perceel p
  join zak_recht zr on (zr.FK_7KOZ_KAD_IDENTIF = p.sc_kad_identif)
  left join aard_recht_verkort ark on (zr.FK_3AVR_AAND = ark.AAND)
  left join aard_verkregen_recht ar on (zr.FK_3AVR_AAND = ar.AAND)
  left join nat_prs np on (np.SC_IDENTIF = zr.FK_8PES_SC_IDENTIF)
  left join ingeschr_nat_prs inp on (inp.SC_IDENTIF = np.SC_IDENTIF)
  left join niet_nat_prs nnp on (nnp.sc_identif = zr.FK_8PES_SC_IDENTIF)
  left join ingeschr_niet_nat_prs innp on (innp.SC_IDENTIF = nnp.sc_identif)
  left join subject innp_subject on (innp_subject.identif = innp.sc_identif)
  where np.NM_GESLACHTSNAAM is not null or nnp.NAAM is not null;

create or replace view v_kad_perceel_zr_adressen as
select
  (row_number() OVER ())::integer AS ObjectID,
  kp.SC_KAD_IDENTIF,
  kp.BEGRENZING_PERCEEL,
  kp.AANDUIDING,
  kp.GROOTTE_PERCEEL,
  kp.STRAAT,
  kp.HUISNUMMER,
  kp.HUISLETTER,
  kp.TOEVOEGING,
  kp.POSTCODE,
  kp.WOONPLAATS,
  zr.AANDEEL_TELLER,
  zr.AANDEEL_NOEMER,
  zr.AARD_RECHT_AAND,
  zr.SOORT_EIGENAAR,
  zr.GESLACHTSNAAM,
  zr.VOORVOEGSEL,
  zr.VOORNAMEN,
  zr.GESLACHT,
  zr.WOONADRES,
  zr.GEBOORTEDATUM,
  zr.GEBOORTEPLAATS,
  zr.OVERLIJDENSDATUM,
  zr.NAAM_NIET_NATUURLIJK_PERSOON,
  zr.RECHTSVORM,
  zr.STATUTAIRE_ZETEL,
  zr.KVK_NUMMER
from v_kad_perceel_eenvoudig kp
join v_kad_perceel_zak_recht zr on (zr.KADASTER_IDENTIFICATIE = kp.sc_kad_identif);

create or replace view kad_perceel_app_rechten as
select
 kpe.SC_KAD_IDENTIF as perceel_identificatie,
-- kpe.KA_SECTIE || ' ' || kpe.KA_PERCEELNUMMER as perceelnr,
 kpe.aanduiding,
 kpe.straat, kpe.huisnummer, kpe.toevoeging, kpe.huisletter,
 kpe.straat || ' ' || kpe.huisnummer || ' ' || kpe.huisletter || ' ' || kpe.toevoeging || ' ' || kpe.postcode as adres,
-- zr.kadaster_identif as links_zak_recht,
 zr.FK_3AVR_AAND as complex_zak_recht_aard_aand,
-- zr.FK2_PERSOON as links_zak_recht_persoon,

--    case when np1.PK_PERSOON is not null then 'Natuurlijk persoon' else 'Niet natuurlijk persoon' end as l_soort_eigenaar,
    case when np1.sc_identif is not null then np1.NM_GESLACHTSNAAM || ', ' || np1.NM_VOORNAMEN || ' ' || np1.NM_VOORVOEGSEL_GESLACHTSNAAM else nnp1.NAAM end as perceel_zak_recht_naam,
--    nnp1.NAAM as l_nnp,

-- bd1.identificatie as brondocument,
-- zr2.kadaster_identif as rechts_zak_recht,
 zr2.FK_3AVR_AAND as app_re_zak_recht_aard_aand,
-- zr2.FK2_PERSOON as rechts_zak_recht_persoon,

--    case when np2.PK_PERSOON is not null then 'Natuurlijk persoon' else 'Niet natuurlijk persoon' end as r_soort_eigenaar,
    case when np2.sc_identif is not null then np2.NM_GESLACHTSNAAM || ', ' || np2.NM_VOORNAMEN || ' ' || np2.NM_VOORVOEGSEL_GESLACHTSNAAM else nnp2.NAAM end as app_re_zak_recht_naam,
--    nnp2.NAAM as r_nnp,

ar.SC_KAD_IDENTIF as app_re_identificatie,
 ar.KA_APPARTEMENTSINDEX::int as appartementsindex --,
-- ar.FK1_NIET_NAT_PERSOON as app_re_vve,
-- ar_vve_nnp.naam as app_re_vve_naam,
-- ar_vve_innp.rechtsvorm as app_re_vve_rechtsvorm,
-- ar_vve_innp.rsin as app_re_vve_rsin
from v_kad_perceel_eenvoudig kpe
join zak_recht zr on (zr.FK_7KOZ_KAD_IDENTIF = kpe.SC_KAD_IDENTIF)

  left join nat_prs np1 on (np1.SC_IDENTIF = zr.FK_8PES_SC_IDENTIF)
  left join ingeschr_nat_prs inp1 on (inp1.SC_IDENTIF = np1.SC_IDENTIF)
  left join niet_nat_prs nnp1 on (nnp1.sc_identif = zr.FK_8PES_SC_IDENTIF)
  left join ingeschr_niet_nat_prs innp1 on (innp1.sc_identif = nnp1.sc_identif)

join brondocument bd1 on (bd1.tabel = 'ZAK_RECHT' and bd1.tabel_identificatie = zr.kadaster_identif)
join brondocument bd2 on (bd2.tabel = 'ZAK_RECHT' and bd2.tabel_identificatie <> zr.kadaster_identif and bd2.identificatie = bd1.identificatie)
join zak_recht zr2 on (zr2.kadaster_identif = bd2.tabel_identificatie)


  left join nat_prs np2 on (np2.SC_IDENTIF = zr2.FK_8PES_SC_IDENTIF)
  left join ingeschr_nat_prs inp2 on (inp2.SC_IDENTIF = np2.SC_IDENTIF)
  left join niet_nat_prs nnp2 on (nnp2.sc_identif = zr2.FK_8PES_SC_IDENTIF)
  left join ingeschr_niet_nat_prs innp2 on (innp2.sc_identif = nnp2.sc_identif)

join app_re ar on (ar.SC_KAD_IDENTIF = zr2.FK_7KOZ_KAD_IDENTIF)
join niet_nat_prs ar_vve_nnp on (ar_vve_nnp.sc_identif = ar.FK_2NNP_SC_IDENTIF)
join INGESCHR_NIET_NAT_PRS ar_vve_innp on (ar_vve_innp.sc_identif = ar_vve_nnp.sc_identif)
where bd1.omschrijving like 'betrokkenBij%'
and zr2.FK_8PES_SC_IDENTIF is not null
order by kpe.SC_KAD_IDENTIF, kpe.straat, kpe.huisnummer, kpe.toevoeging, kpe.huisletter,  KA_APPARTEMENTSINDEX::int;

-- percelen plus appartementen op de percelen
CREATE OR REPLACE VIEW v_bd_app_re_and_kad_perceel AS
select
    (row_number() OVER ())::integer AS ObjectID,
    qry.*
  from(
    select
        p.sc_kad_identif    AS kadaster_identificatie,
        'perceel' as type,
        p.ka_deelperceelnummer,
        '' as ka_appartementsindex,
        p.ka_perceelnummer,
        p.ka_kad_gemeentecode,
        p.ka_sectie,
        p.begrenzing_perceel
    FROM
        kad_perceel p
    union all
    SELECT
        ar.sc_kad_identif,
        'appartement' as type,
        '' as ka_deelperceelnummer,
        ar.ka_appartementsindex,
        ar.ka_perceelnummer,
        ar.ka_kad_gemeentecode,
        ar.ka_sectie,
        kp.begrenzing_perceel
    FROM v_bd_app_re_all_kad_perceel v
        JOIN kad_perceel kp ON v.perceel_identif::NUMERIC = kp.sc_kad_identif
        JOIN app_re ar ON v.app_re_identif::NUMERIC = ar.sc_kad_identif
  ) qry;

-- aankoopdatum uit brondocumenten
CREATE OR REPLACE VIEW
    v_aankoopdatum AS
SELECT
    b.ref_id AS kadaster_identificatie,
    b.datum  AS aankoopdatum
FROM
    (
        SELECT
            ref_id,
            MAX(datum) datum
        FROM
            brondocument
        WHERE
            omschrijving = 'Akte van Koop en Verkoop'
        GROUP BY
            ref_id
    ) b ;

-- Eigenarenkaart - percelen en appartementen met hun eigenaren
CREATE OR REPLACE VIEW
    V_KAD_EIGENARENKAART
    (
        OBJECTID,
        KADASTER_IDENTIFICATIE,
        TYPE,
        ZAKELIJK_RECHT_IDENTIFICATIE,
        AANDEEL_TELLER,
        AANDEEL_NOEMER,
        AARD_RECHT_AAND,
        ZAKELIJK_RECHT_OMSCHRIJVING,
        AANKOOPDATUM,
        SOORT_EIGENAAR,
        GESLACHTSNAAM,
        VOORVOEGSEL,
        VOORNAMEN,
        GESLACHT,
        PERCEEL_ZAK_RECHT_NAAM,
        PERSOON_IDENTIFICATIE,
        WOONADRES,
        GEBOORTEDATUM,
        GEBOORTEPLAATS,
        OVERLIJDENSDATUM,
        NAAM_NIET_NATUURLIJK_PERSOON,
        RECHTSVORM,
        STATUTAIRE_ZETEL,
        KVK_NUMMER,
        KA_APPARTEMENTSINDEX,
        KA_DEELPERCEELNUMMER,
        KA_PERCEELNUMMER,
        KA_KAD_GEMEENTECODE,
        KA_SECTIE,
        BEGRENZING_PERCEEL
    ) AS
SELECT
    (row_number() OVER ())::integer AS objectid,
    p.kadaster_identificatie    AS kadaster_identificatie,
    p.type,
    zr.kadaster_identif AS zakelijk_recht_identificatie,
    zr.ar_teller        AS aandeel_teller,
    zr.ar_noemer        AS aandeel_noemer,
    zr.fk_3avr_aand     AS aard_recht_aand,
    ark.omschr          AS zakelijk_recht_omschrijving,
    b.aankoopdatum,
    CASE
        WHEN np.sc_identif IS NOT NULL
        THEN 'Natuurlijk persoon'
        WHEN nnp.sc_identif IS NOT NULL
        THEN 'Niet natuurlijk persoon'
        ELSE 'Onbekend'
    END                             AS soort_eigenaar,
    np.nm_geslachtsnaam             AS geslachtsnaam,
    np.nm_voorvoegsel_geslachtsnaam AS voorvoegsel,
    np.nm_voornamen                 AS voornamen,
    np.geslachtsaand                AS geslacht,
    CASE
        WHEN np.sc_identif IS NOT NULL
        THEN np.NM_GESLACHTSNAAM || ', ' || np.NM_VOORNAMEN || ' ' ||
            np.NM_VOORVOEGSEL_GESLACHTSNAAM
        WHEN nnp.sc_identif IS NOT NULL
        THEN nnp.NAAM
        ELSE 'Onbekend'
    END                     AS perceel_zak_recht_naam,
    inp.sc_identif          AS persoon_identificatie,
    inp.va_loc_beschrijving AS woonadres,
    inp.gb_geboortedatum    AS geboortedatum,
    inp.gb_geboorteplaats   AS geboorteplaats,
    inp.ol_overlijdensdatum AS overlijdensdatum,
    nnp.naam                AS naam_niet_natuurlijk_persoon,
    innp.rechtsvorm,
    innp.statutaire_zetel,
    innp_subject.kvk_nummer,
    p.ka_appartementsindex,
    p.ka_deelperceelnummer,
    p.ka_perceelnummer,
    p.ka_kad_gemeentecode,
    p.ka_sectie,
    p.begrenzing_perceel
FROM
    v_bd_app_re_and_kad_perceel p
JOIN
    zak_recht zr
ON
    zr.fk_7koz_kad_identif = p.kadaster_identificatie
LEFT JOIN
    aard_recht_verkort ark
ON
    zr.fk_3avr_aand = ark.aand
LEFT JOIN
    aard_verkregen_recht ar
ON
    zr.fk_3avr_aand = ar.aand
LEFT JOIN
    nat_prs np
ON
    np.sc_identif = zr.fk_8pes_sc_identif
LEFT JOIN
    ingeschr_nat_prs inp
ON
    inp.sc_identif = np.sc_identif
LEFT JOIN
    niet_nat_prs nnp
ON
    nnp.sc_identif = zr.fk_8pes_sc_identif
LEFT JOIN
    ingeschr_niet_nat_prs innp
ON
    innp.sc_identif = nnp.sc_identif
LEFT JOIN
    subject innp_subject
ON
    innp_subject.identif = innp.sc_identif
LEFT JOIN
    v_aankoopdatum b
ON
    b.kadaster_identificatie::numeric(15,0) = p.kadaster_identificatie
WHERE
    zr.kadaster_identif like 'NL.KAD.Tenaamstelling%';



-- selecteer parent en child app_re's die een ondersplitsing zijn of zijn geworden

CREATE OR REPLACE VIEW v_bd_app_re_app_re AS
 SELECT b1.ref_id AS app_re_identif,
    b2.ref_id AS parent_app_re_identif
   FROM brondocument b1
     JOIN brondocument b2 ON b2.identificatie = b1.identificatie
  WHERE (b2.omschrijving = 'betrokkenBij Ondersplitsing' OR  b2.omschrijving = 'ontstaanUit HoofdSplitsing') AND b1.omschrijving = 'ontstaanUit Ondersplitsing'
  GROUP BY b1.ref_id, b2.ref_id;

-- recursieve query om alle actuele appartementsrechten te vinden bij percelen
CREATE OR REPLACE VIEW v_bd_app_re_all_kad_perceel AS

with recursive related_app_re (app_re_identif, perceel_identif) as (
SELECT b1.ref_id AS app_re_identif,
    b2.ref_id AS perceel_identif
   FROM brondocument b1
     JOIN brondocument b2 ON b2.identificatie = b1.identificatie
  WHERE b2.omschrijving = 'betrokkenBij HoofdSplitsing' AND (b1.omschrijving = 'ontstaanUit HoofdSplitsing' OR b1.omschrijving = 'ontstaanUit Ondersplitsing')  GROUP BY b1.ref_id, b2.ref_id


union


 SELECT vaa.app_re_identif,
    vap.perceel_identif
   FROM v_bd_app_re_app_re vaa
     JOIN related_app_re vap ON vaa.parent_app_re_identif = vap.app_re_identif
  GROUP BY vaa.app_re_identif, vap.perceel_identif
)

select
app_re.sc_kad_identif::varchar(50) as app_re_identif, rar.perceel_identif
from related_app_re rar
left join app_re
on app_re.sc_kad_identif::text = rar.app_re_identif;


-- Haalt alle percelen ids op met 1 of meer app_re (dient als basis voor de view voor de kaart)

CREATE OR REPLACE VIEW v_bd_kad_perceel_with_app_re AS
 SELECT DISTINCT b2.ref_id AS perceel_identif
   FROM brondocument b1
     JOIN brondocument b2 ON b2.identificatie = b1.identificatie
  WHERE b2.omschrijving = 'betrokkenBij HoofdSplitsing' AND (b1.omschrijving = 'ontstaanUit HoofdSplitsing' OR b1.omschrijving = 'ontstaanUit Ondersplitsing');

-- view om kaart te maken met percelen die 1 of meerdere appartementen hebben

CREATE OR REPLACE VIEW v_bd_kad_perceel_met_app AS
 SELECT v.perceel_identif,
    kp.sc_kad_identif,
    kp.aand_soort_grootte,
    kp.grootte_perceel,
    kp.omschr_deelperceel,
    kp.fk_7kdp_sc_kad_identif,
    kp.ka_deelperceelnummer,
    kp.ka_kad_gemeentecode,
    kp.ka_perceelnummer,
    kp.ka_sectie,
    kp.begrenzing_perceel,
    kp.plaatscoordinaten_perceel
   FROM v_bd_kad_perceel_with_app_re v
     JOIN kad_perceel kp ON v.perceel_identif = kp.sc_kad_identif::varchar;

-- view om vlakken kaart te maken met percelen die 1 of meerdere appartementen hebben
CREATE OR REPLACE VIEW v_bd_kad_perceel_met_app_vlak AS
 SELECT
    (row_number() OVER ())::integer AS ObjectID,
    v.perceel_identif,
    kp.sc_kad_identif,
    kp.aand_soort_grootte,
    kp.grootte_perceel,
    kp.omschr_deelperceel,
    kp.fk_7kdp_sc_kad_identif,
    kp.ka_deelperceelnummer,
    kp.ka_kad_gemeentecode,
    kp.ka_perceelnummer,
    kp.ka_sectie,
    kp.begrenzing_perceel
   FROM v_bd_kad_perceel_with_app_re v
     JOIN kad_perceel kp ON v.perceel_identif = kp.sc_kad_identif::varchar;


-- view om appartementsrechten bij percelen op te zoeken
CREATE OR REPLACE VIEW v_bd_app_re_bij_perceel AS
 SELECT
    (row_number() OVER ())::integer AS ObjectID,
    ar.sc_kad_identif,
    ar.fk_2nnp_sc_identif,
    ar.ka_appartementsindex,
    ar.ka_kad_gemeentecode,
    ar.ka_perceelnummer,
    ar.ka_sectie,
    kp.begrenzing_perceel
   FROM v_bd_app_re_all_kad_perceel v
     JOIN kad_perceel kp ON v.perceel_identif = kp.sc_kad_identif::varchar
     JOIN app_re ar ON v.app_re_identif = ar.sc_kad_identif::varchar;



-- onderstaande dienen als laatste stappen van een upgrade uitgevoerd
INSERT INTO brmo_metadata (naam,waarde) SELECT 'upgrade_1.5.2_naar_1.5.3','vorige versie was '||waarde FROM brmo_metadata WHERE naam='brmoversie';
-- versienummer update
UPDATE brmo_metadata SET waarde='1.5.3' WHERE naam='brmoversie';
