import pytest
import yaml


PATH_TO_CONFIG = r"C:\Users\ivanr\OneDrive\Рабочий стол\SW Courses\GitHub\Test-Repository\DQE_Task_13\Configs\config.yaml"


def get_numbers_data(config_name):
    with open(config_name, 'r') as stream:
        config = yaml.safe_load(stream)
    return config['cases']


NUMBERS_DATA = get_numbers_data(PATH_TO_CONFIG)

print(NUMBERS_DATA)
TEST_PARAMETERS = [(data["input"], data["expected"]) for data in NUMBERS_DATA]
print(TEST_PARAMETERS)
TEST_NAMES = [data["case_name"] for data in NUMBERS_DATA]
print(TEST_NAMES)


def add_numbers(a, b, c):
    try:
        return a + b + c
    except TypeError:
        raise 'Please check the parameters. All of them must be numeric'


@pytest.mark.parametrize(
    "test_input,expected",
    TEST_PARAMETERS,
    ids=TEST_NAMES
)
@pytest.mark.smoke
def test_add_numbers(test_input, expected):
    a, b, c = test_input
    assert add_numbers(a, b, c) == expected


@pytest.mark.critical
def test_add_invalid_types():
    a, b, c = 'a', 2, 1
    with pytest.raises(TypeError):
        add_numbers(a, b, c)
