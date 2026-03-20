# Lab Environment Documentation

## Azure

| Field          | Value             |
|----------------|-------------------|
| Resource group | rg-lab-ad         |
| Region         | Switzerland North |
| VM size        | Standard_B2als_v2 |
| Auto-shutdown  | 17:00 UTC+1       |

## Domain Controller

| Field          | Value               |
|----------------|---------------------|
| VM name / Hostname | rg-lab-ad       |
| Private IP     | 10.0.0.4            |
| OS             | Windows Server 2025 |
| Role           | Domain Controller (pending installation) |
| Domain         | becode.corp.lab     |
| NetBIOS name   | BECODE              |
| Forest level   | Windows Server 2025 |
| DNS zones      | becode.corp.lab, _msdcs.becode.corp.lab |
| SRV records    | Present             |
| DSRM password  | stored in password manager |

## Active Directory — Initial State

| Object                | Count / Detail |
|-----------------------|----------------|
| OUs (default)         |                |
| Containers (default)  |                |
| User accounts         |                |
| Security groups       |                |
| Domain Admins members |                |

## DNS Verification

| Check                             | Result     |
|-----------------------------------|------------|
| Forward zone `becode.corp.lab`    | Present    |
| `_msdcs.becode.corp.lab` zone     | Present    |
| Reverse lookup zone               | No         |
| SRV records (`_ldap`, etc.)       | OK         |
| `nslookup becode.corp.lab`        | OK         |
| `nslookup dc01.becode.corp.lab`   | OK         |

## Kerberos

| Field              | Value |
|--------------------|-------|
| TGT issuer         |       |
| TGT expiry time    |       |
| Default TGT lifetime |     |

## Event Log Check

| Log              | Errors found | Notes |
|------------------|--------------|-------|
| Directory Service |            |       |

## BeCode Corp. — Active Directory Structure

### Departments and OUs
| Department | OU Path |
|---|---|
| Management | OU=Management,OU=Corp,DC=becode,DC=corp,DC=lab|
| Study | OU=Study,OU=Corp,DC=becode,DC=corp,DC=lab |
| Production | OU=Production,OU=Corp,DC=becode,DC=corp,DC=lab |
| Support-A | OU=Support-A,OU=Support,OU=Corp,DC=becode,DC=corp,DC=lab |
| Support-B | OU=Support-B,OU=Support,OU=Corp,DC=becode,DC=corp,DC=lab |
| IT | OU=IT,OU=Corp,DC=becode,DC=corp,DC=lab |
| Service Accounts | OU=ServiceAccounts,OU=Corp,DC=becode,DC=corp,DC=lab |

### Users
| Username | Department | Role | Admin account |
|---|---|---|---|
| claire.dupont | Management | General Manager | claire.admin |
| marc.leroy | Management | Secretary | — |
| thomas.renard | Study | Lead Analyst | — |
| sophie.lambert | Study | Researcher | — |
| julie.martin | Production | Production Supervisor | — |
| kevin.bernard | Production | Operator | — |
| leo.simon | Support-A | Support Agent | — |
| maya.cohen | Support-B | Support Agent | — |
| alice.sysadmin | IT | System Administrator | — |
| svc_backup | ServiceAccounts | Backup service | — |
| svc_ftp | ServiceAccounts | FTP server | — |
| svc_monitor | ServiceAccounts | Monitoring | — |

### Security Groups
| Group | Members |
|---|---|
| Domain Admins | Administrator, claire.admin, alice.sysadmin |
| GRP-IT-Admins | alice.sysadmin |
| GRP-Corp-All | GRP-Management, GRP-Study, GRP-Production, GRP-Support |
| GRP-Helpdesk | alice.sysadmin, leo.simon |

## Security Baseline — BeCode Corp.

### Password Policy (Default Domain Policy)
| Setting                          | Configured value |
|----------------------------------|------------------|
| Minimum password length          |                  |
| Complexity required              |                  |
| Maximum password age             |                  |
| Minimum password age             |                  |
| Password history                 |                  |

### Account Lockout Policy
| Setting                          | Configured value |
|----------------------------------|------------------|
| Lockout threshold                |                  |
| Lockout duration                 |                  |
| Reset counter after              |                  |

### Monitoring (GPO: Security-Monitoring)
| Setting                          | Status |
|----------------------------------|--------|
| PowerShell ScriptBlock Logging   |        |
| PowerShell Module Logging        |        |
| Process Creation Auditing (4688) | Not yet configured — Day 3 |
| Sysmon                           | Not yet installed — Day 3 |

## Known and Accepted Risks

| Risk | Who it affects | Severity | Notes |
|---|---|---|---|
| claire.admin in Domain Admins | Entire domain | High | General Manager holds Domain Admin rights. Compromise = full domain takeover. |
| svc_backup — PasswordNeverExpires | Backup data | Medium | Password does not rotate automatically. Credential theft gives persistent backup access. |
| svc_ftp — PasswordNeverExpires | FTP storage | Medium | Same as above. Especially relevant since FTP was publicly accessible in the network project. |
| svc_monitor — PasswordNeverExpires | Monitoring logs | Low | Read-only monitoring account. Lower impact but still a credential that never expires. |
| (add anything else you noticed) | | | |

## DHCP

| Field               | Value |
|---------------------|-------|
| DHCP Server         | dc01.becode.corp.lab |
| Scope name          | BeCode-Corp-Lab |
| IP range            |       |
| Subnet mask         |       |
| Default gateway     |       |
| DNS server          | (DC private IP) |
| DNS domain          | becode.corp.lab |
| Dynamic DNS updates | Enabled |

## Note — multi-scope production deployment
In a real BeCode Corp. deployment, one scope per department VLAN would be needed.
See network project documentation for VLAN and subnet definitions.

