# import webdriver 
from selenium import webdriver 

# import Action chains  
from selenium.webdriver.common.action_chains import ActionChains

# create webdriver object 
driver = webdriver.Firefox() 
# get taskbook
driver.get("http://jconle27.pythonanywhere.com/")

# refresh task page
element = driver.find_element_by_link_text("Tasks")

# create action chain
action = ActionChains(driver)

#click tasks button
action.click(on_element = element)

#running action
action.perform()

#fails after this point becuase I cannot find the title element

#checking the title is Taskbook for fun
element = driver.find_element_by_id("w3-xxxlarge w3-left s12 l6")
assert(element.text == "Taskbook")

#attempt inputting a task 
element = driver.find_element_by_id("input-today")
element.send_keys("Make some tests")

