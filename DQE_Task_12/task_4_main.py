from selenium import webdriver
from selenium.webdriver.common.by import By

driver = webdriver.Chrome()

# wait up to 10 seconds for elements to be found
driver.implicitly_wait(10)

# Load Google
driver.get("https://www.google.com")
driver.save_screenshot("task_4_1.png")  # Take a screenshot of the homepage

# Google search
search_box = driver.find_element(By.NAME, "q")
search_box.send_keys("Selenium")
search_box.submit()
driver.save_screenshot("task_4_2.png")  # Take a screenshot of the search results

# First link in the results
first_link = driver.find_element(By.CSS_SELECTOR, "h3")
first_link.click()
driver.save_screenshot("task_4_3.png")  # Take a screenshot of the first result page

driver.quit()
