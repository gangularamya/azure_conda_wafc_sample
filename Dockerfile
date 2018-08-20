FROM continuumio/miniconda3
ENTRYPOINT [ "/bin/bash", "-c" ]

EXPOSE 2222 3000

RUN apt-get update && apt-get install -y \
 libpq-dev \
 build-essential \
&& rm -rf /var/lib/apt/lists/*

# Use the environment.yml to create the conda environment.
ADD environment.yml /
WORKDIR /
RUN [ "conda", "env", "create" ]

ADD . /code

WORKDIR /code
RUN [ "/bin/bash", "-c", "source activate stats" ]
CMD [ "source activate stats && exec python app.py" ]