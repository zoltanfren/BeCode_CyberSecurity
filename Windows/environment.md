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
