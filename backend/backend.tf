resource "kubernetes_deployment" "backend" {
  metadata {
    name = "backend"
    labels = {
      app = "backend"
    }
  }

  spec {
    replicas = 2

    selector {
      match_labels = {
        app = "backend"
      }
    }

    template {
      metadata {
        labels = {
          app = "backend"
        }
      }

      spec {
        containers {
          name  = "backend"
          image = "your-docker-repo/nestjs-backend:latest"

          ports {
            container_port = 3001
          }

          env {
            name  = "DATABASE_URL"
            value = "postgres://user:password@postgres:5432/dbname"
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "backend" {
  metadata {
    name = "backend"
  }

  spec {
    selector = {
      app = "backend"
    }

    ports {
      port        = 3001
      target_port = 3001
    }
  }
}
