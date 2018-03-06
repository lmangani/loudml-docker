FROM debian:9
RUN apt-get update && yes | apt-get upgrade
RUN mkdir -p /tensorflow/models
RUN apt-get install -y git python-pip apt-transport-https wget curl python3 python3-pip
RUN easy_install -U pip
RUN pip install tensorflow
RUN apt-get install -y protobuf-compiler python-pil python-lxml
RUN pip install jupyter
RUN pip install matplotlib
RUN git clone https://github.com/tensorflow/models.git /tensorflow/models

WORKDIR /tensorflow/models/research
RUN protoc object_detection/protos/*.proto --python_out=.
RUN export PYTHONPATH=$PYTHONPATH:`pwd`:`pwd`/slim
RUN jupyter notebook --generate-config --allow-root
RUN echo "c.NotebookApp.password = u'sha1:6a3f528eec40:6e896b6e4828f525a6e20e5411cd1c8075d68619'" >> /root/.jupyter/jupyter_notebook_config.py

RUN pip3 install 'influxdb>=5.0.0' && \
    pip3 install 'elasticsearch>=5.4.0' && \
    pip3 install 'tensorflow<=1.3.1,>=1.3.0' && \
    pip3 install 'hyperopt==0.1' && \
    pip3 install 'dateutils>=0.6.6'

RUN echo "deb http://loudml.s3-website-eu-west-1.amazonaws.com/repo/deb/ stretch main" | tee -a /etc/apt/sources.list.d/loudml-1.x.list
RUN apt-get -y update && apt-get install -y --allow-unauthenticated loudml-elastic loudml-influx

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 8888 8077

ENTRYPOINT ["/entrypoint.sh"]
