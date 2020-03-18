Role Name
=========

This role configures a gateway to connect the network in the German DC with the networks in French DC.

Requirements
------------

Any pre-requisites that may not be covered by Ansible itself or the role should be mentioned here. For instance, if the role uses the EC2 module, it may be a good idea to mention in this section that the boto package is required.

Role Variables
--------------

A description of the settable variables for this role should go here, including any variables that are in defaults/main.yml, vars/main.yml, and any variables that can/should be set via parameters to the role. Any variables that are read from other roles and/or the global scope (ie. hostvars, group vars, etc.) should be mentioned here as well.

Dependencies
------------

A list of other roles hosted on Galaxy should go here, plus any details in regards to parameters that may need to be set for other roles, or variables that are used from other roles.

Example Playbook
----------------

Including an example of how to use your role (for instance, with variables passed in as parameters) is always nice for users too:

    - hosts: servers
      roles:
         - { role: username.rolename, x: 42 }

License
-------

MIT

Author Information
------------------

An optional section for the role authors to include contact information, or a website (HTML is not allowed).


Testing
=======

I do like this:

```
pipenv install
pipenv shell
molecule test --scenario-name hcloud
```

Or to debug:
```
molecule create --scenario-name hcloud
...
molecule destroy --scenario-name hcloud
```

TODO
====

* Update README
* what to do with pipenv?
* License?
* What to check? ``ipsec status`` is not going to work
  * Actual connection to the FR gateway is not going to work
  * Don't run ``ip route show`` cause the route are loaded AFTER connecting to the other ipsec end, which doesn't happen during tests.
* Tokens and credentials
  * Ansible Vault
  * Rotate
