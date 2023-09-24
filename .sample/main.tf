terraform {
  required_providers {
    coder = {
      source = "coder/coder"
      # See latest version: https://registry.terraform.io/providers/coder/coder
      version = ">= 0.12.0"
    }
  }
}

# This example does not provision any resources. Use this
# template as a starting point for writing custom templates
# using any Terraform resource/provider.
#
# See: https://coder.com/docs/coder-oss/latest/templates

data "coder_workspace" "me" {
}

resource "coder_agent" "dev1" {
  os   = "linux"
  arch = "amd64"
  auth = "token"
}

# Add a web IDE
module "code-server" {
  source   = "https://registry.coder.com/modules/code-server"
  agent_id = coder_agent.dev1.id
}
resource "null_resource" "fake-compute" {
  # When a workspace is stopped, this resource is destroyed.
  count = data.coder_workspace.me.transition == "start" ? 1 : 0

  provisioner "local-exec" {
    command = "echo 🔊 ${data.coder_workspace.me.owner} has started a workspace named ${data.coder_workspace.me.name}. Template: TEMPLATE_NAME"
  }

  # Run the Coder agent init script on resources
  # to access web apps and SSH:
  #
  # #!/bin/sh
  # export CODER_AGENT_TOKEN=${coder_agent.dev1.token}
  # ${coder_agent.dev1.init_script}
}

resource "null_resource" "fake-disk" {
  # This resource will remain even when workspaces are restarted.
  count = 1
}
