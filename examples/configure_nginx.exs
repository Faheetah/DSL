use DSL

notifier :restart_nginx do
  service do
    name "nginx"
    state "restarted"
  end
end

yum do
  package "nginx"
end

template notifies: :restart_nginx, sudo: true do
  source "nginx.conf"
  dest "/etc/nginx/nginx.conf"
  mode 0700
end
