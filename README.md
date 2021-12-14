# My dotfiles

powered by [chezmoi](https://www.chezmoi.io)

## Getting started

```sh
sh -c "$(curl -fsLS git.io/chezmoi)" -- init --apply palindrom615
```

or

```powershell
(iwr -UseBasicParsing https://git.io/chezmoi.ps1).Content | powershell -c -
cd bin
chezmoi init --apply palindrom615
```