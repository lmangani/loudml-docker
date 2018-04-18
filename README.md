<img src="http://loudml.io/wp-content/uploads/2018/01/LoudML3-300x147.png" />

# loudml-docker
[Loudml](http://loudml.io) API+ Tensorflow + Jupyter bundle for Developers

For Model Configuration, API and Features see the guide at [loudml.io](http://loudml.io/guide/en/loudml/reference/current/cli.html)

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


###### Logo and Trademarks are © 2018 Loud ML™. All rights reserved.
