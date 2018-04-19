#
# Dockerfile to build an image for Amazon SageMaker
#
# docker build -t sagemaker-sklearn-example .
#
# docker run -v $(pwd)/test_dir:/opt/ml --rm sagemaker-sklearn-example train
#
FROM python:3.6-jessie
MAINTAINER Takashi Someda <someda@isenshi.com>

ENV WORK_DIR /opt/local/work
RUN mkdir -p ${WORK_DIR}
ENV PATH="${WORK_DIR}:${PATH}"
WORKDIR ${WORK_DIR}

COPY requirements.lock .
RUN pip install -r requirements.lock

# For training
COPY train .
# For inference

