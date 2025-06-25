# learnrelease
Trying out release-please

Init:
```
source .env && release-please bootstrap \
    --token=$RELEASE_PLEASE_GITHUB_TOKEN \
    --repo-url=nilsgstrabo/learnrelease \
    --release-type=go

```

source .env && release-please release-pr \
    --token=$RELEASE_PLEASE_GITHUB_TOKEN \
    --repo-url=nilsgstrabo/learnrelease