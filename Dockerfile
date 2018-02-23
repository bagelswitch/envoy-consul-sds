FROM alpine:latest
ADD build/linux/amd64/envoy-consul-sds /envoy-consul-sds
CMD ["sh", "-c", "/envoy-consul-sds --port 8444 --consul-http-addr ${NOMAD_IP_webserver}:8500 --consul-datacenter ${NOMAD_META_consuldc}"]
