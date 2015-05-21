# serverkit-rbenv
[Serverkit](https://github.com/serverkit/serverkit) plug-in for [rbenv](https://github.com/sstephenson/rbenv).

- [Install](#install)
- [Resource](#resource)
  - [rbenv_ruby](#rbenv_ruby)
    - [Attributes](#attributes)
    - [Example](#example)

## Install
```rb
gem "serverkit-rbenv"
```

## Resource
### rbenv_ruby
Make sure the specified version of Ruby is installed with rbenv.

#### Attributes
- version - Installed Ruby version (required) (e.g. `"2.2.0"`)
- global - Pass true to make it global (default: `false`)
- rbenv_executable_path - Path to rbenv executable (default: $HOME/.rbenv/bin/rbenv or rbenv)
- user - user name (required if dependencies is true)
- dependencies - Pass true to install rbenv, ruby-build, their dependencies, profile script
- profile_path - Where to append init script for rbenv (required if dependencies is true)

#### Example
```yml
resources:
  - type: rbenv_ruby
    version: 2.2.0
    global: true
    rbenv_executable_path: /home/foo/.rbenv/bin/rbenv
    user: foo
    dependencies: true
    profile_path: /home/foo/.bash_profile
```

### rbenv_dependent_packages
Install denpendent packages to install rbenv.

#### Example
```yml
resources:
  - type: rbenv_dependent_packages
```

### rbenv_profile
Append rbenv init lines into profile file.

#### Attributes
- profile_path - path to profile file (default: .bash_profile path if user specified)
- user - user name (required)

#### Example
```yml
resources:
  - type: rbenv_profile
    user: foo
```

### rbenv_rbenv
Install rbenv into home directory.

#### Attributes
- user - user name (required)

#### Example
```yml
resources:
  - type: rbenv_rbenv
    user: foo
```

### rbenv_ruby_build
Install ruby-build into home directory.

#### Attributes
- user - user name (required)

#### Example
```yml
resources:
  - type: rbenv_ruby_build
    user: foo
```
