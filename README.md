# dotfiles
My dotfiles for work and personal use. Powered by [punktf](https://github.com/Shemnei/punktf)

## Installation
### Linux
```
cargo install punktf
```
### Windows
```
scoop bucket add shemnei https://github.com/Shemnei/scoop-bucket
scoop install punktf
```
### Mac
```
brew install michidk/tools/punktf
```

## Management
### Windows
```
punktf --verbose deploy --source . --profile windows
```
### Linux/Mac
```
punktf --verbose deploy --source . --profile linux
```