stages
* jenkins - optional
* ansible - as separate plays

hosts
* jenkins - as agents, runs on one server matching label
* ansible - as hosts, runs on all matching pattern, including localhost
* chef - self referential, more of a pull model, can't reference other nodes

actions
* jenkins - as steps, groovy functions, can take do block
* ansible - as tasks, data that specifies action and can template into values
* chef - as a DSL block that builds an action

variable assignment
* jenkins - language (imperative)
* ansible - using `register` that binds to runtime context
* chef - language

loops
* jenkins - language
* ansible - `with_items` over an interpreted statement
* chef - language

conditionals
* jenkins - `when` in declarative, language otherwise
* ansible - `when` an interpreted statement
* chef - language

notifiers
* ansible - separate tasks that get referenced
* chef - uses the `action` of pre determined modules, i.e. referencing a service

roles (reusable components using dsl)
* jenkins - vars that are functions that run more steps
* ansible - collections that have modules, notifiers, tasks, etc
* chef - cookbooks that have modules, notifiers, actions, etc

modules (reusable components that extend dsl)
* jenkins - vars and libraries
* ansible - python libraries that conform to Ansible's task API
* chef - resources that conform to Chef's API

ours
* stages - probably as something optional, might not be needed
* hosts - ??
* actions - either data or a builder that can create data
* variable assignments - probably either language or using an atom (updates Agent)
* notifiers - probably more like chef
* roles - probably as pure DSL, jobs can reference other jobs
* modules - might end up being a case of requiring a module being a port
