resource "kubernetes_deployment" "frontend" {
  metadata {
    name = "frontend"
    labels = {
      app = "frontend"
    }
  }

  spec {
    replicas = 2

    selector {
      match_labels = {
        app = "frontend"
      }
    }

    template {
      metadata {
        labels = {
          app = "frontend"
        }
      }

      spec {
        containers {
          name  = "frontend"
          image = "your-docker-repo/nextjs-frontend:latest"

          ports {
            container_port = 3000
          }

          env {
            name  = "API_URL"
            value = "http://backend:3001"
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "frontend" {
  metadata {
    name = "frontend"
  }

  spec {
    selector = {
      app = "frontend"
    }

    ports {
      port        = 80
      target_port = 3000
    }

    type = "LoadBalancer"
  }
}
