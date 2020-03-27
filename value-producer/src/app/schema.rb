require 'avro_turf'
require 'avro_turf/confluent_schema_registry'

schema = <<-JSON
{"name": "values",
  "type": "record",
  "fields": [
      {"name": "name", "type": "string"},
      {"name": "number",  "type": "int"},
      {"name": "time",  "type": "int"}
  ]
 }
 JSON

 registry = AvroTurf::ConfluentSchemaRegistry.new("http://schema-registry:28081")

 puts registry.compatible?("values", schema)