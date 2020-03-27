require 'avro_turf/messaging'
require 'date'
require 'kafka'
require 'timeloop'

# connects to the local Kafka instance
kafka = Kafka.new(["localhost:9092"])

# You need to pass the path to the avro schema file
avro = AvroTurf::Messaging.new(registry_url: "http://schema-registry:28081", schemas_path: "value-producer/src/app/schemas")

# uses the ruby-kafka library to set up an asyncronous producer
producer = kafka.async_producer

NAMES = ['David', 'Melissa', 'Nancy']

def generate_object
  { name: NAMES.sample, 
    number: rand(100),
    time:  DateTime.now.to_s}       
end

# uses the Timeloop library to set up an interval
Timeloop.every 2.seconds do
  msg = generate_object
# Encoding data has the side effect of registering the schema. This only
# happens the first time a schema is used with the instance of `AvroTurf`.
  data = avro.encode(msg, schema_name: "values")

  producer.produce(data, topic: "number") # `.produce` is a method from the ruby-kafka library
  producer.deliver_messages             # `.deliver_messages` is another method from the ruby-kafka library
  puts msg
end

# producer.shutdown