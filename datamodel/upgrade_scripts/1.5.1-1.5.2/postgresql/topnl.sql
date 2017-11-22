--
-- upgrade PostgreSQL TOPNL datamodel van 1.5.1 naar 1.5.2
--

alter table top10nl.Spoorbaandeel add column puntGeometrie geometry (Point, 28992);
alter table top10nl.plantopografie add column geometrie geometry (Geometry, 28992);