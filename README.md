<div align="center">

# asdf-opa ![Build](https://github.com/tochukwuvictor/asdf-opa/workflows/Build/badge.svg) ![Lint](https://github.com/tochukwuvictor/asdf-opa/workflows/Lint/badge.svg)

[opa](https://github.com/tochukwuvictor/asdf-opa) plugin for the [asdf version manager](https://asdf-vm.com).

</div>

# Contents

- [Dependencies](#dependencies)
- [Install](#install)
- [Why?](#why)
- [Contributing](#contributing)
- [License](#license)

# Dependencies

- `bash`, `curl`, `tar`: generic POSIX utilities.
- `SOME_ENV_VAR`: set this environment variable in your shell config to load the correct version of tool x.

# Install

Plugin:

```shell
asdf plugin add opa
# or
asdf plugin add https://github.com/tochukwuvictor/asdf-opa.git
```

opa:

```shell
# Show all installable versions
asdf list-all opa

# Install specific version
asdf install opa latest

# Set a version globally (on your ~/.tool-versions file)
asdf global opa latest

# Now opa commands are available
opa --help
```

Check [asdf](https://github.com/asdf-vm/asdf) readme for more instructions on how to
install & manage versions.

# Contributing

Contributions of any kind welcome! See the [contributing guide](contributing.md).

[Thanks goes to these contributors](https://github.com/tochukwuvictor/asdf-opa/graphs/contributors)!

# License

See [LICENSE](LICENSE) © [Tochukwu Victor](https://github.com/tochukwuvictor/)
