# Hannari Python #5 Demonstration

This project includes demonstration code for the presentation at [Hannari Python #5](https://hannari-python.connpass.com/event/82672/) at Apr 20th 2018.

This demonstration includes sample code to bring your own algorithm to [Amazon SageMaker](https://aws.amazon.com/sagemaker/). The implemented algorithm here is completely same to the one provided by [awslabs](https://github.com/awslabs/amazon-sagemaker-examples/tree/master/advanced_functionality/scikit_bring_your_own) but whole scripts have been simplified so that you can just focus on three scripts below.

* Dockerfile
* train
* serve

## Prerequisites

* Docker

## How to run in local

You need to build docker image at first.

    docker build -t sagemaker-sklearn-example .

Then, create directories required to run `train` and `serve` scripts like this

    mkdir -p test_dir/{model,output}

Thereafter, you can run `train` as follows

    docker run -v $(pwd)/test_dir:/opt/ml --rm sagemaker-sklearn-example train

This will generate model under `test_dir/model` and `serve` will use it by

    docker run -v $(pwd)/test_dir:/opt/ml --rm -p 8080:8080 sagemaker-sklearn-example serve

You can try to call API with 10 randomly selected samples from training data like this

    awk '{print substr($1, 1+index($1, ","))}' test_dir/input/data/train/iris.csv | sort -R | head -10 | curl --data-binary @-  -H "Content-Type: text/csv" -v http://localhost:8080/invocations

## Bring this to Amazon SageMaker

You can refer to [my presentation slides](https://speakerdeck.com/hacarus/amazon-sagemaker-de-scikit-learn-moderuwodong-kasu). The required steps are same to the ones mentioned in [this blog](https://aws.amazon.com/jp/blogs/machine-learning/train-and-host-scikit-learn-models-in-amazon-sagemaker-by-building-a-scikit-docker-container/).

# References

* [Train and host Scikit-Learn models in Amazon SageMaker by building a Scikit Docker container](https://aws.amazon.com/jp/blogs/machine-learning/train-and-host-scikit-learn-models-in-amazon-sagemaker-by-building-a-scikit-docker-container/)
* [Amazon SageMaker Examples](https://github.com/awslabs/amazon-sagemaker-examples)
