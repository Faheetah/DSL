use DSL

# this would be an example of using a host to execute
# on other hosts from a server setting

host "build" do
  dir "examples" do
    shell "mix deps.get"
    shell "mix compile"
    shell do
      env [MIX_ENV: "prod"]
      script "mix release"
    end
  end
end

host "application" do
  # ansible like deployment stuff
end
