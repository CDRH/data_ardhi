<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xpath-default-namespace="http://www.tei-c.org/ns/1.0" version="2.0"
  exclude-result-prefixes="xsl tei xs">

  <!-- ==================================================================== -->
  <!--                             IMPORTS                                  -->
  <!-- ==================================================================== -->

  <xsl:import href="../.xslt-datura/tei_to_html/tei_to_html.xsl"/>

  <!-- To override, copy this file into your collection's script directory
    and change the above paths to:
    "../../.xslt-datura/tei_to_html/lib/formatting.xsl"
 -->

  <!-- For display in TEI framework, have changed all namespace declarations to http://www.tei-c.org/ns/1.0. If different (e.g. Whitman), will need to change -->
  <xsl:output method="xhtml" indent="no" encoding="UTF-8" omit-xml-declaration="yes"/>


  <!-- ==================================================================== -->
  <!--                           PARAMETERS                                 -->
  <!-- ==================================================================== -->

  <xsl:param name="collection"/>
  <xsl:param name="data_base"/>
  <xsl:param name="environment"/>
  <xsl:param name="image_large"/>
  <xsl:param name="image_thumb"/>
  <xsl:param name="media_base"/>
  <xsl:param name="site_url"/>

  <xsl:variable name="newline" select="'&#x0A;'"/>
  <xsl:variable name="title" select="//teiHeader//titleStmt//title[1]"/>
  <xsl:variable name="date" select="//keywords[@n='treatydate']/term[1]"/>
  <xsl:variable name="document" select="tokenize(base-uri(.),'/')[last()]"/>


  <!-- ==================================================================== -->
  <!--                            OVERRIDES                                 -->
  <!-- ==================================================================== -->

    <!-- Create front matter (YML) header -->
  <xsl:template match="/">
    <xsl:text>---</xsl:text>
    <xsl:value-of select="$newline"/>
    <xsl:text>title: </xsl:text><xsl:value-of select="$title"/>
    <xsl:value-of select="$newline"/>
    <xsl:text>document: </xsl:text><xsl:value-of select="$document"/>
    <xsl:value-of select="$newline"/>
    <!-- creator should be an array because there are multiple values -->
    <xsl:text>creator: [</xsl:text>
    <xsl:for-each select="//person[@role='signatory']">
      <xsl:variable name="signatoryName" select="./persName"/>
      <xsl:variable name="count" select="count(following::person[@role='signatory'])"/>
      <xsl:choose>
        <xsl:when test="./persName = preceding::person[@role='signatory']/persName"/>
        <xsl:otherwise>
          <xsl:text>"</xsl:text><xsl:value-of select="$signatoryName"/><xsl:text>"</xsl:text>
          <xsl:if test="$count != 0">
            <xsl:if test="following::person[@role='signatory'][./persName != preceding::person[@role='signatory']/persName]"><xsl:text>,</xsl:text></xsl:if>
          </xsl:if>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:for-each>
    <xsl:text>]</xsl:text>
    <xsl:value-of select="$newline"/>
    <xsl:text>date: </xsl:text><xsl:value-of select="$date"/>
    <xsl:value-of select="$newline"/>
    <!--<xsl:text>category: </xsl:text><xsl:value-of select="$category"/>-->
    <xsl:text>category: document</xsl:text>
    <xsl:value-of select="$newline"/>
    <xsl:text>---</xsl:text>
    <xsl:value-of select="$newline"/>
    <xsl:value-of select="$newline"/>
    <h1 class="pagefind" data-pagefind-meta="title"><xsl:value-of select="$title"/></h1>
    <xsl:apply-templates/>
  </xsl:template>
  
  <xsl:template match="pb">
   <!-- do nothing -->
  </xsl:template>

  <xsl:template match="fw">
   <!-- do nothing -->
  </xsl:template>
 

</xsl:stylesheet>