#pgCheckInput

## Instal

```
# allow for older R-versions
if (getRversion() < "3.2"){ 
  devtools::install_bitbucket("pgcheckinput", username = "bnoperator")
} else {
  devtools::install_bitbucket("bnoperator/pgcheckinput")
}
```

# Publish a package on pamagene R repository

```
bntools::deployGitPackage('https://bitbucket.org/bnoperator/bn_shiny.git', '2.17')
```