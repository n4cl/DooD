FROM docker:20

RUN apk update && apk add --no-cache python3 python3-dev py3-pip gcc musl-dev libffi-dev make curl gnupg
RUN pip3 install --upgrade pip && pip3 install awscli

COPY app /usr/local/app
RUN chmod +x /usr/local/app/push.sh
WORKDIR /usr/local/app
