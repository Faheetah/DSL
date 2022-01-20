```yaml
- hosts: hostlabel
  gather_facts: false
  tasks:
  - yum:
      name: nginx
      state: intsalled

  - name: template
    template:
      src: "{{ item }}.yml"
      dest: some/{{ item | uppercase }}.yml
    register: template
    changed_when: template.changed
    when: somevar is true
    with_items: [foo, bar]
    notifies: restart_nginx # another task specified in handlers

  - debug:
      msg: "Template changed is {{ template.changed }}"
```
