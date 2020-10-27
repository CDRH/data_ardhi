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

  <!-- ==================================================================== -->
  <!--                            OVERRIDES                                 -->
  <!-- ==================================================================== -->

  <xsl:template match="pb">
   <!-- do nothing -->
  </xsl:template>

  <xsl:template match="fw">
   <!-- do nothing -->
  </xsl:template>
 

</xsl:stylesheet>