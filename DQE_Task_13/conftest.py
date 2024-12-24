import pytest
import yaml
import psycopg2


PATH_TO_POSTGRES_CONFIG = r"C:\Users\ivanr\OneDrive\Рабочий стол\SW Courses\GitHub\Test-Repository\DQE_Task_13\Configs\postgres_config.yaml"
PATH_TO_SELENIUM_CONFIG = r"C:\Users\ivanr\OneDrive\Рабочий стол\SW Courses\GitHub\Test-Repository\DQE_Task_13\Configs\config_selenium.yaml"

def get_parameters_data(config_name):
    with open(config_name, 'r') as stream:
        config = yaml.safe_load(stream)
    return config


PARAMETERS_DATA = get_parameters_data(PATH_TO_POSTGRES_CONFIG)

SMOKE_TESTS_DATA_POSTGRES = PARAMETERS_DATA["smoke_tests"]
CRITICAL_TESTS_DATA_POSTGRES = PARAMETERS_DATA["critical_tests"]

SMOKE_TEST_PARAMETERS_POSTGRES = [(data["sql"], data["expected"]) for data in SMOKE_TESTS_DATA_POSTGRES]
CRITICAL_TEST_PARAMETERS_POSTGRES = [(data["sql"], data["expected"]) for data in CRITICAL_TESTS_DATA_POSTGRES]

SMOKE_TEST_NAMES_POSTGRES = [data["name"] for data in SMOKE_TESTS_DATA_POSTGRES]
CRITICAL_TEST_NAMES_POSTGRES = [data["name"] for data in CRITICAL_TESTS_DATA_POSTGRES]

SELENIUM_PARAMETERS_DATA = get_parameters_data(PATH_TO_SELENIUM_CONFIG)



@pytest.fixture()
def db_connection():
    db_con = psycopg2.connect(dbname='pizzaplaceDWH_test', user="postgres", password=1234, host="localhost", port=5432)
    cur = db_con.cursor()
    yield cur
    cur.close()
    db_con.close()

