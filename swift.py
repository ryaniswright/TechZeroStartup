# SWIFT Taskbook
# Web Application for Task Management

# system libraries
import os

# web transaction objects
from bottle import request, response, auth_basic

# HTML request types
from bottle import route, get, put, post, delete

# static file return type
from bottle import static_file

# web page template processor
from bottle import template
import json
import sqlite3
import time

taskbook_db = sqlite3.connect('taskbook.db') # Create a python representation of the database

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

def is_authenticated_user(email, password): #login authentication
    taskbook_db_cursor = taskbook_db.cursor()
    taskbook_db_cursor.execute("SELECT * FROM user WHERE email=:email", {"email": email}) #querying the database for given email
    current_user = taskbook_db_cursor.fetchone() #setting query result to current_user
        
    if(current_user is None): #if email doesnt exist redirect to try again
        return False
    if(current_user['password'] != password): #if given password doesnt match password in db, redirect to try again
        return False
    
    return True

# When someone goes to the root directory or /tasks
@route('/tasks')
def tasks():
    return template("tasks.tpl") # Returns the rendered tasks.tpl

# Used for getting static files stored in the /static directory. Will be used for stylesheets and images later.
@route('/static/<filename:path>')
def send_static(filename):
    return static_file(filename, root='static/')

@route('/')
def homeTasks():
    return template('homeTasks.tpl')

# TODO Will be used for logins
@route('/login')
def login():
    return template("login.tpl")

@post('/login')
def login():
    email = request.forms.get('email')
    password = request.forms.get('password')
    if is_authenticated_user(email, password):
        return template('tasks.tpl')
    return "login credentials incorrect try again"

@route('/logout')
def logout():
    return template('login.tpl')

@route('/register')
def register():
    return template('register.tpl')

# registration - basic implementation
@post('/register')
def register():
    firstName = request.forms.get('firstName') #getting form data
    lastName = request.forms.get('lastName')
    email = request.forms.get('email')
    password = request.forms.get('password')
    password2 = request.forms.get('password2')
    tosCheck = request.forms.get('tosCheck')
    
    if password != password2: #checking if passwords match
        return template('register.tpl') #redirects user if passwords do not match
    
    taskbook_db_cursor = taskbook_db.cursor()
    taskbook_db_cursor.execute("SELECT * FROM user WHERE email=:email", {"email": email}) #querying the database for given email
    current_user = taskbook_db_cursor.fetchone() #setting query result to current_user
    if(current_user is not None): #if email exists already, redirect to try again with new email
        return template('register.tpl')
    
    # if passwords match
    #inserting the data into DATABASE
    with taskbook_db:
        taskbook_db_cursor = taskbook_db.cursor()
        taskbook_db_cursor.execute('''INSERT INTO user (firstName, lastName, email, password) VALUES (:firstName, :lastName, :email, :password)''', 
            {
            "firstName":firstName,
            "lastName":lastName,
            "email":email.lower(),
            "password":password,
            }
        )
    return template('login.tpl')

# ---------------------------
# task REST api
# ---------------------------


def dict_factory(cursor, row):
    d = {}
    for idx, col in enumerate(cursor.description):
        d[col[0]] = row[idx]
    return d

taskbook_db.row_factory = dict_factory

# Returns the API version
@get('/api/version')
def get_version():
    return { "version":VERSION }

@get('/api/tasks')
def get_tasks():
    'return a list of tasks sorted by submit/modify time'
    response.headers['Content-Type'] = 'application/json' # Set headers
    response.headers['Cache-Control'] = 'no-cache'
    with taskbook_db:
        taskbook_db_cursor = taskbook_db.cursor()
        taskbook_db_cursor.execute('''SELECT * FROM task NATURAL JOIN user WHERE userID=u_id ORDER BY time ASC''')
        tasks = taskbook_db_cursor.fetchall() # List comprehension to get all tasks from the database
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
        with taskbook_db:
            taskbook_db_cursor = taskbook_db.cursor()
            taskbook_db_cursor.execute('''INSERT INTO task (userID, time, description, list, completed, color) VALUES (:userID, :time, :description, :list, :completed, :color)''', 
                {
                "userID":data['userID'],
                "time": time.time(),
                "description":data['description'].strip(),
                "list":data['list'],
                "completed":False,
                "color":data['color']
                }
            )
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
        with taskbook_db:
            taskbook_db_cursor = taskbook_db.cursor()
            taskbook_db_cursor.execute('UPDATE task SET {} {} {} {} {} WHERE id = {}'.format(f"userID = {data['userID']}" if "userID" in data.keys() else "", f"completed = {data['completed']}" if "completed" in data.keys() else "", f"list = '{data['list']}'" if "list" in data.keys() else "", f"description = '{data['description']}', " if "description" in data.keys() else "", f"color = '{data['color']}'" if "color" in data.keys() else "", data['id']))
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
        with taskbook_db:
            taskbook_db_cursor = taskbook_db.cursor()
            taskbook_db_cursor.execute('''DELETE FROM task WHERE id = :id''', data)
    except Exception as e: # If we got any database exceptions, show them here
        response.status="409 Bad Request:"+str(e)
        return
    # return 200 Success
    response.headers['Content-Type'] = 'application/json' # Set header
    return json.dumps({'success': True})

# Run the app based on environment
if PYTHONANYWHERE:
    application = default_app()
else:
   if __name__ == "__main__":
       run(host='localhost', port=8080, debug=True)


