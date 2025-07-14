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


source .env && release-please github-release \
    --token=$RELEASE_PLEASE_GITHUB_TOKEN \
    --repo-url=nilsgstrabo/learnrelease


[Making authenticated API requests with a GitHub App in a GitHub Actions workflow](https://docs.github.com/en/apps/creating-github-apps/authenticating-with-a-github-app/making-authenticated-api-requests-with-a-github-app-in-a-github-actions-workflow)