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

### Accepted risks
| Risk | Severity | Notes |
|---|---|---|
| claire.admin in Domain Admins | High | General Manager has domain admin rights. A targeted attack on her account = full domain compromise. Organizational decision. |
| svc_backup, svc_ftp, svc_monitor — PasswordNeverExpires | Medium | Service accounts. Password rotation requires coordination with application owners. |

