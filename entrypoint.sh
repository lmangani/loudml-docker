#!/bin/bash

#export elastic_url="localhost:9200"
#export elastic_index="logstash-*"
#export influx_addr="localhost:8086"
#export influx_database="telegraf"

show_help() {
cat << EOF
Bad Options!
EOF
exit 0;
}

# Set container parameters
while true; do
  case "$1" in
    --elastic )
      if [ "$2" == "" ]; then show_help; fi;
      elastic_url=$2;
      shift 2 ;;
    --elastic_index )
      if [ "$2" == "" ]; then show_help; fi;
      elastic_index=$2;
      shift 2 ;;
    --influx )
      if [ "$2" == "" ]; then show_help; fi;
      influx_addr=$2;
      shift 2 ;;
    --influx_database )
      if [ "$2" == "" ]; then show_help; fi;
      influx_database=$2;
      shift 2 ;;
    -- ) shift; break ;;
    * ) break ;;
  esac
done

if [[ -n "$influx" || -n "$elastic" ]]; then
mv /etc/loudml/config.yml /etc/loudml/config.backup
rm -rf temp.yml
( echo "cat <<EOF>/etc/loudml/config.yml";
  cat /template.yml;
  echo "EOF";
) >temp.yml
. temp.yml
cat /etc/loudml/config.yml
fi

jupyter notebook --allow-root --notebook-dir=/tensorflow/models/research/object_detection --ip='*' --port=8888 --no-browser &
loudmld
