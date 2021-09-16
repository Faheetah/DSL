# Actions

An action is called as a function in the DSL. It can take some additional parameters via keyword lists, in addition to the do block.

name: name of the task (otherwise tagged with the ID)
dir: directory context to run in
save_log: boolean whether to save the logged output (default false)
changed_when: condition for whether the action shows changed
failed_when: condition for whether the action shows changed
node: node to delegate the task to (requires server connectivitiy)

# Required functionality

Conditions (when)
Register variable (implicit on name)
