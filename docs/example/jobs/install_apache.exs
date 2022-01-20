Job.trigger Time.cron(:hourly)

Apt.install "apache", update: true

Systemd.service "apache2", action: [:enable, :start]

File.mkdir node["main"]["doc_root"],
  owner: "www-data",
  group: "www-data",
  mode: "0644",
  recurse: true

File.copy "#{node["main"]["doc_root"]}/index.html",
  source: "index.html",
  owner: "www-data",
  group: "www-data"

File.template "/etc/apache2/sites-available/000-default.conf",
  source: "vhost.eex",
  variables: [
    doc_root: node["main"]["doc_root"]
  ]
