#!/bin/sh
BUILD_ID=dontKillMe
echo "build $1:$2"
version=v$2
if test  'master' != $1
then
  version="$1-v$2"
fi
echo $version

docker login --username=郝森伟 registry.cn-beijing.aliyuncs.com -p hao189108
docker build -t halo:${version} .
echo `docker images -a| grep halo | grep ${version} | awk '{print $3}' `
docker tag `docker images -a| grep halo | grep ${version} | awk '{print $3}' ` registry.cn-beijing.aliyuncs.com/haosenwei/halo:${version}
docker push registry.cn-beijing.aliyuncs.com/haosenwei/halo:${version}


docker stop `docker ps -a| grep halo | awk '{print $1}' `
docker rm   `docker ps -a| grep halo | awk '{print $1}' `

docker run -d --name halo\
              --network=kong-net  --restart=always \
              registry.cn-beijing.aliyuncs.com/haosenwei/halo:$version
