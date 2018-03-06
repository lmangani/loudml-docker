# loudml-docker
[Loudml](http://loudml.io) API+ Tensorflow + Jupyter bundle for Developers

### Dev Run
Start container w/ local configuration file:
```
docker run --name loudml -p 8888:8888 -p 8077:8077 \
       -v $(pwd)/config.yml:/etc/loudml/config.yml \
       -d qxip/loudml:latest
```

### ENV
Parameters can optionally be defined via ENV variables:
```
elastic: 127.0.0.1:9200
elastic_index: logstash-*
influx: 127.0.0.1:8086
influx_database: telegraf
```
