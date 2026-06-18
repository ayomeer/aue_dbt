<!DOCTYPE qgis PUBLIC 'http://mrcc.com/qgis.dtd' 'SYSTEM'>
<qgis simplifyAlgorithm="0" version="3.22.11-Białowieża" simplifyDrawingHints="1" hasScaleBasedVisibilityFlag="0" simplifyMaxScale="1" symbologyReferenceScale="-1" minScale="100000000" maxScale="0" labelsEnabled="0" readOnly="0" simplifyLocal="1" styleCategories="AllStyleCategories" simplifyDrawingTol="1">
  <flags>
    <Identifiable>1</Identifiable>
    <Removable>1</Removable>
    <Searchable>1</Searchable>
    <Private>0</Private>
  </flags>
  <temporal startExpression="" startField="" durationUnit="min" fixedDuration="0" mode="0" limitMode="0" endExpression="" accumulate="0" enabled="0" durationField="t_id" endField="">
    <fixedRange>
      <start></start>
      <end></end>
    </fixedRange>
  </temporal>
  <renderer-v2 enableorderby="0" type="singleSymbol" forceraster="0" referencescale="-1" symbollevels="0">
    <symbols>
      <symbol type="fill" name="0" alpha="1" clip_to_extent="1" force_rhr="0">
        <data_defined_properties>
          <Option type="Map">
            <Option type="QString" name="name" value=""/>
            <Option name="properties"/>
            <Option type="QString" name="type" value="collection"/>
          </Option>
        </data_defined_properties>
        <layer pass="0" enabled="1" class="SimpleFill" locked="0">
          <Option type="Map">
            <Option type="QString" name="border_width_map_unit_scale" value="3x:0,0,0,0,0,0"/>
            <Option type="QString" name="color" value="46,255,49,255"/>
            <Option type="QString" name="joinstyle" value="bevel"/>
            <Option type="QString" name="offset" value="0,0"/>
            <Option type="QString" name="offset_map_unit_scale" value="3x:0,0,0,0,0,0"/>
            <Option type="QString" name="offset_unit" value="MM"/>
            <Option type="QString" name="outline_color" value="100,160,10,255"/>
            <Option type="QString" name="outline_style" value="solid"/>
            <Option type="QString" name="outline_width" value="0.36"/>
            <Option type="QString" name="outline_width_unit" value="MM"/>
            <Option type="QString" name="style" value="solid"/>
          </Option>
          <prop v="3x:0,0,0,0,0,0" k="border_width_map_unit_scale"/>
          <prop v="46,255,49,255" k="color"/>
          <prop v="bevel" k="joinstyle"/>
          <prop v="0,0" k="offset"/>
          <prop v="3x:0,0,0,0,0,0" k="offset_map_unit_scale"/>
          <prop v="MM" k="offset_unit"/>
          <prop v="100,160,10,255" k="outline_color"/>
          <prop v="solid" k="outline_style"/>
          <prop v="0.36" k="outline_width"/>
          <prop v="MM" k="outline_width_unit"/>
          <prop v="solid" k="style"/>
          <data_defined_properties>
            <Option type="Map">
              <Option type="QString" name="name" value=""/>
              <Option name="properties"/>
              <Option type="QString" name="type" value="collection"/>
            </Option>
          </data_defined_properties>
        </layer>
      </symbol>
    </symbols>
    <rotation/>
    <sizescale/>
  </renderer-v2>
  <customproperties>
    <Option type="Map">
      <Option type="List" name="dualview/previewExpressions">
        <Option type="QString" value="&quot;t_datasetname&quot;"/>
      </Option>
      <Option type="int" name="embeddedWidgets/count" value="0"/>
      <Option type="invalid" name="variableNames"/>
      <Option type="invalid" name="variableValues"/>
    </Option>
  </customproperties>
  <blendMode>6</blendMode>
  <featureBlendMode>0</featureBlendMode>
  <layerOpacity>1</layerOpacity>
  <SingleCategoryDiagramRenderer diagramType="Histogram" attributeLegend="1">
    <DiagramCategory width="15" diagramOrientation="Up" lineSizeType="MM" labelPlacementMethod="XHeight" scaleDependency="Area" penAlpha="255" minScaleDenominator="0" spacing="5" minimumSize="0" rotationOffset="270" sizeType="MM" sizeScale="3x:0,0,0,0,0,0" backgroundAlpha="255" showAxis="1" backgroundColor="#ffffff" maxScaleDenominator="1e+08" spacingUnitScale="3x:0,0,0,0,0,0" lineSizeScale="3x:0,0,0,0,0,0" spacingUnit="MM" penColor="#000000" direction="0" enabled="0" barWidth="5" penWidth="0" opacity="1" scaleBasedVisibility="0" height="15">
      <fontProperties description="MS Shell Dlg 2,8.25,-1,5,50,0,0,0,0,0" style=""/>
      <attribute colorOpacity="1" field="" color="#000000" label=""/>
      <axisSymbol>
        <symbol type="line" name="" alpha="1" clip_to_extent="1" force_rhr="0">
          <data_defined_properties>
            <Option type="Map">
              <Option type="QString" name="name" value=""/>
              <Option name="properties"/>
              <Option type="QString" name="type" value="collection"/>
            </Option>
          </data_defined_properties>
          <layer pass="0" enabled="1" class="SimpleLine" locked="0">
            <Option type="Map">
              <Option type="QString" name="align_dash_pattern" value="0"/>
              <Option type="QString" name="capstyle" value="square"/>
              <Option type="QString" name="customdash" value="5;2"/>
              <Option type="QString" name="customdash_map_unit_scale" value="3x:0,0,0,0,0,0"/>
              <Option type="QString" name="customdash_unit" value="MM"/>
              <Option type="QString" name="dash_pattern_offset" value="0"/>
              <Option type="QString" name="dash_pattern_offset_map_unit_scale" value="3x:0,0,0,0,0,0"/>
              <Option type="QString" name="dash_pattern_offset_unit" value="MM"/>
              <Option type="QString" name="draw_inside_polygon" value="0"/>
              <Option type="QString" name="joinstyle" value="bevel"/>
              <Option type="QString" name="line_color" value="35,35,35,255"/>
              <Option type="QString" name="line_style" value="solid"/>
              <Option type="QString" name="line_width" value="0.26"/>
              <Option type="QString" name="line_width_unit" value="MM"/>
              <Option type="QString" name="offset" value="0"/>
              <Option type="QString" name="offset_map_unit_scale" value="3x:0,0,0,0,0,0"/>
              <Option type="QString" name="offset_unit" value="MM"/>
              <Option type="QString" name="ring_filter" value="0"/>
              <Option type="QString" name="trim_distance_end" value="0"/>
              <Option type="QString" name="trim_distance_end_map_unit_scale" value="3x:0,0,0,0,0,0"/>
              <Option type="QString" name="trim_distance_end_unit" value="MM"/>
              <Option type="QString" name="trim_distance_start" value="0"/>
              <Option type="QString" name="trim_distance_start_map_unit_scale" value="3x:0,0,0,0,0,0"/>
              <Option type="QString" name="trim_distance_start_unit" value="MM"/>
              <Option type="QString" name="tweak_dash_pattern_on_corners" value="0"/>
              <Option type="QString" name="use_custom_dash" value="0"/>
              <Option type="QString" name="width_map_unit_scale" value="3x:0,0,0,0,0,0"/>
            </Option>
            <prop v="0" k="align_dash_pattern"/>
            <prop v="square" k="capstyle"/>
            <prop v="5;2" k="customdash"/>
            <prop v="3x:0,0,0,0,0,0" k="customdash_map_unit_scale"/>
            <prop v="MM" k="customdash_unit"/>
            <prop v="0" k="dash_pattern_offset"/>
            <prop v="3x:0,0,0,0,0,0" k="dash_pattern_offset_map_unit_scale"/>
            <prop v="MM" k="dash_pattern_offset_unit"/>
            <prop v="0" k="draw_inside_polygon"/>
            <prop v="bevel" k="joinstyle"/>
            <prop v="35,35,35,255" k="line_color"/>
            <prop v="solid" k="line_style"/>
            <prop v="0.26" k="line_width"/>
            <prop v="MM" k="line_width_unit"/>
            <prop v="0" k="offset"/>
            <prop v="3x:0,0,0,0,0,0" k="offset_map_unit_scale"/>
            <prop v="MM" k="offset_unit"/>
            <prop v="0" k="ring_filter"/>
            <prop v="0" k="trim_distance_end"/>
            <prop v="3x:0,0,0,0,0,0" k="trim_distance_end_map_unit_scale"/>
            <prop v="MM" k="trim_distance_end_unit"/>
            <prop v="0" k="trim_distance_start"/>
            <prop v="3x:0,0,0,0,0,0" k="trim_distance_start_map_unit_scale"/>
            <prop v="MM" k="trim_distance_start_unit"/>
            <prop v="0" k="tweak_dash_pattern_on_corners"/>
            <prop v="0" k="use_custom_dash"/>
            <prop v="3x:0,0,0,0,0,0" k="width_map_unit_scale"/>
            <data_defined_properties>
              <Option type="Map">
                <Option type="QString" name="name" value=""/>
                <Option name="properties"/>
                <Option type="QString" name="type" value="collection"/>
              </Option>
            </data_defined_properties>
          </layer>
        </symbol>
      </axisSymbol>
    </DiagramCategory>
  </SingleCategoryDiagramRenderer>
  <DiagramLayerSettings priority="0" obstacle="0" placement="1" zIndex="0" linePlacementFlags="18" dist="0" showAll="1">
    <properties>
      <Option type="Map">
        <Option type="QString" name="name" value=""/>
        <Option name="properties"/>
        <Option type="QString" name="type" value="collection"/>
      </Option>
    </properties>
  </DiagramLayerSettings>
  <geometryOptions geometryPrecision="0" removeDuplicateNodes="0">
    <activeChecks/>
    <checkConfiguration type="Map">
      <Option type="Map" name="QgsGeometryGapCheck">
        <Option type="double" name="allowedGapsBuffer" value="0"/>
        <Option type="bool" name="allowedGapsEnabled" value="false"/>
        <Option type="QString" name="allowedGapsLayer" value=""/>
      </Option>
    </checkConfiguration>
  </geometryOptions>
  <legend type="default-vector" showLabelLegend="0"/>
  <referencedLayers/>
  <fieldConfiguration>
    <field name="t_id" configurationFlags="None">
      <editWidget type="TextEdit">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
    <field name="t_basket" configurationFlags="None">
      <editWidget type="TextEdit">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
    <field name="t_datasetname" configurationFlags="None">
      <editWidget type="TextEdit">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
    <field name="t_ili_tid" configurationFlags="None">
      <editWidget type="TextEdit">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
    <field name="teilobj_nr" configurationFlags="None">
      <editWidget type="TextEdit">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
    <field name="kt_flachmoor" configurationFlags="None">
      <editWidget type="TextEdit">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
  </fieldConfiguration>
  <aliases>
    <alias name="" field="t_id" index="0"/>
    <alias name="" field="t_basket" index="1"/>
    <alias name="" field="t_datasetname" index="2"/>
    <alias name="" field="t_ili_tid" index="3"/>
    <alias name="" field="teilobj_nr" index="4"/>
    <alias name="" field="kt_flachmoor" index="5"/>
  </aliases>
  <defaults>
    <default field="t_id" expression="" applyOnUpdate="0"/>
    <default field="t_basket" expression="" applyOnUpdate="0"/>
    <default field="t_datasetname" expression="" applyOnUpdate="0"/>
    <default field="t_ili_tid" expression="" applyOnUpdate="0"/>
    <default field="teilobj_nr" expression="" applyOnUpdate="0"/>
    <default field="kt_flachmoor" expression="" applyOnUpdate="0"/>
  </defaults>
  <constraints>
    <constraint constraints="3" notnull_strength="1" unique_strength="1" field="t_id" exp_strength="0"/>
    <constraint constraints="1" notnull_strength="1" unique_strength="0" field="t_basket" exp_strength="0"/>
    <constraint constraints="1" notnull_strength="1" unique_strength="0" field="t_datasetname" exp_strength="0"/>
    <constraint constraints="0" notnull_strength="0" unique_strength="0" field="t_ili_tid" exp_strength="0"/>
    <constraint constraints="1" notnull_strength="1" unique_strength="0" field="teilobj_nr" exp_strength="0"/>
    <constraint constraints="1" notnull_strength="1" unique_strength="0" field="kt_flachmoor" exp_strength="0"/>
  </constraints>
  <constraintExpressions>
    <constraint field="t_id" desc="" exp=""/>
    <constraint field="t_basket" desc="" exp=""/>
    <constraint field="t_datasetname" desc="" exp=""/>
    <constraint field="t_ili_tid" desc="" exp=""/>
    <constraint field="teilobj_nr" desc="" exp=""/>
    <constraint field="kt_flachmoor" desc="" exp=""/>
  </constraintExpressions>
  <expressionfields/>
  <attributeactions>
    <defaultAction value="{00000000-0000-0000-0000-000000000000}" key="Canvas"/>
  </attributeactions>
  <attributetableconfig sortExpression="&quot;t_ili_tid&quot;" sortOrder="0" actionWidgetStyle="dropDown">
    <columns>
      <column type="field" name="t_id" hidden="0" width="-1"/>
      <column type="field" name="t_basket" hidden="0" width="-1"/>
      <column type="field" name="t_datasetname" hidden="0" width="-1"/>
      <column type="field" name="teilobj_nr" hidden="0" width="-1"/>
      <column type="field" name="t_ili_tid" hidden="0" width="-1"/>
      <column type="field" name="kt_flachmoor" hidden="0" width="-1"/>
      <column type="actions" hidden="1" width="-1"/>
    </columns>
  </attributetableconfig>
  <conditionalstyles>
    <rowstyles/>
    <fieldstyles/>
  </conditionalstyles>
  <storedexpressions/>
  <editform tolerant="1"></editform>
  <editforminit/>
  <editforminitcodesource>0</editforminitcodesource>
  <editforminitfilepath></editforminitfilepath>
  <editforminitcode><![CDATA[# -*- coding: utf-8 -*-
"""
QGIS-Formulare können eine Python-Funktion haben,, die aufgerufen wird, wenn sich das Formular öffnet

Diese Funktion kann verwendet werden um dem Formular Extralogik hinzuzufügen.

Der Name der Funktion wird im Feld "Python Init-Function" angegeben
Ein Beispiel folgt:
"""
from qgis.PyQt.QtWidgets import QWidget

def my_form_open(dialog, layer, feature):
	geom = feature.geometry()
	control = dialog.findChild(QWidget, "MyLineEdit")
]]></editforminitcode>
  <featformsuppress>0</featformsuppress>
  <editorlayout>generatedlayout</editorlayout>
  <editable>
    <field name="bewertungseinheit" editable="1"/>
    <field name="kt_flachmoor" editable="1"/>
    <field name="kt_trockenwiese" editable="1"/>
    <field name="kt_trockenwiese_aname" editable="0"/>
    <field name="kt_trockenwiese_aufnahmedatum" editable="0"/>
    <field name="kt_trockenwiese_bedeutung" editable="0"/>
    <field name="kt_trockenwiese_herkunft" editable="0"/>
    <field name="kt_trockenwiese_kanton" editable="0"/>
    <field name="kt_trockenwiese_kartierungsgrundlage" editable="0"/>
    <field name="kt_trockenwiese_mutationsdatum" editable="0"/>
    <field name="kt_trockenwiese_mutationsgrund" editable="0"/>
    <field name="kt_trockenwiese_mutationsgrund_de" editable="0"/>
    <field name="kt_trockenwiese_mutationsgrund_en" editable="0"/>
    <field name="kt_trockenwiese_mutationsgrund_fr" editable="0"/>
    <field name="kt_trockenwiese_mutationsgrund_it" editable="0"/>
    <field name="kt_trockenwiese_mutationsgrund_rm" editable="0"/>
    <field name="kt_trockenwiese_obj_gisflaeche" editable="0"/>
    <field name="kt_trockenwiese_objnummer" editable="0"/>
    <field name="kt_trockenwiese_t_basket" editable="0"/>
    <field name="kt_trockenwiese_t_datasetname" editable="0"/>
    <field name="t_basket" editable="1"/>
    <field name="t_datasetname" editable="1"/>
    <field name="t_id" editable="1"/>
    <field name="t_ili_tid" editable="1"/>
    <field name="teilobj_nr" editable="1"/>
    <field name="teilobjekt" editable="1"/>
  </editable>
  <labelOnTop>
    <field name="bewertungseinheit" labelOnTop="0"/>
    <field name="kt_flachmoor" labelOnTop="0"/>
    <field name="kt_trockenwiese" labelOnTop="0"/>
    <field name="kt_trockenwiese_aname" labelOnTop="0"/>
    <field name="kt_trockenwiese_aufnahmedatum" labelOnTop="0"/>
    <field name="kt_trockenwiese_bedeutung" labelOnTop="0"/>
    <field name="kt_trockenwiese_herkunft" labelOnTop="0"/>
    <field name="kt_trockenwiese_kanton" labelOnTop="0"/>
    <field name="kt_trockenwiese_kartierungsgrundlage" labelOnTop="0"/>
    <field name="kt_trockenwiese_mutationsdatum" labelOnTop="0"/>
    <field name="kt_trockenwiese_mutationsgrund" labelOnTop="0"/>
    <field name="kt_trockenwiese_mutationsgrund_de" labelOnTop="0"/>
    <field name="kt_trockenwiese_mutationsgrund_en" labelOnTop="0"/>
    <field name="kt_trockenwiese_mutationsgrund_fr" labelOnTop="0"/>
    <field name="kt_trockenwiese_mutationsgrund_it" labelOnTop="0"/>
    <field name="kt_trockenwiese_mutationsgrund_rm" labelOnTop="0"/>
    <field name="kt_trockenwiese_obj_gisflaeche" labelOnTop="0"/>
    <field name="kt_trockenwiese_objnummer" labelOnTop="0"/>
    <field name="kt_trockenwiese_t_basket" labelOnTop="0"/>
    <field name="kt_trockenwiese_t_datasetname" labelOnTop="0"/>
    <field name="t_basket" labelOnTop="0"/>
    <field name="t_datasetname" labelOnTop="0"/>
    <field name="t_id" labelOnTop="0"/>
    <field name="t_ili_tid" labelOnTop="0"/>
    <field name="teilobj_nr" labelOnTop="0"/>
    <field name="teilobjekt" labelOnTop="0"/>
  </labelOnTop>
  <reuseLastValue>
    <field name="bewertungseinheit" reuseLastValue="0"/>
    <field name="kt_flachmoor" reuseLastValue="0"/>
    <field name="kt_trockenwiese" reuseLastValue="0"/>
    <field name="kt_trockenwiese_aname" reuseLastValue="0"/>
    <field name="kt_trockenwiese_aufnahmedatum" reuseLastValue="0"/>
    <field name="kt_trockenwiese_bedeutung" reuseLastValue="0"/>
    <field name="kt_trockenwiese_herkunft" reuseLastValue="0"/>
    <field name="kt_trockenwiese_kanton" reuseLastValue="0"/>
    <field name="kt_trockenwiese_kartierungsgrundlage" reuseLastValue="0"/>
    <field name="kt_trockenwiese_mutationsdatum" reuseLastValue="0"/>
    <field name="kt_trockenwiese_mutationsgrund" reuseLastValue="0"/>
    <field name="kt_trockenwiese_mutationsgrund_de" reuseLastValue="0"/>
    <field name="kt_trockenwiese_mutationsgrund_en" reuseLastValue="0"/>
    <field name="kt_trockenwiese_mutationsgrund_fr" reuseLastValue="0"/>
    <field name="kt_trockenwiese_mutationsgrund_it" reuseLastValue="0"/>
    <field name="kt_trockenwiese_mutationsgrund_rm" reuseLastValue="0"/>
    <field name="kt_trockenwiese_obj_gisflaeche" reuseLastValue="0"/>
    <field name="kt_trockenwiese_objnummer" reuseLastValue="0"/>
    <field name="kt_trockenwiese_t_basket" reuseLastValue="0"/>
    <field name="kt_trockenwiese_t_datasetname" reuseLastValue="0"/>
    <field name="t_basket" reuseLastValue="0"/>
    <field name="t_datasetname" reuseLastValue="0"/>
    <field name="t_id" reuseLastValue="0"/>
    <field name="t_ili_tid" reuseLastValue="0"/>
    <field name="teilobj_nr" reuseLastValue="0"/>
    <field name="teilobjekt" reuseLastValue="0"/>
  </reuseLastValue>
  <dataDefinedFieldProperties/>
  <widgets/>
  <previewExpression>"t_datasetname"</previewExpression>
  <mapTip></mapTip>
  <layerGeometryType>2</layerGeometryType>
</qgis>
