# Contributing

To create a new template, clone this repository and run:

```shell
./new.sh TEMPLATE_NAME
```

This will create a new directory with a bare template example (provisions no infrastructure) and README.

Test a template by running an instance of Coder on your local machine:

```shell
coder server --in-memory
```

When ready, submit a PR to this repo to include it in the registry!