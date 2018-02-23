job "envoy-proxy" {
  datacenters = ["dc1"]
  type = "system"
  meta {
    domain = "intb2.ciscospark.com"
    consuldc = "aint2"
  }
  update {
    stagger = "5s"
    max_parallel = 1
  }
  
  group "envoy" {
    count = 1
    task "envoy" {
      constraint {
          attribute = "${node.class}"
          value = "edge"
      }
      driver = "docker"
      config {
        image = "lyft/envoy:4640fc028d65a6e2ee18858ebefcaeed24dffa81"
        command = "/usr/local/bin/envoy"
        args = [
            "--concurrency 4",
            "--config-path /etc/envoy.json",
            "--mode serve",
        ]
        volumes = ["local/envoy.json:/etc/envoy.json" ]
        network_mode = "host"
        ssl = true
      }
      artifact {
        source = "https://gist.githubusercontent.com/bagelswitch/9d2861075ea99c84e9eed3f7b2b08793/raw/fc3d3539ab167dd9321d216af710fb97bebae834/envoy.json"
      }
      resources {
        network {
          mbits = 1
          port "envoy" {
            static = 8443 
          }
        }
      }
    }
  }
}
