# Source: https://gist.github.com/8af2cdfe9ffad2beac9c1e89cf863a46

# Links to gists for creating a Kubernetes cluster
# gke.sh: https://gist.github.com/1b7a1c833bae1d5da02f4fd7b3cd3c17
# eks.sh: https://gist.github.com/3eaa9b10cb59424fc0447a563112f32e

open "https://github.com/jenkins-x/jenkins-x-boot-config"

CLUSTER_NAME=kube-10 # e.g., jx-gke
#GH_USER_gitlab 代表Using organisation
GH_USER_gitlab=hgot
GIT_SERVER=http://gitlab.example.com:99

git clone \
    https://github.com/jenkins-x/jenkins-x-boot-config.git \
    environment-$CLUSTER_NAME-dev

cd environment-$CLUSTER_NAME-dev

cat jx-requirements.yml


# 非常奇怪 只有""之间的变量才识别    
cat jx-requirements.yml \
    | sed -e \
    's@gke@kubernetes@g' \
    | sed -e \
    "s@environmentGitOwner: \"\"@environmentGitOwner: \"$GH_USER_gitlab\"@g" \
    | sed -e \
    "/environmentGitPublic: false/a\  gitKind: gitlab\n  gitServer: $GIT_SERVER" \
    | tee jx-requirements.yml 

# 配置git 连接gitlab
ssh-keygen -t rsa -C "qingyejiazhu@163.com"
Generating public/private rsa key pair.
Enter file in which to save the key (/root/.ssh/id_rsa): /root/.ssh/gitlab_rsa
Enter passphrase (empty for no passphrase): 
Enter same passphrase again: 
Your identification has been saved in /root/.ssh/gitlab_rsa.
Your public key has been saved in /root/.ssh/gitlab_rsa.pub.
The key fingerprint is:
SHA256:UlLP/IYVhyJW1wX1VduTWYbbN8RVf0mfsuUuOJ9vWxo qingyejiazhu@163.com
The key's randomart image is:
+---[RSA 2048]----+
|        ... oo+*&|
|       .o+...o++&|
|      ....+....@*|
|       o   +  *.=|
|      . S . o. .o|
|       .   .. .  |
|           o .E..|
|            o o+.|
|             o+o.|
+----[SHA256]-----+

# '
如果有的话清除旧的公钥信息（比如以前在192.168.66.30，现在在192.168.66.50）
ssh-keygen -R 192.168.66.30
# known_hosts 不知道下面命令需要不，如果报错可以试一下
ssh-keyscan -t rsa github.com >> ~/.ssh/known_hosts

# 配置config，因为我们指定了/root/.ssh/gitlab_rsa，而没使用默认的id_rsa
echo "#default gitlab.example.com user(hs@xx.com)

Host gitlab.example.com
   HostName gitlab.example.com
   User qingyejiahzu@163.com
   port 22
   IdentityFile ~/.ssh/gitlab_rsa
" > /root/.ssh/config
#测试
ssh -T git@gitlab.example.com
Welcome to GitLab, @hgot123!


## 删除行
sed -i '/bootConfigURL/d' jx-requirements.yml 







echo "approvers:
- $GH_USER
- $GH_APPROVER
reviewers:
- $GH_USER
- $GH_APPROVER
" | tee OWNERS
# Open requirements.yaml in an editor

# Set `cluster.clusterName`
# Set `cluster.environmentGitOwner`
# Set `cluster.project` (if GKE)
# Set `cluster.provider
# Set `cluster.zone`
# Set `secretStorage` to `vault`
# Set `storage.logs.enabled` to `true`
# Set `storage.reports.enabled` to `true`
# Set `storage.repository.enabled` to `true`

# If EKS
export IAM_USER=[...] # e.g., jx-boot

# If EKS
echo "vault:
  aws:
    autoCreate: true
    iamUserName: \"$IAM_USER\"" \
    | tee -a jx-requirements.yml

# If EKS
cat jx-requirements.yml \
    | sed -e \
    's@zone@region@g' \
    | tee jx-requirements.yml

cat jx-requirements.yml

jx boot

git --no-pager diff origin/master..HEAD

cat env/parameters.yaml

cat jenkins-x.yml

cat jx-requirements.yml

jx get pipelines -o yaml

echo "A trivial change" \
    | tee -a README.md

git add .

git commit -m "A trivial change"

git push

jx get activities \
    --filter environment-$CLUSTER_NAME-dev \
    --watch

kubectl get namespaces

jx get env

cd ..

jx create quickstart \
    --filter golang-http

jx get activity \
    --filter jx-boot/master \
    --watch

jx get activity \
    --filter environment-$CLUSTER_NAME-staging/master \
    --watch

kubectl get namespaces

hub delete -y \
    $GH_USER/environment-$CLUSTER_NAME-staging

hub delete -y \
    $GH_USER/environment-$CLUSTER_NAME-production

hub delete -y \
    $GH_USER/jx-boot

rm -rf jx-boot
