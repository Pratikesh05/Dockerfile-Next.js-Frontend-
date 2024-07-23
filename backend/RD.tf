resource "kubernetes_deployment" "postgres" {
  metadata {
    name = "postgres"
    labels = {
      app = "postgres"
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "postgres"
      }
    }

    template {
      metadata {
        labels = {
          app = "postgres"
        }
      }

      spec {
        containers {
          name  = "postgres"
          image = "postgres:latest"

          env {
            name  = "POSTGRES_USER"
            value = "user"
          }

          env {
            name  = "POSTGRES_PASSWORD"
            value = "password"
          }

          ports {
            container_port = 5432
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "postgres" {
  metadata {
    name = "postgres"
  }

  spec {
    selector = {
      app = "postgres"
    }

    ports {
      port        = 5432
      target_port = 5432
    }
  }
}
