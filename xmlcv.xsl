<?xml	version="1.0"
		encoding="UTF-8" ?>

<xsl:stylesheet	version="1.0"
				xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
				xmlns:msxsl="urn:schemas-microsoft-com:xslt"
				>

	<xsl:output	encoding="UTF-8" />

	<xsl:param	name="MODE">
		<xsl:text>MODE</xsl:text>
	</xsl:param>

	<xsl:variable	name="PageWidth">
		<xsl:text>750</xsl:text>
	</xsl:variable>
	
	<xsl:variable	name="Image_Plus_Path">
		<xsl:text>images/plus.png</xsl:text>
	</xsl:variable>

	<xsl:variable	name="Image_Moins_Path">
		<xsl:text>images/moins.png</xsl:text>
	</xsl:variable>

	<xsl:variable	name="DISPLAY_MINIMIZED">
		<xsl:text>minimized</xsl:text>
	</xsl:variable>

	<xsl:variable	name="DISPLAY_EXPANDED">
		<xsl:text>expanded</xsl:text>
	</xsl:variable>
	
	<xsl:variable	name="DISPLAY_NONE">
		<xsl:text>none</xsl:text>
	</xsl:variable>

	<xsl:variable	name="DISPLAY_MODE_DEFAULT">
		<xsl:text>default</xsl:text>
	</xsl:variable>
	
	<xsl:variable	name="DivBaseName">
		<xsl:text>_div_</xsl:text>
	</xsl:variable>

	<xsl:variable	name="ImageBaseName">
		<xsl:text>_Image_</xsl:text>
	</xsl:variable>
	
	<xsl:variable	name="ImageDivBaseName">
		<xsl:text>DIV</xsl:text>
	</xsl:variable>

	<xsl:template	name="FormatStringForWeb">
		<xsl:param	name="String" />
		
		<xsl:variable	name="StringAfterBRReplacement">
			<xsl:call-template name="Replace">
				<xsl:with-param name="String" select="$String"/>
				<xsl:with-param name="StringToReplace" select="'&#10;'"/>
				<xsl:with-param name="ReplacementString" select="'&lt;br /&gt;'"/>
			</xsl:call-template>
		</xsl:variable>

		<xsl:variable	name="StringAfterEAcuteReplacement">
			<xsl:call-template name="Replace">
				<xsl:with-param name="String" select="$StringAfterBRReplacement"/>
				<xsl:with-param name="StringToReplace" select="'&#233;'"/>
				<xsl:with-param name="ReplacementString" select="'&amp;eacute;'"/>
			</xsl:call-template>
		</xsl:variable>

		<xsl:variable	name="StringAfterEGraveReplacement">
			<xsl:call-template name="Replace">
				<xsl:with-param name="String" select="$StringAfterEAcuteReplacement"/>
				<xsl:with-param name="StringToReplace" select="'&#232;'"/>
				<xsl:with-param name="ReplacementString" select="'&amp;egrave;'"/>
			</xsl:call-template>
		</xsl:variable>

		<xsl:variable	name="StringAfterAAcuteReplacement">
			<xsl:call-template name="Replace">
				<xsl:with-param name="String" select="$StringAfterEAcuteReplacement"/>
				<xsl:with-param name="StringToReplace" select="'&#225;'"/>
				<xsl:with-param name="ReplacementString" select="'&amp;eacute;'"/>
			</xsl:call-template>
		</xsl:variable>

		<xsl:variable	name="StringAfterAGraveReplacement">
			<xsl:call-template name="Replace">
				<xsl:with-param name="String" select="$StringAfterAAcuteReplacement"/>
				<xsl:with-param name="StringToReplace" select="'&#224;'"/>
				<xsl:with-param name="ReplacementString" select="'&amp;egrave;'"/>
			</xsl:call-template>
		</xsl:variable>

		<xsl:value-of	select="$StringAfterEGraveReplacement"
						disable-output-escaping="yes" />
	</xsl:template>


	<xsl:template	name="Replace">
		<xsl:param	name="String" />
		<xsl:param	name="StringToReplace" />
		<xsl:param	name="ReplacementString" />
		
		<xsl:choose>
			<xsl:when	test="contains( $String, $StringToReplace )">
				<xsl:value-of	select="substring-before( $String, $StringToReplace )" />
				<xsl:value-of	select="$ReplacementString"
								disable-output-escaping="yes"
								/>
				<xsl:call-template	name="Replace">
					<xsl:with-param	name="String"
									select="substring-after( $String, $StringToReplace )"
									/>
					<xsl:with-param	name="StringToReplace"
									select="$StringToReplace"
									/>
					<xsl:with-param	name="ReplacementString"
									select="$ReplacementString"
									/>
				</xsl:call-template>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of	select="$String" />
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template	name="InsertCssInlineStyleDeclarations">
		<style	type="text/css">
			<xsl:text>
				body
				{
					background: #FCFCFF;
				}
			
				td
				{
					font-family: Arial;
					font-size: 14;
					color: #0C0A6A;
					padding: 0;
					margin: 0;
				}
				
				td.InfoPerso
				{
					font-family: Arial;
					font-size: 16;
					color: #0C0A6A;
					padding: 0;
					margin: 0;
				}
				
				td.Titre2
				{
					font-family: Arial;
					font-size: 18;
					font-weight: bold;
					color: #0C0A6A;
					background: #C9C5FF;
				}				
				
				div
				{
					padding: 0;
					margin: 0;
				}
				
				table
				{
					padding: 0;
					margin: 0;	
				}
			</xsl:text>
		</style>
	</xsl:template>

	<xsl:template	name="InsertScriptDeclarations">
		<script	language="JavaScript"
				type="text/JavaScript"
				src="js-menu/menu.js">
		</script>
		<script language="javascript">
			<xsl:text>
				var _tabObjetANePasImprimer = new Array();
			
				function SwitchDivVisibility( DivId, SpanId )
				{
					if ( 'none' == document.getElementById( DivId ).style.display )
						SetDivVisibility( DivId, SpanId, true );
					else
						SetDivVisibility( DivId, SpanId, false );
				}
				
				function SetDivVisibility( DivId, ImageId, bVisible )
				{
					if ( bVisible )
					{
						document.getElementById( DivId ).style.display = 'block';
						document.getElementById( ImageId ).src = '</xsl:text>
						<xsl:value-of	select="$Image_Moins_Path" />
						<xsl:text>';
					}
					else
					{
						document.getElementById( DivId ).style.display = 'none';
						document.getElementById( ImageId ).src = '</xsl:text>
						<xsl:value-of	select="$Image_Plus_Path" />
						<xsl:text>';
					}
				}
				
				function Imprimer()
				{
					var objANePasImprimer;
					var nCount = _tabObjetANePasImprimer.length;
					var i;
					for ( i = 0 ; i &lt; nCount ; i++ )
					{
						objANePasImprimer = document.getElementById( _tabObjetANePasImprimer[ i ] );
						objANePasImprimer.style.display = 'none';
					}

					window.print();

					for ( i = 0 ; i &lt; nCount ; i++ )
					{
						objANePasImprimer = document.getElementById( _tabObjetANePasImprimer[ i ] );
						objANePasImprimer.style.display = 'block';
					}					
				}
				
				function AfficherCVDetaille()
				{
					var sCvCompletLocation = '</xsl:text>
					<xsl:value-of	select="//modes/mode[ @nom = $MODE ]/@lien-cv-complet" />
					<xsl:text>';
					window.open( 	sCvCompletLocation,
								 	'Détaillé'
								 );
					
				}
			</xsl:text>
		</script>
	</xsl:template>

	<xsl:template	match="*">
	</xsl:template>

	<xsl:template	match="/">
		<html>
			<head>
				<xsl:call-template	name="InsertCssInlineStyleDeclarations" />
				<xsl:call-template	name="InsertScriptDeclarations" />
			</head>
			<body>
				<table>
					<xsl:attribute	name="width">
						<xsl:value-of	select="$PageWidth" />
					</xsl:attribute>
					<tr	colspan="4">
						<td	colspan="4"
							id="__menu"
							class="Titre2"
							>
						</td>
					</tr>
					<tr>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
					</tr>
					<xsl:apply-templates	select="node()" />
				</table>
				
				<!-- ajout du menu -->
				<script	language="JavaScript"
						type="text/javascript">
		  			var _objMenuBar = new MenuBar( 'Menu', '__menu' );
		  			var objMenu1 = _objMenuBar.AddMenu( 'C.V.' );
		  			var objMenu2 = _objMenuBar.AddMenu( 'A propos...' );
		  			<xsl:if	test="//modes/mode[ @nom = $MODE and not( '' = lien-cv-complet ) ]">
			  			<xsl:text>objMenu1.AddMenuItem( 'C.V. détaillé', 'javascript:AfficherCVDetaille();' );</xsl:text>
			  		</xsl:if>
		  			objMenu1.AddMenuItem( 'Imprimer', 'javascript:Imprimer();' );
		  			objMenu2.AddMenuItem( 'A propos de XmlCV', 'alert(\'\t\tXml CV \\n\tGénérateur de CV profilables\\nbasé sur les technologies XML / XSL / DOM / javascript\\n\\n                                                          Réalisé par Gnilane GUEYE Mai 2019\');' );
					// on ajoute le menu dans la liste des objets à ne pas imprimer
					_tabObjetANePasImprimer.push( '__menu' );
				</script>
			</body>
		</html>
	</xsl:template>
	
	<xsl:template	match="cv">
		<h1>Curriculum Vitae</h1>
		<xsl:apply-templates	select="donnees-personnelles"	/>
		<table>
			<xsl:attribute	name="align">align="center"</xsl:attribute>
			<xsl:attribute	name="width">
				<xsl:value-of	select="$PageWidth" />
			</xsl:attribute>
			
			<xsl:apply-templates	select="donnees-formation"	/>
			<xsl:call-template		name="competences-techniques"	/>
			<xsl:apply-templates	select="donnees-experience"	/>
			<xsl:apply-templates	select="donnees-centres-d-interet"	/>
		</table>
	</xsl:template>

	<xsl:template	match="donnees-personnelles">
		<table>
			<xsl:attribute	name="align">align="center"</xsl:attribute>
			<xsl:attribute	name="width">
				<xsl:value-of	select="$PageWidth" />
			</xsl:attribute>
			<tr>
				<td>
					<img>
						<xsl:attribute	name="width">
							<xsl:text>120</xsl:text>
						</xsl:attribute>
						<xsl:attribute	name="src">
							<xsl:value-of	select="photo/@path" />
						</xsl:attribute>
					</img>
				</td>
				<td	class="InfoPerso">
					<b>
						<xsl:value-of	select="prenom" />
						<xsl:text> </xsl:text>
						<xsl:value-of	select="nom" />
						<br />
						<xsl:text>Né le </xsl:text>
						<xsl:value-of	select="date-de-naissance" />
						<xsl:text> (</xsl:text>
						<xsl:value-of	select="age" />
						<xsl:text> ans</xsl:text>
						<xsl:text>)</xsl:text>
						<br />
						<xsl:value-of	select="etat-civil" />
						<br />
						<br />
						<xsl:call-template	name="FormatStringForWeb">
							<xsl:with-param	name="String"
											select="adresse"
											/>
						</xsl:call-template>
						<br />
						<br />
						
						<table>
							<tr>
								<td>Tél :</td>
								<td>
									<xsl:if	test="telephone[ @type = 'fixe' ]">
										<xsl:value-of	select="telephone[ @type = 'fixe' ]" />
										<br />
									</xsl:if>
									<xsl:if	test="telephone[ @type = 'mobile' ]">
										<xsl:value-of	select="telephone[ @type = 'mobile' ]" />
									</xsl:if>
								</td>
							</tr>
							<tr>
								<td>e-mail :</td>
								<td>
									<a>
										<xsl:attribute	name="href">
											<xsl:text>mailto:</xsl:text>
											<xsl:value-of	select="e-mail" />
										</xsl:attribute>
										<xsl:value-of	select="e-mail" />
									</a>
								</td>
							</tr>
						</table>
					</b>
				</td>
			</tr>
		</table>
	</xsl:template>
	
	<xsl:template	match="donnees-formation">
		<tr>
			<td	colspan="2"
				class="Titre2">
				<xsl:text>Formation</xsl:text>
			</td>
		</tr>
	
		<xsl:apply-templates	select="formation" />
	</xsl:template>
	
	<xsl:template	match="donnees-experience">
		<tr>
			<td	colspan="2"
				class="Titre2">
				<xsl:text>Exp&#233;rience</xsl:text>
			</td>
		</tr>
	
		<xsl:apply-templates	select="experience" />
	</xsl:template>

	<xsl:template	match="donnees-centres-d-interet">
		<tr>
			<td	colspan="2"
				class="Titre2">
				<xsl:text>Centres d'int&#233;rêts</xsl:text>
			</td>
		</tr>
	
		<xsl:apply-templates	select="centre-d-interet" />
	</xsl:template>
	
	<xsl:template	match="formation">
		<xsl:if	test="( affichage[ @mode = $MODE ] and not( affichage[ @mode = $MODE and @display = $DISPLAY_NONE ]  ) ) or ( not( affichage[ @mode = $MODE ] ) and ( affichage[ @mode = $DISPLAY_MODE_DEFAULT ] and not( affichage[ @mode = $DISPLAY_MODE_DEFAULT and @display = $DISPLAY_NONE ]  ) ) )">
			<xsl:variable	name="IdBaseName">
				<xsl:text>_formation_</xsl:text>
				<xsl:value-of select="position()" />
			</xsl:variable>
			
			<xsl:variable	name="ImageId">
				<xsl:value-of	select="$IdBaseName" />
				<xsl:value-of	select="$ImageBaseName" />
			</xsl:variable>
			
			<xsl:variable	name="ImageDivId">
				<xsl:value-of	select="$ImageId" />
				<xsl:value-of	select="$ImageDivBaseName" />
			</xsl:variable>
			
			<xsl:variable	name="DivId">
				<xsl:value-of	select="$IdBaseName" />
				<xsl:value-of	select="$DivBaseName" />
			</xsl:variable>
			
			<tr>
				<td	width="150"
					valign="top">
					<b>
						<xsl:value-of	select="@date-debut" />
						<xsl:if	test="@date-fin">
							<xsl:text>-</xsl:text>
							<xsl:value-of	select="@date-fin" />
						</xsl:if>
					</b>
				</td>
				<td>
					<table>
						<tr>
							<td	width="16">
								<xsl:choose>
									<xsl:when	test="description or lien-internet">
										<xsl:choose>
											<xsl:when	test="( affichage[ @mode = $MODE ] and affichage[ @mode = $MODE and @display = $DISPLAY_EXPANDED ] ) or ( not( affichage[ @mode = $MODE ] ) and ( affichage[ @mode = $DISPLAY_MODE_DEFAULT ] and affichage[ @mode = $DISPLAY_MODE_DEFAULT and @display = $DISPLAY_EXPANDED ] ) )">
												<div>
													<xsl:attribute	name="id"><xsl:value-of	select="$ImageDivId" /></xsl:attribute>
													<img>
														<xsl:attribute	name="src"><xsl:value-of	select="$Image_Moins_Path" /></xsl:attribute>
														<xsl:attribute	name="id"><xsl:value-of	select="$ImageId" /></xsl:attribute>
														<xsl:attribute	name="width">16</xsl:attribute>
														<xsl:attribute	name="height">16</xsl:attribute>
														<xsl:attribute	name="style">cursor: pointer</xsl:attribute>
														<xsl:attribute	name="onclick">
															<xsl:text>javascript:SwitchDivVisibility( '</xsl:text>
															<xsl:value-of	select="$DivId" />
															<xsl:text>', '</xsl:text>
															<xsl:value-of	select="$ImageId" />
															<xsl:text>' );</xsl:text>
														</xsl:attribute>
													</img>
												</div>
											</xsl:when>
											<xsl:when	test="( affichage[ @mode = $MODE ] and affichage[ @mode = $MODE and @display = $DISPLAY_MINIMIZED ] ) or ( not( affichage[ @mode = $MODE ] ) and ( affichage[ @mode = $DISPLAY_MODE_DEFAULT ] and affichage[ @mode = $DISPLAY_MODE_DEFAULT and @display = $DISPLAY_MINIMIZED ] ) )">
												<div>
													<xsl:attribute	name="id"><xsl:value-of	select="$ImageDivId" /></xsl:attribute>
													<img>
														<xsl:attribute	name="src"><xsl:value-of	select="$Image_Plus_Path" /></xsl:attribute>
														<xsl:attribute	name="id"><xsl:value-of	select="$ImageId" /></xsl:attribute>
														<xsl:attribute	name="width">16</xsl:attribute>
														<xsl:attribute	name="height">16</xsl:attribute>
														<xsl:attribute	name="style">cursor: pointer</xsl:attribute>
														<xsl:attribute	name="onclick">
															<xsl:text>javascript:SwitchDivVisibility( '</xsl:text>
															<xsl:value-of	select="$DivId" />
															<xsl:text>', '</xsl:text>
															<xsl:value-of	select="$ImageId" />
															<xsl:text>' );</xsl:text>
														</xsl:attribute>
													</img>
												</div>
											</xsl:when>
										</xsl:choose>
									</xsl:when>
									<xsl:otherwise>
										<xsl:text>&#160;</xsl:text>
									</xsl:otherwise>
								</xsl:choose>
							</td>
							<td>
								<b>
									<xsl:value-of	select="titre" />
								</b>
							</td>
						</tr>
					</table>
					<xsl:if	test="description or lien-internet">
						<div>
							<xsl:attribute	name="id"><xsl:value-of	select="$DivId" /></xsl:attribute>
							<xsl:choose>
								<xsl:when	test="( affichage[ @mode = $MODE ] and affichage[ @mode = $MODE and @display = $DISPLAY_EXPANDED ] ) or ( not( affichage[ @mode = $MODE ] ) and ( affichage[ @mode = $DISPLAY_MODE_DEFAULT ] and affichage[ @mode = $DISPLAY_MODE_DEFAULT and @display = $DISPLAY_EXPANDED ]  ) )">
									<xsl:attribute	name="style">
										<xsl:text>display: block</xsl:text>
									</xsl:attribute>
								</xsl:when>
								<xsl:when	test="( affichage[ @mode = $MODE ] and affichage[ @mode = $MODE and @display = $DISPLAY_MINIMIZED ] ) or ( not( affichage[ @mode = $MODE ] ) and ( affichage[ @mode = $DISPLAY_MODE_DEFAULT ] and affichage[ @mode = $DISPLAY_MODE_DEFAULT and @display = $DISPLAY_MINIMIZED ] ) )">
									<xsl:attribute	name="style">
										<xsl:text>display: none</xsl:text>
									</xsl:attribute>
								</xsl:when>
							</xsl:choose>
							
							<table>
								<tr>
									<td	height="0" width="16">&#160;</td>
									<td height="0">
										<p	align="justify">
											<xsl:if	test="description">
												<xsl:call-template	name="FormatStringForWeb">
													<xsl:with-param	name="String"
																	select="description"
																	/>
												</xsl:call-template>
											</xsl:if>
											<xsl:if	test="lien-internet">
												<br />
												<a>
													<xsl:attribute	name="href">
														<xsl:value-of	select="lien-internet" />
													</xsl:attribute>
													<xsl:attribute	name="target">_blank</xsl:attribute>
													<xsl:value-of	select="lien-internet" />
												</a>
											</xsl:if>
										</p>
									</td>
								</tr>
							</table>
						</div>
					</xsl:if>
				</td>
			</tr>
			<script	language="javascript">
				<xsl:text>
					// on ajout l'image dans la liste des objets à ne pas imprimer
					_tabObjetANePasImprimer.push( '</xsl:text>
				<xsl:value-of	select="$ImageId" />
				<xsl:text>div' );
				</xsl:text>
			</script>
		</xsl:if>
	</xsl:template>

	<xsl:template	match="experience">
		<xsl:if	test="( affichage[ @mode = $MODE ] and not( affichage[ @mode = $MODE and @display = $DISPLAY_NONE ]  ) ) or ( not( affichage[ @mode = $MODE ] ) and ( affichage[ @mode = $DISPLAY_MODE_DEFAULT ] and not( affichage[ @mode = $DISPLAY_MODE_DEFAULT and @display = $DISPLAY_NONE ]  ) ) )">
			<xsl:variable	name="IdBaseName">
				<xsl:text>_experience_</xsl:text>
				<xsl:value-of select="position()" />
			</xsl:variable>
			
			<xsl:variable	name="ImageId">
				<xsl:value-of	select="$IdBaseName" />
				<xsl:value-of	select="$ImageBaseName" />
			</xsl:variable>

			<xsl:variable	name="ImageDivId">
				<xsl:value-of	select="$ImageId" />
				<xsl:value-of	select="$ImageDivBaseName" />
			</xsl:variable>
			
			<xsl:variable	name="DivId">
				<xsl:value-of	select="$IdBaseName" />
				<xsl:value-of	select="$DivBaseName" />
			</xsl:variable>
			
			<tr>
				<td	width="150"
					valign="top">
					<b>
						<xsl:value-of	select="@date-debut" />
						<xsl:if	test="@date-fin">
							<xsl:text>-</xsl:text>
							<xsl:value-of	select="@date-fin" />
						</xsl:if>
						<xsl:if	test="@duree">
							<xsl:text> (</xsl:text>
							<xsl:value-of	select="@duree" />
							<xsl:text>)</xsl:text>
						</xsl:if>
					</b>
				</td>
				<td>
					<table>
						<tr>
							<td	width="16">
								<xsl:choose>
									<xsl:when	test="description or environnement-technique/technologie">
										<xsl:choose>
											<xsl:when	test="( affichage[ @mode = $MODE ] and affichage[ @mode = $MODE and @display = $DISPLAY_EXPANDED ]  ) or ( not( affichage[ @mode = $MODE ] ) and ( affichage[ @mode = $DISPLAY_MODE_DEFAULT ] and affichage[ @mode = $DISPLAY_MODE_DEFAULT and @display = $DISPLAY_EXPANDED ]  ) )">
												<div>
													<xsl:attribute	name="id"><xsl:value-of	select="$ImageDivId" /></xsl:attribute>
													<img>
														<xsl:attribute	name="src"><xsl:value-of	select="$Image_Moins_Path" /></xsl:attribute>
														<xsl:attribute	name="id"><xsl:value-of	select="$ImageId" /></xsl:attribute>
														<xsl:attribute	name="width">16</xsl:attribute>
														<xsl:attribute	name="height">16</xsl:attribute>
														<xsl:attribute	name="style">cursor: pointer</xsl:attribute>
														<xsl:attribute	name="onclick">
															<xsl:text>javascript:SwitchDivVisibility( '</xsl:text>
															<xsl:value-of	select="$DivId" />
															<xsl:text>', '</xsl:text>
															<xsl:value-of	select="$ImageId" />
															<xsl:text>' );</xsl:text>
														</xsl:attribute>
													</img>
												</div>
											</xsl:when>
											<xsl:when	test="( affichage[ @mode = $MODE ] and affichage[ @mode = $MODE and @display = $DISPLAY_MINIMIZED ]  ) or ( not( affichage[ @mode = $MODE ] ) and ( affichage[ @mode = $DISPLAY_MODE_DEFAULT ] and affichage[ @mode = $DISPLAY_MODE_DEFAULT and @display = $DISPLAY_MINIMIZED ] ) )">
												<div>
													<xsl:attribute	name="id"><xsl:value-of	select="$ImageDivId" /></xsl:attribute>
													<img>
														<xsl:attribute	name="src"><xsl:value-of	select="$Image_Plus_Path" /></xsl:attribute>
														<xsl:attribute	name="id"><xsl:value-of	select="$ImageId" /></xsl:attribute>
														<xsl:attribute	name="width">16</xsl:attribute>
														<xsl:attribute	name="height">16</xsl:attribute>
														<xsl:attribute	name="style">cursor: pointer</xsl:attribute>
														<xsl:attribute	name="onclick">
															<xsl:text>javascript:SwitchDivVisibility( '</xsl:text>
															<xsl:value-of	select="$DivId" />
															<xsl:text>', '</xsl:text>
															<xsl:value-of	select="$ImageId" />
															<xsl:text>' );</xsl:text>
														</xsl:attribute>
													</img>
												</div>
											</xsl:when>
										</xsl:choose>
									</xsl:when>
									<xsl:otherwise>
										<xsl:text>&#160;</xsl:text>
									</xsl:otherwise>
								</xsl:choose>
							</td>
							<td>
								<b>
									<xsl:value-of	select="@nom" />
									<br />
									<xsl:value-of	select="abstract" />
								</b>
							</td>
						</tr>
					</table>
					<xsl:if	test="description or environnement-technique/technologie">
						<div>
							<xsl:attribute	name="id"><xsl:value-of	select="$DivId" /></xsl:attribute>
							<xsl:attribute	name="align">justify</xsl:attribute>
							<xsl:choose>
								<xsl:when	test="( affichage[ @mode = $MODE ] and affichage[ @mode = $MODE and @display = $DISPLAY_EXPANDED ] ) or ( not( affichage[ @mode = $MODE ] ) and ( affichage[ @mode = $DISPLAY_MODE_DEFAULT ] and affichage[ @mode = $DISPLAY_MODE_DEFAULT and @display = $DISPLAY_EXPANDED ]  ) )">
									<xsl:attribute	name="style">
										<xsl:text>display: block</xsl:text>
									</xsl:attribute>
								</xsl:when>
								<xsl:when	test="( affichage[ @mode = $MODE ] and affichage[ @mode = $MODE and @display = $DISPLAY_MINIMIZED ] ) or ( not( affichage[ @mode = $MODE ] ) and ( affichage[ @mode = $DISPLAY_MODE_DEFAULT ] and affichage[ @mode = $DISPLAY_MODE_DEFAULT and @display = $DISPLAY_MINIMIZED ] ) )">
									<xsl:attribute	name="style">
										<xsl:text>display: none</xsl:text>
									</xsl:attribute>
								</xsl:when>
							</xsl:choose>
							
							<table>
								<tr>
									<td	height="0" width="16">&#160;</td>
									<td height="0">
										<p	align="justify">
											<xsl:if	test="description">
												<u>Description</u>
												<br />
												<xsl:call-template	name="FormatStringForWeb">
													<xsl:with-param	name="String"
																	select="description"
																	/>
												</xsl:call-template>
											</xsl:if>
											<xsl:if	test="environnement-technique/technologie">
												<xsl:if	test="description">
													<br />
												</xsl:if>
												<u>Technologies</u>
												<br />
												<xsl:apply-templates	select="environnement-technique/technologie"
																		mode="experience">
												</xsl:apply-templates>
											</xsl:if>
										</p>
									</td>
								</tr>
							</table>
						</div>
					</xsl:if>
				</td>
			</tr>
			<script	language="javascript">
				<xsl:text>
					// on ajout l'image dans la liste des objets à ne pas imprimer
					_tabObjetANePasImprimer.push( '</xsl:text>
				<xsl:value-of	select="$ImageId" />
				<xsl:text>div' );
				</xsl:text>
			</script>
		</xsl:if>
	</xsl:template>

	<xsl:template	match="technologie"
					mode="experience">
		<xsl:if	test="not( position() = 1 )">
			<xsl:text>, </xsl:text>
		</xsl:if>
		<xsl:value-of	select="@nom" />	
	</xsl:template>
	
	<xsl:template	name="competences-techniques">
		<tr>
			<td	colspan="2"
				class="Titre2">
				<xsl:text>Compétences techniques</xsl:text>
			</td>
		</tr>
		<xsl:for-each	select="//types-technologies/type">
			<xsl:variable	name="TypeTechnologiqueName">
				<xsl:value-of	select="@nom" />
			</xsl:variable>
			<tr>
				<td	width="150"
					valign="top">
					<b>
						<xsl:value-of	select="." />
					</b>
				</td>
				<td>
					<table>
						<tr>
							<td	width="16"> </td>
							<td>
								<xsl:for-each	select="//donnees-experience/experience/environnement-technique/technologie[ @type = $TypeTechnologiqueName and not( preceding::technologie/@nom = @nom ) ]">
									<xsl:if	test="position() &gt; 1">
										<xsl:text>, </xsl:text>
									</xsl:if>
									<xsl:value-of	select="@nom" />
								</xsl:for-each>
							</td>
						</tr>
					</table>
				</td>
			</tr>
		</xsl:for-each>
	</xsl:template>

	<xsl:template	match="centre-d-interet">
		<xsl:variable	name="IdBaseName">
			<xsl:text>_experience_</xsl:text>
			<xsl:value-of select="position()" />
		</xsl:variable>

		<xsl:variable	name="DivId">
			<xsl:value-of	select="$IdBaseName" />
			<xsl:value-of	select="$DivBaseName" />
		</xsl:variable>
			
		<tr>
			<td	width="150"
				valign="top">
				<b>
					<xsl:value-of	select="@nom" />
				</b>
			</td>
			<td>
				<table>
					<tr>
						<td	width="16">
							<xsl:text>&#160;</xsl:text>
						</td>
						<td>
							<xsl:value-of	select="." />
						</td>
					</tr>
				</table>
			</td>
		</tr>
	</xsl:template>

<xsl:template match="node()">
	<xsl:value-of select="."  />
</xsl:template>
</xsl:stylesheet>