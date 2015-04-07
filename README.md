# serverkit-rbenv
[Serverkit](https://github.com/r7kamura/serverkit) plug-in for [rbenv](https://github.com/sstephenson/rbenv).

## Resource
### rbenv_ruby
Install Ruby with rbenv.

#### Attributes
- version - installed Ruby version (required) (e.g. `"2.2.0"`)
- rbenv_executable_path - path to rbenv executable (e.g. `"/usr/local/bin/rbenv"`)

#### Example
```yml
- type: rbenv_ruby
  version: 2.2.0
```
