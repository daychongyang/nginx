# sparse-checkout

- git init

- git remote add -f origin git@github.com:daysunx2/nginx-ge-profile.git

- git config core.sparsecheckout true

- echo "build" >> .git/info/sparse-checkout #设置需要 pull 的目录，\*表示所有，!表示匹配相反的

- less .git/info/sparse-checkout

- git pull origin master #拉取
