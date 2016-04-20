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