resource "kubernetes_deployment" "nginx" {
  metadata {
    name = "project-x-nginx"
    labels = {
      App = "project-x-nginx"
    }
  }

  spec {
    replicas = 2
    selector {
      match_labels = {
        App = "project-x-nginx"
      }
    }
    template {
      metadata {
        labels = {
          App = "project-x-nginx"
        }
      }
      spec {
        container {
          image = "nginx:1.21.0"
          name  = "project-x-container"

          port {
            container_port = 80
          }

          resources {
            limits = {
              cpu    = "0.5"
              memory = "256Mi"
            }
            requests = {
              cpu    = "150m"
              memory = "30Mi"
            }
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "nginx-service" {
  metadata {
    name = "nginx-service"
  }
  spec {
    selector = {
      App = kubernetes_deployment.nginx.spec.0.template.0.metadata[0].labels.App
    }
    port {
      port        = 80
      target_port = 80
    }

    type = "LoadBalancer"
  }
}