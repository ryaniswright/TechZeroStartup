import sqlite3

if __name__ == "__main__":
    taskbook_db = sqlite3.connect('taskbook.db')
    
    with taskbook_db:
        taskbook_db_cursor = taskbook_db.cursor()
        taskbook_db_cursor.execute('''DROP TABLE IF EXISTS task''')
        taskbook_db_cursor.execute('''DROP TABLE IF EXISTS user''')
        taskbook_db_cursor.execute('''CREATE TABLE user (u_id INTEGER NOT NULL PRIMARY KEY, firstName TEXT, lastName TEXT, email TEXT, password TEXT, UNIQUE(email)) ''')
        taskbook_db_cursor.execute('''CREATE TABLE task (id INTEGER NOT NULL PRIMARY KEY, userID INTEGER, time FLOAT, description TEXT, list TEXT, completed BOOLEAN, color TEXT, CHECK (completed IN (0, 1)), FOREIGN KEY (userID) REFERENCES user (u_id))''')
        
        taskbook_db_cursor.executemany(
            '''INSERT INTO user (firstName, lastName, email, password) VALUES(:firstName, :lastName, :email, :password)''',
            [
                {"firstName":"Tony", "lastName":"Shelton", "email":"ashelto6@kent.edu", "password":"dog"},
                {"firstName":"Brandon", "lastName":"Cossin", "email":"bcossin@kent.edu", "password":"dog"},
                {"firstName":"Johnathon", "lastName":"Raber", "email":"jraber11@kent.edu", "password":"dog"},
                {"firstName":"Jason", "lastName":"Conley", "email":"jconle27@kent.edu", "password":"dog"},
                {"firstName":"Joseph", "lastName":"Lagucki", "email":"jlaguck1@kent.edu", "password":"dog"},
                {"firstName":"Dan", "lastName":"Maher", "email":"dmaher2@kent.edu", "password":"dog"},
            ]
        )
        taskbook_db_cursor.executemany(
            '''INSERT INTO task (userID, time, description, list, completed, color) VALUES (:userID, :time, :description, :list, :completed, :color)''', 
            [
                {"userID":1, "time":0.0, "description":"Do something useful", "list":"today", "completed":True, "color": "#ff0000"},
                {"userID":2, "time":0.5, "description":"Do something fantastic", "list":"today", "completed":False, "color": "#00ff00"},
                {"userID":3, "time":0.3, "description":"Do something remarkable", "list":"tomorrow", "completed":False, "color": "#0000ff"},
                {"userID":4, "time":0.7, "description":"Do something unusual", "list":"tomorrow", "completed":True, "color": "#ffff00"},
                {"userID":5, "time":0.4, "description":"Do something unusual", "list":"the-next-day", "completed":True, "color": "#ff00ff"},
                {"userID":6, "time":0.6, "description":"Do something unusual", "list":"the-day-after-that", "completed":False, "color": "#00ffff"}   
            ]
        )
    taskbook_db.close()