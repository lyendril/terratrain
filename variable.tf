  variable "server_port" {
    description = "port utilisé par http"
    default = 80
  }

  variable "max_asg" {
    description = "nombre max dans l'autoscalling"
    default     = 3
  }

  variable "min_asg" {
    description = "nombre min dans l'autoscalling"
    default     = "1"
  }
