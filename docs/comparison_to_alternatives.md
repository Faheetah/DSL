# Overview

* Entry: how the program starts
* Instructions: what is used to describe how systems are configured
* Organizanization: how instructions are grouped to keep the code DRY
* Hosts: how hosts are managed to tell what system gets what instructions
* Variables: how are variables handled in regards to hosts and instructions
* Logging: what mechanisms facilitate viewing a successful run and what changed
* Extensibility: if the program does not support functionality, how is it added
* Idempotennce: what mechanism determines whether things should run again
* Secret Handling: how are secrets managed, if applicable

# Chef

* Entry: a local process on each host that runs a set of instructions that are fetched from a server
* Instructions: Ruby files using the Chef DSL
* Organization: via cookbooks, sets of reusable Ruby code, and roles that list cookbooks or other roles to run
* Hosts: determined by the entry point which specifies which parent roles to run, which connect to the Chef server
* Variables: assigned in arbitrary groups of variables, or on a per role basis
* Logging: process logs all output via system logging
* Extensibility: via Chef source using Ruby
* Idempotence: instructions (Chef DSL) are inherently idempotent, or allow hooks to determine idempotence
* Secret Handling: via providing encrypted values as variables

# Ansible

* Entry: on demand via CLI with a given YAML file
* Instructions: via tasks that are orchestrated by a YAML file
* Organization: using roles or collections, sets of reusable YAML code
* Hosts: a file, folder, or executable that provides a data structure describing inventory hierarchy, including groupings
* Variables: assigned in inventory, or set during runtime on a per task basis, or as defaults/constants
* Logging: console stdout, or via plugin or as a part of tower (can output JSON)
* Extensibility: via Ansible source using Python, or any executable that receives stdin and can stdout JSON
* Idempotence: instructions (modules) are inherently idempotent, or allow hooks to determine idempotence
* Secret Handling: via encrypting variable files or values directly, with Chef server having the master key

# Jenkins

* Entry: a given Groovy pipeline, in repo or provided inline
* Instructions: via a subset of Groovy, with additional modules imported by default, using Jenkins DSL and CPS
* Organization: pipelines can import other snippets, primarily through the `vars` directory in a project
* Hosts: connected to the main server as a node that can be specified as a target in pipelines
* Variables: via Jenkins plugins, or by setting a job parameter with a default value, or DIY, nodes can be assigned env vars
* Logging: each job tracks builds that run, each build is stored with its console output viewable on filesystem or via web UI
* Extensibility: handled via `vars` directory, or provide stand alone Groovy classes
* Idempotence: user is responsible for ensuring idempotence
* Secret Handling: includes its own secret store, with the server both encrypting and decrypting secrets

# Terraform/Packer

* Entry: on demand via CLI with a given Terraform or Packer script
* Instructions: with HCL that details steps to take
* Organization: some ability to abstract with reusable code
* Hosts: treated as cattle, host groups are provisioned based off of a golden image, hosts are tracked as provisioned or not
* Variables: minimally via env vars and importing variable config files
* Logging: via stdout from the comand line
* Extensibility: minimal, generally by either shell scripts or a module that runs as its own service using go-plugin
* Idempotence: services provisioned are idempotent, Packer is not
* Secret Handling: as env vars or using Vault

# Docker/Kubernetes

* Entry: CLI for docker, via API or web interface for Kubernetes
* Instructions: using Dockerfile DSL, minimal functionality, leaning heavily on shell scripting
* Organization: Kubernetes has a robust DSL for orchestrating infrastructure, otherwise Dockerfiles are minimal
* Hosts: treated as cattle, host groups are referenced as pods and provisioned off of a golden image
* Variables: exclusively with env vars
* Logging: stdout for Docker, API or web interface for Kubernetes
* Extensibility: almost nonexistant for functionality, templates can be provided with helm for reusable specs
* Idempotence: services provisioned are idempotent, building a container is not
* Secret Handling: via a service with Kubernetes, or env vars
