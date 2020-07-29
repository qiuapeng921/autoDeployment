node {
    stage('拉取最新代码'){
        git credentialsId: '120c0c39-5daf-49bd-8c0f-a718892510e0', url: 'https://github.com/qiuapeng921/autoDeployment'
    }
    stage ('打包构建镜像'){
        docker_registry = 'registry.cn-hangzhou.aliyuncs.com'
        username = 'qiuapeng921@163.com'
        password = 'only521++'
        image_name = 'qiuapeng921/golang'
        sh 'sudo docker login --username=${username} --password=${password} ${docker_registry}'
        sh 'sudo docker build -t ${image_name} ./'
        sh 'sudo docker tag ${image_name} ${docker_registry}/${image_name}:$(cat ./VERSION)'
    }
    stage ('阿里镜像仓库'){
        sh 'sudo docker push ${docker_registry}/${image_name}:$(cat ./VERSION)'
    }
    stage ('清理构建镜像'){
        sh 'sudo docker rmi -f ${image_name}'
    }
    stage ('替换关闭服务'){
        sh 'sed -i "s/VERSION/$(cat VERSION)/g" deployment/docker-compose.yml'
        sh 'sudo docker-compose down'
        sh 'cp deployment/docker-compose.yml ./'
    }
    stage ('启动最新镜像'){
    	sh 'sudo docker-compose up -d'
        echo 'release sandbox success'
    }
}