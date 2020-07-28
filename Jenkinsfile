node {
    stage ('检出最新代码'){
        checkout([$class: 'GitSCM', branches: [[name: '*/master']], doGenerateSubmoduleConfigurations: false, extensions: [], submoduleCfg: [], userRemoteConfigs: [[credentialsId: '2d0caac0-eaa8-4b43-93bb-7792ffa1d9bb', url: 'https://gitee.com/qiuapeng921/autoDeployment.git']]])
        dingTalk accessToken: 'd52e800dad9397bf51b6691463c0d5c5f8252d4af32bd7a06859fd1ad37a5370', imageUrl: '', jenkinsUrl: 'http://jenkins.phpswoole.cn/', message: '检出最新代码成功', notifyPeople: ''
    }
    stage ('规范检测'){
        //sh 'sudo docker exec server vendor/bin/phpcs'
        dingTalk accessToken: 'd52e800dad9397bf51b6691463c0d5c5f8252d4af32bd7a06859fd1ad37a5370', imageUrl: '', jenkinsUrl: 'http://jenkins.phpswoole.cn/', message: '规范检测通过', notifyPeople: ''
    }
    stage ('复制黏贴检测'){
        //sh 'sudo docker exec server vendor/bin/phpcpd ./app'
        dingTalk accessToken: 'd52e800dad9397bf51b6691463c0d5c5f8252d4af32bd7a06859fd1ad37a5370', imageUrl: '', jenkinsUrl: 'http://jenkins.phpswoole.cn/', message: '复制黏贴检测通过', notifyPeople: ''
    }
    stage ('打包发布镜像'){
        sh 'sudo docker login --username=duoqing525@163.com --password=only521++ registry.cn-hangzhou.aliyuncs.com'
        //sh 'sudo composer install --ignore-platform-reqs -vvv'
        //sh 'sudo cp .env.example .env'
        sh 'sudo docker build -t qiuapeng921/golang:$(cat ./VERSION) ./'
        sh 'sudo docker tag qiuapeng921/golang:$(cat ./VERSION) registry.cn-hangzhou.aliyuncs.com/qiuapeng/golang:$(cat ./VERSION)'
        dingTalk accessToken: 'd52e800dad9397bf51b6691463c0d5c5f8252d4af32bd7a06859fd1ad37a5370', imageUrl: '', jenkinsUrl: 'http://jenkins.phpswoole.cn/', message: '打包镜像成功', notifyPeople: ''
    }
    stage ('发布候选版本'){
        sh 'sudo docker push registry.cn-hangzhou.aliyuncs.com/qiuapeng/swoft:$(cat ./VERSION)'
        dingTalk accessToken: 'd52e800dad9397bf51b6691463c0d5c5f8252d4af32bd7a06859fd1ad37a5370', imageUrl: '', jenkinsUrl: 'http://jenkins.phpswoole.cn/', message: '发布镜像成功', notifyPeople: ''
    }
    stage ('清理构建镜像'){
    	sh 'sudo docker rmi -f qiuapeng921/golang:$(cat ./VERSION)'
    	dingTalk accessToken: 'd52e800dad9397bf51b6691463c0d5c5f8252d4af32bd7a06859fd1ad37a5370', imageUrl: '', jenkinsUrl: 'http://jenkins.phpswoole.cn/', message: '清理构建镜像成功', notifyPeople: ''
    }
    stage ('启动最新镜像'){
        sh 'sed -i "s/VERSION/$(cat VERSION)/g" deployment/docker-compose.yml'
        sh 'sudo docker-compose stop'
        sh 'cp deployment/docker-compose.yml ./'
    	sh 'sudo docker-compose up -d'
        echo 'release sandbox success'
        dingTalk accessToken: 'd52e800dad9397bf51b6691463c0d5c5f8252d4af32bd7a06859fd1ad37a5370', imageUrl: '', jenkinsUrl: 'http://jenkins.phpswoole.cn/', message: '启动最新镜像成功', notifyPeople: ''
        emailext body: '$DEFAULT_CONTENT', recipientProviders: [developers()], subject: '$DEFAULT_SUBJECT', to: '1047871481@qq.com'
    }
}