# _core-webbapp

## Structure

This is how we are implementing IaC at _core-webbapp.

* **One of our premises is that we want the same code as the production environment in our staging/development environment.**

### Below we have a example of how we organize the folder structure of each account


```sh
.
├── README.md
├── accounts
├── sre-gitops
│   ├── infra
│   │   ├── applications --> Contains all resources that are owned by an application
│   │   │   ├── webb-app-api
│   │   │   └── webb-app-v2-api
│   │   ├── compute --> Contains all resources that are owned by an application
│   │   │   ├── ec2
│   │   │       └── env --> Contains environments for one or more accounts
│   │   ├── data-store --> Contains data stores resources that are shared or not by applications
│   │   │   ├── dynamodb
│   │   │       └── env --> Contains environments for one or more accounts
│   │   ├── network --> Contains data stores resources that are shared or not by applications
│   │   │   ├── vpc
│   │   │       └── env --> Contains environments for one or more accounts
│   │   └── services --> Contains resources that are shared across applications
│   │   │       └── eks --> 
....
└── terragrunt.hcl
```

