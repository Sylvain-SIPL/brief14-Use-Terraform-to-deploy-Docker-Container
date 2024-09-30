terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "3.0.2"
    }
  }
}

#configure the docker provider

provider "docker" {}

resource "docker_image" "nginx" {
  name         = "nginx:latest"
  keep_locally = false
}

#Create a docker container resource

resource "docker_container" "nginx" {
  image = docker_image.nginx.name
  name  = "nginx_app"
  ports {
    external = 8000
    internal = 80
  }
  upload {
    source = "index.html"
    file   = "/usr/share/nginx/html/index.html"
  }
}
