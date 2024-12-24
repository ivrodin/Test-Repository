from selenium import webdriver
from selenium.webdriver.common.by import By
# from selenium.webdriver.support.ui import WebDriverWait
# from selenium.webdriver.support import expected_conditions as EC

driver = webdriver.Chrome()
driver.get('https://phptravels.com/demo/')


# Class name
element_by_class_1 = driver.find_element(By.CLASS_NAME, "col-md-6")
print("Element by class 1:", element_by_class_1.text)

element_by_class_2 = driver.find_element(By.CLASS_NAME, "col-md-12")
print("Element by class 2:", element_by_class_2.text)

# ID
element_by_id_1 = driver.find_element(By.ID, "number")
print("Element by ID 1:", element_by_id_1.tag_name)

element_by_id_2 = driver.find_element(By.ID, "demo")
print("Element by ID 2:", element_by_id_2.tag_name)

# Name
element_by_name_1 = driver.find_element(By.NAME, "first_name")
print("Element by Name 1:", element_by_name_1.get_attribute('name'))

element_by_name_2 = driver.find_element(By.NAME, "last_name")
print("Element by Name 2:", element_by_name_2.get_attribute('name'))

# CSS selector
element_by_css_1 = driver.find_element(By.CSS_SELECTOR, "#number")
print("Element by CSS 1:", element_by_css_1.tag_name)

element_by_css_2 = driver.find_element(By.CSS_SELECTOR, "#demo")
print("Element by CSS 2:", element_by_css_2.text)

# XPath
element_by_xpath_1 = driver.find_element(By.XPATH, "//input[@name='last_name']")
print("Element by XPath 1:", element_by_xpath_1.get_attribute('name'))

element_by_xpath_2 = driver.find_element(By.XPATH, "//button[@type='button']")
print("Element by XPath 2:", element_by_xpath_2.text)

# Close the browser
driver.quit()
