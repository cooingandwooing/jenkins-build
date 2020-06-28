
# 安装
## 账号密码

http://gitlab.example.com:99/

gxf gxf_1234

hgot123 



gitbot  机器人使用的git账号 gitbot_123

hgot  组织

root qy123456

外部LB地址192.168.66.6

https://hub.poetry.com/harbor/users   用户名jx  zhanzhanlusi377@163.com  全名jenkins-x  密码Jx_123456

----



Jenkins X Admin Username admin

Jenkins X Admin Password [? for help]   123456

Pipeline bot Git username gitbot
Pipeline bot Git email address [? for help] zhanzhanlusi377@163.com

? Pipeline bot Git token [? for help]  EhCshoz7Rb1NEXQX4kz7
Generated token a7db9ddfe4264b2d22b2f1dabeafd12941b7ba06d, to use it press enter.
This is the only time you will be shown it so remember to save it
? HMAC token, used to validate incoming webhooks. Press enter to use the generated token [? for help] 
? Do you want to configure non default Docker Registry? Yes
? Docker Registry Url https://hub.poetry.com/
? Docker Registry username jx
? Docker Registry password [? for help]   Jx_123456
? Docker Registry email zhanzhanlusi377@163.com
WARNING: Unexpected registry auth URL https://hub.poetry.com/ - using it as registry push URL



--------

## 前置条件

- 保证 git 能联通 http://gitlab.example.com:99/

- GH_USER环境变量不能被占用哦

  #GH_USER_gitlab 代表Using organisation
  GH_USER_gitlab=hgot

## 观察

http://192.168.66.10:32567/dashboard

## 命名空间

velero

jx

cert-manager

##  说明与解释

```
# jx-requirements.yml 中
environmentGitOwner: hgot
```

 代表Using organisation

## 验证

```
[root@jenkins-1 environment-kube-10-dev]# jx step verify env
Storing the requirements in team settings in the dev environment
Validating git repository for dev environment at URL http://gitlab.example.com:99/hgot/environment-kube-10-dev.git
Validating git repository for production environment at URL http://gitlab.example.com:99/hgot/environment-kube-10-production.git
Using Git provider gitlab at http://gitlab.example.com:99
? Using Git user name: gitbot
? Using organisation: hgot
Creating repository hgot/environment-kube-10-production
Git repository hgot/environment-kube-10-production already exists
Pushed Git repository to http://gitlab.example.com:99/hgot/environment-kube-10-production

Validating git repository for staging environment at URL http://gitlab.example.com:99/hgot/environment-kube-10-staging.git
Using Git provider gitlab at http://gitlab.example.com:99
? Using Git user name: gitbot
? Using organisation: hgot
Creating repository hgot/environment-kube-10-staging
Git repository hgot/environment-kube-10-staging already exists
Pushed Git repository to http://gitlab.example.com:99/hgot/environment-kube-10-staging

Environment git repositories look good

```



----


## issue

failed to add Helm repository 'https://charts.bitnami.com/bitnami

failed to add Helm repository 'http://chartmuseum.jenkins-x.io': 

```
~/.jx/bin/helm repo add charts.bitnami.com https://charts.bitnami.com/bitnami
~/.jx/bin/helm repo add chartmuseum.jenkins-x.io http://chartmuseum.jenkins-x.io
```

  Error from server (Invalid): error when creating "/tmp/helm-template-workdir-711327184/jenkins-x/output/namespaces/jx/env/charts/jxboot-resources/templates/part0-dev-repo.yaml": SourceRepository.jenkins.io "hgot_123-environment-kube-10-dev" is invalid: metadata.name: Invalid value: "hgot_123-environment-kube-10-dev": a DNS-1123 subdomain must consist of lower case alphanumeric characters, '-' or '.', and must start and end with an alphanumeric character (e.g. 'example.com', regex used for validation is '[a-z0-9]([-a-z0-9]*[a-z0-9])?(\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*')

```
# 不能是 hgot_123
GH_USER=hgot123  

------------
environmentGitOwner: hgot123

```

