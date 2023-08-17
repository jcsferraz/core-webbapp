# _core-webbapp

## Structure

This is how we are implementing IaC at _core-webbapp.

* **One of our premises is that we want the same code as the production environment in our staging/development environment.**

### Below we have a example of how we organize the folder structure of each account


```sh
.
├── README.md
├── sre-gitops
│   ├── infra
│   │   ├── compute --> Contains all resources that are owned by an application
│   │   │   ├── ec2
│   │   │       └── env
│   │   ├── data-store --> Contains all resources that are owned by an application
│   │   │   ├── dynamodb
│   │   │       └── env
│   │   ├── network --> Contains data stores resources that are shared or not by applications
│   │   │   ├── vpc
│   │   │       └── env
│   │   └── services --> Contains resources that are shared across applications
│   │       ├── ec2s
│   │       └── eks
....
└── terragrunt.hcl
```

