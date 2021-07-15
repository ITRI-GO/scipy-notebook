FROM jupyter/scipy-notebook
LABEL INSTANCE_TYPE="jupyter"

USER root

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && \
    apt-get install -y locales && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
    dpkg-reconfigure --frontend=noninteractive locales && \
    update-locale LANG=en_US.UTF-8

ENV LANG en_US.UTF-8 

RUN apt-get update \
    && apt-get install -y python3-pip python3-dev \
    && cd /usr/local/bin \
    && ln -s /usr/bin/python3 python \
    && pip3 install --upgrade pip \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

ENV PYTHONIOENCODING utf-8
ENV PYTHONUNBUFFERED=1

ENV TZ="Asia/Taipei"

RUN apt-get update && \
    apt-get -y install tzdata curl vim && \
    apt -y install postgresql-client postgresql-client-common libpq-dev && \
    apt-get -y install mosquitto-clients && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

## Change TimeZone
RUN cp /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN dpkg-reconfigure --frontend noninteractive tzdata

COPY requirements.txt ./
RUN pip install -r requirements.txt

USER ${NB_UID}

WORKDIR "${HOME}"