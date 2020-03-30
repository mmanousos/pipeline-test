CREATE STREAM val_numbers (name VARCHAR, number INT, time VARCHAR) WITH (kafka_topic = 'number', partitions = 1, key = 'name', value_format = 'AVRO');

INSERT INTO val_numbers (name, number, time) VALUES ('Nancy', 22, '12:22:15');
INSERT INTO val_numbers (name, number, time) VALUES ('David', 45, '12:22:16');
INSERT INTO val_numbers (name, number, time) VALUES ('Melissa', 15, '12:22:17');
INSERT INTO val_numbers (name, number, time) VALUES ('Nancy', 75, '12:22:18');