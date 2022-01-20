I think most use cases would revolve around the main server acting exclusively as a job scheduler and orchestrator. We're not doing this in the context of ad hoc executions, use Ansible for that.

# Use cases

## Deployment Orchestration

Like Ansible and Jenkins

Individual hosts subscribe to Server waiting for instruction to run, this would allow servers to "catch up" later if they failed to run (configurable?). Parent job for the deploy, the job triggers child jobs that are assigned to specific nodes.

hosts: defined as what runs when
triggers: initial trigger is whatever (ad-hoc, webhook, etc), subsequent runs are pubsubs to the original job
roles: defined by triggers

## System Configuration

Like Ansible and Chef

hosts: self
triggers: timer
roles: list of roles to grab from the server

## Security and Compliance

Similar to System Configuration, can also execute external checks if a scan node is defined. Security check would basically be a trigger that a condition is not met. Basically a subscription to a job result, for security checks would be a read only check.

## Build Server

Like Jenkins

hosts: defined as the agents that builds run on
triggers: probably has to proxy them through somehow, maybe orchestrator sets up a proxy under the hood, could also help for agents making API calls if it was bidirectional
roles: pretty much like any regular build job

## Job Scheduler

Basically handled by Build Server

## Provisioning

Probably not directly related to running jobs, but an extension of IPAM for creating assets, and then it can provision a client on the host and run jobs to configure it.

## Monitoring and Logging

Also probably not directly related to running jobs, other than maybe the metrics collection itself.
