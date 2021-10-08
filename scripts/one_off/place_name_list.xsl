<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:mf="http://example.com/mf"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:html="http://www.w3.org/1999/xhtml"
    exclude-result-prefixes="xs mf tei"
    version="2.0">
    <xsl:output method="text"/>
    <xsl:strip-space elements="*" />
    
    
    <xsl:function name="mf:sort" as="attribute()*">
        <xsl:param name="attributes" as="attribute()*"/>
        <xsl:perform-sort select="$attributes">
            <xsl:sort select="name()"/>
        </xsl:perform-sort>
    </xsl:function>
    
    <xsl:template match="/">
        
        <!-- Use only one of the following, comment out the one not in use -->
        
        <!-- Use the below to pull all elements from generate TEI files -->
        <xsl:variable name="collection_location">../../source/tei/?select=*.xml</xsl:variable>
        <!-- /TEI/teiHeader[1]/profileDesc[1]/textClass[1]/keywords[@scheme='geonames']/term -->
        <xsl:for-each-group select="collection($collection_location)//tei:keywords[@scheme='geonames']/tei:term" group-by=".">
            <xsl:sort select="."/>
            <xsl:value-of select="node()"/>
<xsl:text> 
</xsl:text>
        </xsl:for-each-group>
        
        
        
    </xsl:template>
    
</xsl:stylesheet>