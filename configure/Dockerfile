FROM python:3.7-alpine

RUN pip install pyyaml
COPY ./dump.py /usr/local/bin/
ENTRYPOINT ["dump.py"]