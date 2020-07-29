node {
    stage('拉取最新代码'){
        git credentialsId: '120c0c39-5daf-49bd-8c0f-a718892510e0', url: 'https://gitee.com/qiuapeng921/autoDeployment'
    }
    stage ('打包构建镜像'){

        sh 'sudo docker login --username=qiuapeng921@163.com --password=only521++ registry.cn-hangzhou.aliyuncs.com'
        sh 'sudo docker build -t qiuapeng921/golang ./'
        sh 'sudo docker tag qiuapeng921/golang registry.cn-hangzhou.aliyuncs.com/qiuapeng921/golang:$(cat ./VERSION)'
    }
    stage ('阿里镜像仓库'){
        sh 'sudo docker push registry.cn-hangzhou.aliyuncs.com/qiuapeng921/golang:$(cat ./VERSION)'
    }
    stage ('清理构建镜像'){
        sh 'sudo docker rmi -f qiuapeng921/golang'
    }
    stage ('替换关闭服务'){
        sh 'sed -i s/VERSION/$(cat VERSION)/g deployment/docker-compose.yml'
        sh 'sudo docker-compose stop'
        sh 'cp deployment/docker-compose.yml ./'
    }
    stage ('启动最新镜像'){
    	sh 'sudo docker-compose up -d'
        echo 'release sandbox success'
    }
}