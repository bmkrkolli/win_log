Welcome to Continuous Engineering organisation.
===============================================

Contributing
------------

If You would like to contribute to an ansible asset please follow [Contributing Guide](https://github.kyndryl.net/Continuous-Engineering/Community-guidelines/blob/master/CONTRIBUTING.md).

Feel free to edit the README.md file as needed, it is pre-populated to fit ansible role.

Asset Name
---------

Windows EventLog Policy.
- This playbook collects information about the Windows EventLog setings.

Requirements
------------

This Ansible playbook is using [ReturnCode Role](https://github.kyndryl.net/Continuous-Engineering/ansible_role_returncode) which ensures generation of standardized, structured results from execution of Ansible Playbooks (Custom stats). This result contains status information about success of execution even on detail of particular actions (if needed) with information what is the reason for potential unsuccessfull execution. This result from execution is then processed and visualised by DX Dashboard (or potentially another tool) for next investigations.

Variables
--------------

A description of the settable variables should go here, including any variables that are in defaults/main.yml, vars/main.yml, and any variables that can/should be set via parameters to the role. Any variables that are read from other roles and/or the global scope (ie. hostvars, group vars, etc.) should be mentioned here as well.

Dependencies
------------
This playbook use CredSSP authentication (inventory) or kerberos (inventory1), CredSSP is a newer authentication protocol that allows credential delegation. This is achieved by encrypting the username and password after authentication has succeeded and sending that to the server using the CredSSP protocol. Because the username and password are sent to the server to be used for double hop authentication, ensure that the hosts that the Windows host communicates with are not compromised and are trusted. CredSSP can be used for both local and domain accounts and supports message encryption over HTTP.
1. On Windows servers follow one of steps below:
 * ```powershell.exe -File ConfigureRemotingForAnsible.ps1 -Verbose -EnableCredSSP```
    - __Note:__ ConfigureRemotingForAnsible.ps1 script is available on [GitHub](https://github.com/ansible/ansible/blob/devel/examples/scripts/ConfigureRemotingForAnsible.ps1)

or 
  - Enable and configure PowerShell remoting using CredSSP
```Enable-WSManCredSSP -Role Server -Force```
2. On Ansible control server install modules for Windows
 * ```ansible-galaxy collection install community.windows```
 * ```ansible-galaxy collection install ansible.windows```
 - Documentation:
   - https://galaxy.ansible.com/community/windows
   - https://docs.ansible.com/ansible/2.9/modules/list_of_windows_modules.html 
   - https://docs.ansible.com/ansible/latest/collections/community/windows/index.html 
3. Update ```inventory``` file with list of servers and administrator credentials.
  - __Note:__ It's best to save credentials in ansible vault.
4. For Json parsing you need jmespath library

Instructions
------------ 
1. On Ansible controller server execute ```ansible-playbook -i inventory[1] main.yml```
2. Review the [servername].wineventpolicy.json log file for each server.

License
-------
By default all the assets created are considered for internal IBM/Kyndryl use.
All license information should be put into [License file](LICENSE.md)

It is an responsibility of the asset owner to ensure that [License file](LICENSE.md) is having proper information.

Support
-------
Asset Creators are responsible for supporting (replying to the issues, fixing bugs etc.) the asset during its lifecycle.

If you are creating this asset and have no plans to provide any type of support put: "No support available for this asset. Bugs/enhancements reported will not be monitored"

If you are part of a development team responsible for this asset: please put your process description or link in this section

For more information on howto report issues please follow our [Reporting Issues or Bugs](https://github.ibm.com/Continuous-Engineering/Community-guidelines/blob/master/CONTRIBUTING.md#reporting-issues-or-bugs) section in CONTRIBUTING.md

Author Information
------------------

Author1: Gica Livada<br/>
Role: Technical Specialist<br/>
Department: ISAT EMEA<br/>
Email Contact: gica.livada@kyndryl.com<br/>

Author2: Mircea Gaitan<br/>
Role: Technical Specialist<br/>
Department: ISAT EMEA<br/>
Email Contact: mircea.gaitan@kyndryl.com<br/>
