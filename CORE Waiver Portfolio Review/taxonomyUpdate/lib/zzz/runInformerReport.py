#!/usr/bin/env python
import sys
# see http://selenium-python.readthedocs.org/en/latest/getting-started.html
from selenium import webdriver
from selenium.webdriver.common.keys import Keys
from time import sleep

un = sys.argv[1]
browser = webdriver.Chrome()

# these steps run either way, both manual & auto
def setup():
    # wait 10 secs for all elements to load
    browser.implicitly_wait(10)
    browser.get('https://vm-informer-01.cca.edu/informer/?locale=en_US')
    # @todo getting "no such element" errors right now
    username = browser.find_element_by_css_selector('.inf-LoginForm input.gwt-TextBox')
    username.send_keys(un)


def auto(pw):
    setup()
    password = browser.find_element_by_css_selector('.inf-LoginForm input.gwt-PasswordTextBox')
    password.click()
    password.send_keys(pw)
    # submits the login form
    password.send_keys(Keys.RETURN)
    # Are we logged in?
    sleep(2)
    assert 'Informer Reporting - Reports Home' in browser.title, 'Unable to log into Informer! Log in & proceed manually.'
    # Navigate directly to 'ADV-Vault-Deposits-for-Portfolio-Review'
    browser.get('https://vm-informer-01.cca.edu/informer/?locale=en_US#action=ReportRun&reportId=42598401&launch=false')
    sleep(2)
    assert 'ADV-Vault-Deposits-for-Portfolio-Review' in browser.find_element_by_class_name('inf-Page-Header-Title').text, 'Unable to access "ADV-Vault-Deposits-for-Portfolio-Review" report'
    # @todo
    # fill in 2014FA
    # fill in


# run the script
if __name__ == '__main__':
    try:
        pw = sys.argv[2]
        auto(pw)
    except IndexError: # no password passed to the script
        setup()
