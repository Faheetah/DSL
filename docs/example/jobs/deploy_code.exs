Job.stage "copy code", hosts: "app" do
  Job.subscribe :restart_nginx, fn -> Systemd.restart("nginx") end

  File.rsync "some/path",
    source: "some/file.tar.gz",
    from: :job_or_node_reference

  for item <- ["foo", "bar"] do
    File.template "some/#{item |> String.upcase}.yml"
      source: "some/#{file}.yml"
      notify: :restart_nginx
    end
  end
end

Job.stage "migrations", hosts: "app01", strategy: :one do
  System.shell "./migrate"
end

Job.stage "purge cache", hosts: "app", when: Job.stage("copy code").changed? do
  System.shell "./cache purge"
end
