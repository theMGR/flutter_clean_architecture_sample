FROM dart:3.3.0 AS build

WORKDIR /app
COPY . .

RUN dart pub get
RUN dart compile exe bin/main.dart -o bin/server

FROM alpine:latest

ENV runmode=production
ENV serverid=default
ENV logging=normal
ENV role=monolith

COPY --from=build /runtime/ /
COPY --from=build /app/bin/server server
COPY --from=build /app/confi[g]/ config/
COPY --from=build /app/we[b]/ web/
COPY --from=build /app/migration[s]/ migrations/


EXPOSE 7070
EXPOSE 7071
EXPOSE 7071

ENTRYPOINT ./server --mode=$runmode --server-id=$serverid --logging=$logging --role=$role
