<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:db="http://www.b3partners.nl/db-specific" xmlns:fn="http://www.w3.org/2005/xpath-functions">
	
	<xsl:import href="datamodel_ddl.xsl"/>
	
	<xsl:variable name="dbtype">oracle</xsl:variable>
	
	<xsl:function name="db:type">
		<xsl:param name="type"/>
		<xsl:value-of select="fn:replace(fn:replace($type,'varchar','varchar2'),'default','varchar2(255)')"/>
	</xsl:function>
	
	<xsl:function name="db:string-literal">
		<xsl:param name="s"/>
		<xsl:value-of select="concat('''',fn:replace($s,'''',''''''),'''')"/>
	</xsl:function>	
	
	<xsl:function name="db:addGeometryColumn">
		<xsl:param name="table"/>	
		<xsl:param name="column"/>	
		<xsl:param name="type"/>
		<xsl:param name="pos"/>
					
		<xsl:text>insert into user_sdo_geom_metadata values('</xsl:text><xsl:value-of select="$table"/><xsl:text>', '</xsl:text><xsl:value-of select="$column"/><xsl:text>', </xsl:text>
			<xsl:text>MDSYS.SDO_DIM_ARRAY(&#13;</xsl:text>
			<xsl:text>	MDSYS.SDO_DIM_ELEMENT('X', 12000, 280000, .1),&#13;</xsl:text>
			<xsl:text>	MDSYS.SDO_DIM_ELEMENT('Y', 304000, 620000, .1)), &#13;</xsl:text>
			<xsl:text>	90112 &#13;</xsl:text>
			<xsl:text>);&#13;</xsl:text>
			
			<xsl:text>alter table </xsl:text><xsl:value-of select="$table"/><xsl:text> add(</xsl:text><xsl:value-of select="$column"/><xsl:text> sdo_geometry );&#13;</xsl:text>
			<xsl:text>CREATE INDEX </xsl:text><xsl:value-of select="fn:substring(concat($table,'_',$column),1,25)"/><xsl:value-of select="$pos"/><xsl:text>_idx ON </xsl:text><xsl:value-of select="$table"/><xsl:text> (</xsl:text><xsl:value-of select="$column"/><xsl:text>) INDEXTYPE IS MDSYS.SPATIAL_INDEX;&#13;</xsl:text>
		<!-- evt create index <table>_idx00 on table(column) indextype is mdsys.spatial_index; -->
	</xsl:function>		
</xsl:stylesheet>