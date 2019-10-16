FROM python:3.7-alpine

RUN pip install pyyaml
COPY ./gen.py /usr/local/bin/
ENTRYPOINT ["gen.py"]