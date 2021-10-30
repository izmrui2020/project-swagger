FROM node:13.7.0-alpine3.10

ENV APP_HOME /usr/src/app
RUN mkdir -p $APP_HOME
WORKDIR $APP_HOME

# スタブ用ソースをコンテナにコピー
COPY swagger/stub/ $APP_HOME

EXPOSE 8000
RUN npm install

ENTRYPOINT ["npm", "start"]