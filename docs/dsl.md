# Basic

Syntax is derived as a subset of Elixir. All basic types and operators are allowed.

Ultimately the DSL needs to transpile down into a data structure. What seems to make the most sense is to use a language that builds an instruction set as it allows some flexibility to the user in building that structure, and better orchestration of events under the hood. It also allows more explicit types over YAML, as well as being easier to read. Do blocks allow composing steps versus defining steps.

# Problems

How to handle assignments of steps, each step should probably have a name, maybe as the first param of a task?

Also, tasks could take keyword lists O.O

# Example

```elixir
triggers do
  Trello.webhook
    name: "fuzz",
    when: "some conditional"
  do
    type createCard
    data.card.name "!stats"
  end
end

tasks do
  Trello.search do
    query "label:New"
  end
end
```

# Full syntax for DSL

* Entry: as a CLI for single jobs, or a local process on a host that pulls from a server
* Instructions: Using a subset of Elixir with modules imported in
* Organization: Jobs can run other jobs passing context
* Hosts: connected to the main server which pushes configs to nodes
* Variables: from arbitrary groups of vars on the server determined by host tag, by vars assigned to the host, or as constants/defaults per job
* Logging: process logs all output to a local log file that can be read on filesystem, or streamed through server if client is connected
* Extensibility: via BEAM files conforming to module specs, or by external commands that accept input on stdin and stdout provides status
* Idempotence: instructions are inherently idempotent, or allow hooks to determine idempotence
* Secret Handling: includes own secret store, with the server encrypting and client decrypting secrets

# Usage

DSL covers broad use cases and orchestration.

# Use cases

## Defined as

**jobs**: a collection of tasks with defined input parameters and job wide hooks, jobs can be broken up into stages
(jobs, playbooks, roles, recipes)

**actions**: a single change that is performed, can be idempotent
(tasks, actions, steps)

**triggers**: a condition that triggers the beginning of a job, i.e. webhook or timer
(typically not named)

**hooks**: a global action that gets triggered, such as for each task, at the end of a job, as a notifier that another action or job needs to run after another job finishes
(handlers, notifiers)

**vars**: a way to organize variables for jobs, across hosts, groups of hosts, etc, can be encrypted at server or host level (likely the best way is to use something like GPG and have the server allow hosts' encryption keys to decrypt the secret, allowing unidirectional encryption)
(vars, group_vars)

**nodes**: a remote system that code runs on, as dictated by the server
(nodes, hosts, agents, clients)

**tags**: a way to tag similar servers that share variables, strategies allow dispatching to any or all, can be self referential so tags can reference groups of tags
(roles, labels, tags, groups)

## CICD (Jenkins)

Syntax is pretty flexible here

Nodes jobs triggers and actions are pretty straightforward. Some need for vars, especially for secrets handling.

Components used

* nodes runs jobs on demand, timer trigger might be node level, single dispatch
* jobs
* triggers

## Configuration management (Chef)

Works very similarly to CICD except nodes use a timer trigger to run, timer triggers should probably be configurable to run on the node itself or the server (maybe server reconfigures timers as needed).

* nodes stand alone, pulls config from server, multiple dispatch
* jobs
* triggers generally just limited to timer, by the node itself
* hooks

## Push model deployment (Ansible)

Nodes normally aren't a part of a push model. It is plausible to just ensure OTP is intalled on each target node and the server connects via SSH and pushes ETF or something out, and has a command that loads and runs the ETF. Downside is secret decryption would have to be on the server as it pushes ETF out.

* vars both host and groups
* jobs primarily drives functionality
* hooks

## Systems provisioning (Terraform)

Pretty much CICD use case but the actions are oriented towards creating infrastructure. When used with hooks, can be used as an API to provision infrastructure.

* jobs specifies what to provision
* vars
* hooks

## Job scheduler (Hangfire)

Works like CICD with a timer but with actions being generic like webhooks or shell commands.

* jobs
* triggers (timer mainly)

## Orchestration engine (Conductor)

Same as job scheduler, but with more complexity.

* jobs
* hooks
* triggers
