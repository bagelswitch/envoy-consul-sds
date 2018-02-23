job "envoy-consul-sds" {
  datacenters = ["dc1"]
  type = "system"
  meta {
    domain = "intb2.ciscospark.com"
    consuldc = "aint2"
  }
  group "webserver" {
    count = 1
    task "envoy-consul-sds" {
      constraint {
          attribute = "${node.class}"
          value = "edge"
      }

      driver = "docker"
      config {
        image = "783772908578.dkr.ecr.us-west-2.amazonaws.com/splat/envoy-consul-sds:0.0.7"
        network_mode = "host"
        ssl = true
      }
      service {
        name = "envoy-consul-sds"
        tags = ["sds"]
        port = "webserver"
        check {
          type     = "tcp"
          port     = "webserver"
          interval = "10s"
          timeout  = "2s"
        }
      }
      resources {
        network {
          mbits = 1
          port "webserver" {
            static = 8444
          }
        }
      }
    }
  }
}
