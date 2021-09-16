# Running

Jobs can be ran by the server or directly on nodes. If a job is ran on the server it can delegate tasks out to nodes, like a CICD server would.

If a job is set to run on a server (pull model) then it cannot have any node blocks, it must consist of only tasks. In this case, the server is implicitly running a job with a node(:self) block.

Jobs can also run on the server with no nodes. In this model the server acts as a scheduler and can utilize plugins directly to make HTTP or shell (if allowed) out. This mode also allows for the server to act as a provisioner for infrastructure.

The server can also run as a node itself locally, i.e. to run a one off job that could server to run a CICD pipeline or to provision infrastructure. It can either be ran as a command, passing in a job to run, or be ran as a local build server that can listen to things like git commits. In this mode, nodes are also not allowed as the server is running akin to running on a node.

# Server

Only concerned with orchestrating jobs to nodes. Generates configurations that nodes can subscribe to and pull.

# Node

A node runs simple tasks with a limited context. It can run all of the modules, except for nodes. This is a hard requirement to avoid the complexities and limitations that CPS brings with serializing steps. Nodes are ran from command line and get their job configs either from a server via HTTP or from local configurations. The job configs are serialized and stored in a disk backed in memory database. This database also stores job run history.
