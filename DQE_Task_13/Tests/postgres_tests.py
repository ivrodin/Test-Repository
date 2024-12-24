import pytest
import allure
from DQE_Task_13.conftest import SMOKE_TEST_NAMES_POSTGRES, SMOKE_TEST_PARAMETERS_POSTGRES, CRITICAL_TEST_NAMES_POSTGRES, CRITICAL_TEST_PARAMETERS_POSTGRES

@pytest.mark.parametrize(
    "sql,expected",
    SMOKE_TEST_PARAMETERS_POSTGRES,
    ids=SMOKE_TEST_NAMES_POSTGRES
)
@pytest.mark.smoke
def test_smoke(db_connection, sql, expected):
    db_connection.execute(sql)
    with allure.step("Smoke Tests:"):
        # As soon as we have only one variable returning in smoke tests by query (count(*)), we select it (with [][])
        assert db_connection.fetchall()[0][0] == expected

@pytest.mark.parametrize(
    "sql,expected",
    CRITICAL_TEST_PARAMETERS_POSTGRES,
    ids=CRITICAL_TEST_NAMES_POSTGRES
)
@pytest.mark.critical
def test_critical(db_connection, sql, expected):
    db_connection.execute(sql)
    with allure.step("Critical Tests:"):
        assert str(db_connection.fetchall()) == expected
