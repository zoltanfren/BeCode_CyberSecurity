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
