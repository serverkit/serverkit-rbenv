# serverkit-rbenv
[Serverkit](https://github.com/r7kamura/serverkit) plug-in for [rbenv](https://github.com/sstephenson/rbenv).

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
- rbenv_executable_path - Path to rbenv executable (default: `"rbenv"`)

#### Example
```yml
resources:
  - type: rbenv_ruby
    version: 2.2.0
    global: true
```
