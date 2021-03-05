# SWIFT Taskbook
# Web Application for Task Management

# system libraries
import os

# web transaction objects
from bottle import request, response

# HTML request types
from bottle import route, get, put, post, delete

# static file return type
from bottle import static_file

# web page template processor
from bottle import template

VERSION=0.1

# development server
PYTHONANYWHERE = ("PYTHONANYWHERE_SITE" in os.environ) # Boolean constant to see if we are on pythonanywhere or local

if PYTHONANYWHERE: # Change run behavior depending on platform
    from bottle import default_app
else:
    from bottle import run

# ---------------------------
# web application routes
# ---------------------------

# When someone goes to the root directory or /tasks
@route('/')
@route('/tasks')
def tasks():
    if request.get_cookie("darkmode") is None:
        response.set_cookie("darkmode", "false")
    darkmode = request.get_cookie("darkmode")
    return template("tasks.tpl", darkmode = darkmode) # Returns the rendered tasks.tpl

# Used for getting static files stored in the /static directory. Will be used for stylesheets and images later.
@route('/static/<filename:path>')
def send_static(filename):
    return static_file(filename, root='static/')

# TODO Will be used for logins
@route('/login')
def login():
    if request.get_cookie("darkmode") is None:
        response.set_cookie("darkmode", "false")
    darkmode = request.get_cookie("darkmode")
    return template("login.tpl", darkmode = darkmode)

# TODO Will be used for logins
@route('/register')
def register():
    if request.get_cookie("darkmode") is None:
        response.set_cookie("darkmode", "false")
    darkmode = request.get_cookie("darkmode")
    return template("register.tpl", darkmode = darkmode)

# ---------------------------
# task REST api
# ---------------------------

import json
import dataset
import time

taskbook_db = dataset.connect('sqlite:///taskbook.db') # Create a python representation of the database

# Returns the API version
@get('/api/version')
def get_version():
    return { "version":VERSION }

@get('/api/tasks')
def get_tasks():
    'return a list of tasks sorted by submit/modify time'
    response.headers['Content-Type'] = 'application/json' # Set headers
    response.headers['Cache-Control'] = 'no-cache'
    task_table = taskbook_db.get_table('task') # Get the tasks table from the database
    tasks = [dict(x) for x in task_table.find(order_by='time')] # List comprehension to get all tasks from the database
    return { "tasks": tasks }

@post('/api/tasks')
def create_task():
    'create a new task in the database'
    try:
        data = request.json # Get a reference to the request json
        for key in data.keys(): # For every key in the request
            assert key in ["description","list","color"], f"Illegal key '{key}'" # Assert that the key type is valid
        assert type(data['description']) is str, "Description is not a string." # Assert that the description is of type string
        assert len(data['description'].strip()) > 0, "Description is length zero." # Assert that the description is not empty
        assert data['list'] in ["today","tomorrow","the-next-day", "the-day-after-that"], "List must be 'today', 'tomorrow', 'the-next-day' or 'the-day-after-that'" # Assert that the list key is valid
    except Exception as e: # If we got any request exceptions, show them here
        response.status="400 Bad Request:"+str(e)
        return
    try:
        task_table = taskbook_db.get_table('task') # Get the tasks table from the database
        # Place the new task in the database
        task_table.insert({
            "time": time.time(),
            "description":data['description'].strip(),
            "list":data['list'],
            "color":data['color'],
            "completed":False
        })
    except Exception as e: # If we got any database exceptions, show them here
        response.status="409 Bad Request:"+str(e)
    # return 200 Success
    response.headers['Content-Type'] = 'application/json' # Set header
    return json.dumps({'status':200, 'success': True}) # If we made it this far, the request was good!

@put('/api/tasks')
def update_task():
    'update properties of an existing task in the database'
    try:
        data = request.json # Get a reference to the request json
        for key in data.keys(): # For every key in the request
            assert key in ["id","description","completed","list","color"], f"Illegal key '{key}'" # Assert that the key type is valid
        assert type(data['id']) is int, f"id '{id}' is not int" # Assert that the id is an integer
        if "description" in request: # If we are changing the description
            assert type(data['description']) is str, "Description is not a string." # Assert that it is a string
            assert len(data['description'].strip()) > 0, "Description is length zero." # Assert that it is not empty
        if "completed" in request: # If we are changing the completeness of a task
            assert type(data['completed']) is bool, "Completed is not a bool." # Assert that it is a boolean
        if "list" in request: # If we are changing the day of a task
            assert data['list'] in ["today","tomorrow","the-next-day","the-day-after-that"], "List must be 'today', 'tomorrow', 'the-next-day' or 'the-day-after-that'" # Assert that the list is valid
    except Exception as e: # If we got any request exceptions, show them here
        response.status="400 Bad Request:"+str(e)
        return
    if 'list' in data: # If we are changing the day of a task
        data['time'] = time.time() # Update the time of the task
    try:
        task_table = taskbook_db.get_table('task') # Get the tasks table from the database
        task_table.update(row=data, keys=['id']) # Update the tasks table appropriately based on the request
    except Exception as e: # If we got any database exceptions, show them here
        response.status="409 Bad Request:"+str(e)
        return
    # return 200 Success
    response.headers['Content-Type'] = 'application/json' # Set header
    return json.dumps({'status':200, 'success': True})

@delete('/api/tasks')
def delete_task():
    'delete an existing task in the database'
    try:
        data = request.json # Get a reference to the request json
        assert type(data['id']) is int, f"id '{id}' is not int" # Assert that the id is an integer
    except Exception as e: # If we got any request exceptions, show them here
        response.status="400 Bad Request:"+str(e)
        return
    try:
        task_table = taskbook_db.get_table('task') # Get the tasks table from the database
        task_table.delete(id=data['id']) # Delete the row with the id specified in the request
    except Exception as e: # If we got any database exceptions, show them here
        response.status="409 Bad Request:"+str(e)
        return
    # return 200 Success
    response.headers['Content-Type'] = 'application/json' # Set header
    return json.dumps({'success': True})

# ---------------------------
# darkmode api
# ---------------------------
@route('/api/darkmode/toggle')
def tasks():
    response.set_cookie("darkmode", "false" if request.get_cookie("darkmode") == "true" else "true", path="/")
    response.headers['Content-Type'] = 'application/json'
    return json.dumps({'success': True})

# Run the app based on environment
if PYTHONANYWHERE:
    application = default_app()
else:
   if __name__ == "__main__":
       run(host='localhost', port=8080, debug=True)


