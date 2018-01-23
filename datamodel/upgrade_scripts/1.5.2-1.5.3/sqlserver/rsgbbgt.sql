-- 
-- upgrade SQLserver RSGBBGT datamodel van 1.5.2 naar 1.5.3 
--


-- onderstaande dienen als laatste stappen van een upgrade uitgevoerd
INSERT INTO brmo_metadata (naam,waarde) SELECT 'upgrade_1.5.2_naar_1.5.3','vorige versie was '||waarde FROM brmo_metadata WHERE naam='brmoversie';
-- versienummer update
UPDATE brmo_metadata SET waarde='1.5.3' WHERE naam='brmoversie';
