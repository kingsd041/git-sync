# Git Sync

A GitHub Action for syncing between two independent repositories using **force push**. 


## Features
 * Sync branches between two GitHub repositories
 * Sync branches to/from a remote repository
 * GitHub action can be triggered on a timer or on push
 * To sync with current repository, please checkout [Github Repo Sync](https://github.com/marketplace/actions/github-repo-sync)


## Usage

### GitHub Actions
```
# File: .github/workflows/repo-sync.yml

on: push
jobs:
  repo-sync:
    runs-on: ubuntu-latest
    steps:
    - name: repo-sync
      uses: wei/git-sync@v1
      env:
        SOURCE_REPO: ""
        DESTINATION_REPO: ""
        BRANCH_NAME: ""
        SSH_PRIVATE_KEY: ${{ secrets.SSH_PRIVATE_KEY }}
      with:
        args: $SOURCE_REPO $DESTINATION_REPO $BRANCH_NAME
```
`SSH_PRIVATE_KEY` can be omitted if using authenticated HTTPS repo clone urls like `https://username:access_token@github.com/username/repository.git`.

#### Advanced: Sync all branches

To sync multiple branches from source to destination, you can set multiple repo in `BRANCH_NAME`, separated by spaces.
By default, all tags are synchronized

### Docker
```
docker run --rm -e "SSH_PRIVATE_KEY=$(cat ~/.ssh/id_rsa)" $(docker build -q .) \
  $SOURCE_REPO $DESTINATION_REPO $BRANCH_NAME
```

## Author
[Wei He](https://github.com/wei) _github@weispot.com_


## License
[MIT](https://wei.mit-license.org)
