Job.configure strategy: :one, host: :any, when: @trigger.type == "push"

Job.stage "single stage", strategy: :all do
  IO.puts "some step"
end

Job.stage "parallel stages", when: @trigger in ["main", "another"] do
  Job.stage "one", async: true, host: "build", strategy: :one do
    System.shell "some command"
  end

  Job.stage "two", async: true, host: "build", strategy: :one do
    Credential.bind("foo", user: "USER", password: "PASSWORD") do
      System.shell "another command but using $USER and $PASSWORD"
      IO.puts "can also use the bound vars directly like #{@env["USER"]} but they will be masked"
    end
  end

  Job.await(["one", "two"])
end
