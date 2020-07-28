node {
    stage ('打包构建镜像'){
        sh 'sudo docker login --username=qiuapeng921@163.com --password=only521++ registry.cn-hangzhou.aliyuncs.com'
        sh 'sudo docker build -t qiuapeng921/golang ./'
        sh 'sudo docker tag qiuapeng921/golang registry.cn-hangzhou.aliyuncs.com/qiuapeng/golang:$(cat ./VERSION)'
    }
    stage ('阿里镜像仓库'){
        sh 'sudo docker push registry.cn-hangzhou.aliyuncs.com/qiuapeng/golang:$(cat ./VERSION)'
    }
    stage ('清理构建镜像'){
        sh 'sudo docker rmi -f qiuapeng921/golang'
    }
    stage ('启动最新镜像'){
        sh 'sed -i "s/VERSION/$(cat VERSION)/g" deployment/docker-compose.yml'
        sh 'sudo docker-compose down'
        sh 'cp deployment/docker-compose.yml ./'
    	sh 'sudo docker-compose up -d'
        echo 'release sandbox success'
    }
}