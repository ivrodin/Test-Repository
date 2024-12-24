from selenium.webdriver.support.ui import WebDriverWait as WDW
from selenium.webdriver.support import expected_conditions as EC
from selenium.webdriver.common.by import *


class IncomeStatementsReportPage:
    def __init__(self, driver, delay):
        self.driver = driver
        self.delay = delay

        self.power_bi_button = "//a[@role='tab' and text()='Power BI']"
        self.revenue_report_header = "//div[contains(@title, 'REVENUE')][1]"

    def open_power_bi_report(self):
        power_bi_report_button = WDW(self.driver, self.delay).until(EC.element_to_be_clickable((By.XPATH,
                                                                    self.power_bi_button)))
        power_bi_report_button.click()

    def switch_to_report_frame(self):
        iframe = self.driver.find_element(By.ID, "mschart")
        self.driver.switch_to.frame(iframe)

    def get_title(self):
        return self.driver.find_element(By.CSS_SELECTOR,
                                                 '[data-automation-test-id="RichTextV1Div-richtext-uidf814"]')

    def verify_income_statements_link_is_clickable(self):
        WDW(self.driver, self.delay).until(
            EC.element_to_be_clickable((By.CSS_SELECTOR, '[data-automation-test-id="LinkListItemCTA0-link-list-uid63da"]')))

    def get_revenue_report_title(self):
        report_header = WDW(self.driver, self.delay).until(EC.element_to_be_clickable((By.XPATH,
                                                           self.revenue_report_header)))
        return report_header.get_attribute("title")
