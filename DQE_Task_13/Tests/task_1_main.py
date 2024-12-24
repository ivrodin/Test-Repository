import boto3
import pytest
import requests
import allure
from botocore import UNSIGNED
from botocore.config import Config
from google.cloud import storage


@pytest.fixture(scope='function')
def provide_config():
    config = {'prefix': '2024/01/01/KTLX/', 'gcp_bucket_name': "gcp-public-data-nexrad-l2",
              'aws_bucket_name': 'noaa-nexrad-level2',
              's3_anon_client': boto3.client('s3', config=Config(signature_version=UNSIGNED)),
              'gcp_storage_anon_client': storage.Client.create_anonymous_client()}
    return config


@pytest.fixture(scope='function')
def list_gcs_blobs(provide_config):
    config = provide_config
    blobs = config['gcp_storage_anon_client'].list_blobs(config['gcp_bucket_name'], prefix=config['prefix'])
    objects = [blob.name for blob in blobs]
    return objects


@pytest.fixture(scope='function')
def list_aws_blobs(provide_config):
    config = provide_config
    response = config['s3_anon_client'].list_objects(Bucket=config['aws_bucket_name'], Prefix=config['prefix'])
    objects = [content['Key'] for content in response['Contents']]
    return objects


@pytest.fixture(scope='function')
def provide_posts_data():
    response = requests.get("https://jsonplaceholder.typicode.com/posts")
    assert response.status_code == 200

    posts = response.json()
    user_posts = [post for post in posts if post['userId'] == 3]
    return user_posts


def test_user_with_posts(provide_posts_data):
    user_posts = provide_posts_data
    with allure.step("Test user 3 has 10 posts"):
        assert len(user_posts) == 10


def test_data_is_presented_between_staging_raw(list_gcs_blobs, list_aws_blobs):
    with allure.step("AWS and Google not empty"):
        assert len(list_aws_blobs) > 0
        assert len(list_gcs_blobs) > 0
