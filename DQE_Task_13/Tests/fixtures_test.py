import time
import pytest


# Fixture to track the total execution time of the test suite
@pytest.fixture(scope="session", autouse=True)
def track_suite_time():
    start_time = time.time()
    yield
    end_time = time.time()
    print(f"\nTotal suite execution time: {end_time - start_time:.2f} seconds")


# Fixture to track the time of individual test executions (except the last one)
@pytest.fixture()
def track_test_time(request):
    start_time = time.time()
    yield
    end_time = time.time()
    print(f"\n{request.node.name} executed in {end_time - start_time:.2f} seconds")



# Sample function to be tested
def add_numbers(a, b):
    return a + b


# Test cases
def test_add_two_positive_numbers(track_test_time):
    a, b = 3, 5
    result = add_numbers(a, b)
    time.sleep(2)
    assert result == 8


def test_add_two_negative_numbers(track_test_time):
    a, b = -3, -5
    result = add_numbers(a, b)
    time.sleep(3)
    assert result == -8


def test_add_negative_and_positive_numbers():
    a, b = -3, 5
    result = add_numbers(a, b)
    time.sleep(10)
    assert result == 2
