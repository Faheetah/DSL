[
  [host: "web1"],
  [host: "web2"],
  [group: "web", hosts: ["web1", "web2"]],
  [
    group: "db",
    hosts: [
      [host: "db1", vars: [primary: true]],
      "db2"
    ]
  ],
  [
    hooks: [
      [git: "reponame", repo: "github.com/reponame"]
    ]
  ],
  [
    role: "deploy_code",
    triggers: [
      [cron: "cron", schedule: "hourly"],
      [trigger: "reponame"]
    ],
    jobs: [
      [job: "deploy_code", vars: [branch: "release_branch"]]
    ]
]

host
group has hosts, groups
hooks
roles has hosts, groups, hooks, jobs, roles

add a host
add another host
set both hosts to a group
add a hook
add a role with jobs
add the role to a host or a group

the inventory gets translated down to what server runs what when
the server itself only has a list of what it needs to run

load a job, it gets sent out to the hosts configured with it,
along with the role, and that determines what runs.

Also roles might need to be what the server does, which still lines up, but
like a build server might have a trigger from the server, systems
config might have a cron trigger
Could have some default role templates or something too

role: cicd
has roles: [base, build_server]

There's also the problelm of how do roles and triggers nest

also problem with triggers, does server trigger, or on host?
