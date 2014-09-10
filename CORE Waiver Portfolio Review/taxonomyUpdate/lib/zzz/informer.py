from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.support.ui import Select
from selenium.common.exceptions import NoSuchElementException
import unittest, time, re

today = time.strftime('%Y-%m-%d', time.localtime())
year = time.strftime('%Y', time.localtime())

class Informer(unittest.TestCase):
    def setUp(self):
        self.driver = webdriver.Firefox()
        self.driver.implicitly_wait(30)
        self.base_url = "https://vm-informer-01.cca.edu"
        self.verificationErrors = []
        self.accept_next_alert = True

    def test_informer(self):
        driver = self.driver
        driver.get(self.base_url + "/informer/?locale=en_US")
        driver.find_element_by_css_selector("input.gwt-TextBox").clear()
        driver.find_element_by_css_selector("input.gwt-TextBox").send_keys("ephetteplace")
        driver.find_element_by_css_selector("input.gwt-PasswordTextBox").clear()
        driver.find_element_by_css_selector("input.gwt-PasswordTextBox").send_keys("INSERT PASSWORD HERE")
        driver.find_element_by_css_selector("input.gwt-PasswordTextBox").send_keys(Keys.RETURN)
        time.sleep(3)

        driver.get(self.base_url + "/informer/?locale=en_US#action=ReportRun&reportId=42598401&launch=false")
        time.sleep(3)

        driver.find_element_by_css_selector("input.gwt-TextBox").clear()
        driver.find_element_by_css_selector("input.gwt-TextBox").send_keys(year + "FA")
        driver.find_element_by_xpath("//div[3]/div/div/table[2]/tbody/tr/td/div").click()
        driver.find_element_by_xpath("//div/table/tbody/tr[2]/td/div").click()
        driver.find_element_by_xpath("//tr[2]/td/table/tbody/tr/td/div/div/div/table/tbody/tr/td/div").click()

        driver.find_element_by_css_selector("td.GCCTW2-BJG > input.gwt-TextBox").clear()
        driver.find_element_by_css_selector("td.GCCTW2-BJG > input.gwt-TextBox").send_keys(today)

        # "Column Headers" checkbox
        driver.find_element_by_css_selector(".popupContent .gwt-CheckBox input").click()
        driver.find_element_by_css_selector("div.button.button-up-hovering").click()


if __name__ == "__main__":
    unittest.main()
