
{{ config(
  enabled=var('enable_transfer', false),
  post_hook=[
    'TRUNCATE TABLE ch_kant_gewaesserzustand_v1_2.messnetz, ch_kant_gewaesserzustand_v1_2.werterhebung, ch_kant_gewaesserzustand_v1_2.messgruppierung, ch_kant_gewaesserzustand_v1_2.standort, ch_kant_gewaesserzustand_v1_2.verantwortlichkeit, ch_kant_gewaesserzustand_v1_2.adresse, ch_kant_gewaesserzustand_v1_2.telefon, ch_kant_gewaesserzustand_v1_2.messgruppierung_hierarchie, ch_kant_gewaesserzustand_v1_2.messstationmessnetz, ch_kant_gewaesserzustand_v1_2.verantwortlichkeitmessgruppierung, ch_kant_gewaesserzustand_v1_2.verantwortlichkeitmessnetz, ch_kant_gewaesserzustand_v1_2.verantwortlichkeitwerterhebung, ch_kant_gewaesserzustand_v1_2.standortmessgruppierung_werterhebung',
    ili_utils.reset_ili_sequence(
      schema_name="ch_kant_gewaesserzustand_v1_2",
      starting_value=var('data_t_id_offset')
    )
  ]
)}}

SELECT 1