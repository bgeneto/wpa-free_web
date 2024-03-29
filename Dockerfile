FROM python:3.9-slim AS builder
COPY ./packages-base.txt /tmp/
COPY ./requirements.txt /tmp/
COPY ./free-server/REQUIREMENTS.txt /tmp/
RUN apt-get update && xargs apt-get install -y </tmp/packages-base.txt
RUN pip install --upgrade pip \
 && pip install --no-warn-script-location --no-cache-dir --user -r /tmp/requirements.txt \
 && pip install --no-warn-script-location --no-cache-dir --user -r /tmp/REQUIREMENTS.txt

FROM builder AS app 
ARG INSTDIR=/free-server
ENV PATH=/root/.local/bin:$PATH
COPY ./packages.txt /tmp/
RUN apt-get update && xargs apt-get install -y </tmp/packages.txt
COPY ./free-server/ $INSTDIR/
COPY ./config/.env $INSTDIR/freeweb/.env
COPY .env /tmp/.env
RUN echo "[client]\n$(cat /tmp/.env)" > $INSTDIR/my.cnf
RUN rm /tmp/.env
WORKDIR $INSTDIR
RUN python3 manage.py collectstatic --noinput
#RUN python3 manage.py makemigrations
#RUN python3 manage.py migrate
RUN python3 ./manage.py compilemessages
RUN python3 ./manage.py makemessages -d djangojs -a
RUN python3 ./manage.py makemessages -a
ENV TINI_VERSION v0.19.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /tini
RUN chmod +x /tini
ENTRYPOINT ["/tini", "--"]
CMD ["daphne", "-b", "0.0.0.0", "-p", "8000", "freeweb.asgi:application"]
# for debug only:
#ENTRYPOINT ["tail", "-f", "/dev/null"]
