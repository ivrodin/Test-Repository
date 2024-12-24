import pytest
from selenium import webdriver
from selenium.webdriver.common.by import By
from DQE_Task_13.Pages.incomeStatementsReportPage import IncomeStatementsReportPage
from DQE_Task_13.conftest import SELENIUM_PARAMETERS_DATA


@pytest.fixture()
def get_page():
    selenium_report_uri = SELENIUM_PARAMETERS_DATA['global']['report_uri']
    selenium_delay = SELENIUM_PARAMETERS_DATA['global']['delay']
    driver = webdriver.Chrome()
    driver.get(selenium_report_uri)
    return IncomeStatementsReportPage(driver, selenium_delay)


def test_report_title(get_page):
    title = get_page.get_title()
    assert title.text == 'Earnings Release FY23 Q3'


def test_link(get_page):
    get_page.verify_income_statements_link_is_clickable()
