require 'avro_turf/messaging'
require 'kafka'

# You need to pass the URL of your Schema Registry.
avro = AvroTurf::Messaging.new(registry_url: "http://schema-registry:28081/", schemas_path: "value-comsumer/src/app/schemas")

# These commands are all from kafka-ruby for setting up a consumer
kafka = Kafka.new(["localhost:9092"])
consumer = kafka.consumer(group_id: "number-consumer")
consumer.subscribe("number")

puts "the consumer is running"

# This will loop indefinitely, yielding each message in turn.
consumer.each_message do |message| 
  # By passing in `schema_name:`, you guard against the producer changing
  # the schema in an incompatible way. You can leave out the argument, in
  # which case you'll just get whatever data the producer encoded out, with
  # no schema compatibility guarantees.
  event_message = avro.decode(message.value, schema_name: "values")
  puts event_message #=> { "title" => "hello, world" }
  puts ''
end