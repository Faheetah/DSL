# Definitions

## Inventory

IPAM can be in a database but can be read in from a file too

### host

single instance

### group

reference to a collection of instances, can be treated like a host but applies to all

### host_var

variable for a specific host, overrides group vars

### group_var

variable for a group of hosts

### role

a policy that can be assigned to a host or group, can include jobs, other roles, and triggers

### role_var

variable that is specific for a role

### secret

a store of variables and files that are symmetrically or asymmetrically encrypted

## Jobs

### job

a collection of tasks that run modules, has inputs (and defaults) and outputs that are derived from context, jobs are composed

### action

a single action, represents a MFA call

### trigger

a conditional action, it can run a job or run as a result of the job, i.e. when a certain task is performed

### context

the list of state for a server, things like dynamic variables, what jobs have ran (with an alias for latest), etc

### execution

an execution of a job or role that gets logged, logging detail depends on log backend (name pending, log?)


# Variable hierarchy

Variables go from most to least specific

host > group > role > job default


# Roles

Role defaults, vars that can get overridden

## Ours



## Ansible

inventories/
  host_vars/
  group_vars/
group_vars/
roles/x/defaults
roles/x/vars

## Chef

recipes/x/attributes
databags/
roles/
