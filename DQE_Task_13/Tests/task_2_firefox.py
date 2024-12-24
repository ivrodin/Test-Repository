from selenium import webdriver
from selenium.webdriver.firefox.service import Service as FirefoxService
from selenium.webdriver.firefox.options import Options

geckodriver_path = r"C:\Users\ivanr\Downloads\geckodriver-v0.35.0-win32\geckodriver.exe"
firefox_binary_path = r"C:\Program Files\Mozilla Firefox\firefox.exe"  # Update this if needed

# was raising error that could not find binary of firefox, so made a manual thing for updating path
firefox_options = Options()
firefox_options.binary_location = firefox_binary_path

service = FirefoxService(executable_path=geckodriver_path)
driver = webdriver.Firefox(service=service, options=firefox_options)

driver.get("https://www.google.com")
print("Firefox - Page title is:", driver.title)

driver.quit()
