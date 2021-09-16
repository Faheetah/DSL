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
