#!/bin/ash

login() {
    echo "Logging in to ECR..."
    aws ecr get-login-password --region ${AWS_CLI_REGION} \
    | docker login --username AWS --password-stdin ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_CLI_REGION}.amazonaws.com
}

push_ecr() {
    TIME_STAMP=`date '+%Y%m%d-%H%M'`
    docker tag $1:latest ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_CLI_REGION}.amazonaws.com/$2:${TIME_STAMP}
    docker push ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_CLI_REGION}.amazonaws.com/$2:${TIME_STAMP}
}

if [ -z "$1" ]; then
    echo "第1引数がありません"
    exit 1
fi
if [ -z "$2" ]; then
    echo "第2引数がありません"
    exit 1
fi

# 関数を呼び出す
login
push_ecr $1 $2
