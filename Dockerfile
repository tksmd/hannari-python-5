#
# Dockerfile to build an image for Amazon SageMaker
#
# docker build -t sagemaker-sklearn-example .
#
# docker run -v $(pwd)/test_dir:/opt/ml --rm sagemaker-sklearn-example train
# docker run -v $(pwd)/test_dir:/opt/ml --rm -p 8080:8080 sagemaker-sklearn-example serve
#
FROM python:3.6-jessie
MAINTAINER Takashi Someda <someda@isenshi.com>

ENV WORK_DIR /opt/local/work
ENV PATH="${WORK_DIR}:${PATH}"
ENV PYTHONUNBUFFERED=TRUE
ENV PYTHONDONTWRITEBYTECODE=TRUE

RUN mkdir -p ${WORK_DIR}
WORKDIR ${WORK_DIR}
EXPOSE 8080

COPY requirements.lock .
RUN pip install -r requirements.lock

# For training
COPY train .
# For inference
COPY serve .

