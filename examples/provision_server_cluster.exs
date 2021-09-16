use DSL

network = LibVirt.network(...)
storage = LibVirt.volume(...)
vm = LibVirt.vm(network: network, storage: storage, ...)
