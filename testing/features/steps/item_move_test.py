from behave import *
import sqlite3

# Python representation of the database
conn = sqlite3.connect('../../../taskbook.db')

@given('we have an item in todays list')
def step_impl(context):
    cursor = conn.execute("SELECT COUNT(*) FROM task")
    for row in cursor:
        num = row[0]
    assert num > 0  # assert that at least one item is there

@when('we move it to tomorrow')
def step_impl(context):
    assert True

@then('it will appear in tomorrows list')
def step_impl(context):
    assert True