import sqlite3

if __name__ == "__main__":
    taskbook_db = sqlite3.connect('taskbook.db')  
    with taskbook_db:
        taskbook_db_cursor = taskbook_db.cursor()
        taskbook_db_cursor.execute('''DROP TABLE IF EXISTS task''')
        taskbook_db_cursor.execute('''CREATE TABLE task (id INTEGER NOT NULL PRIMARY KEY, time FLOAT, description TEXT, list TEXT, completed BOOLEAN, color TEXT, CHECK (completed IN (0, 1)))''')
        
        taskbook_db_cursor.executemany(
            '''INSERT INTO task (time, description, list, completed, color) VALUES (:time, :description, :list, :completed, :color)''', 
            [
                {"time":0.0, "description":"Do something useful", "list":"today", "completed":True, "color": "#ff0000"},
                {"time":0.5, "description":"Do something fantastic", "list":"today", "completed":False, "color": "#00ff00"},
                {"time":0.3, "description":"Do something remarkable", "list":"tomorrow", "completed":False, "color": "#0000ff"},
                {"time":0.7, "description":"Do something unusual", "list":"tomorrow", "completed":True, "color": "#ffff00"},
                {"time":0.4, "description":"Do something unusual", "list":"the-next-day", "completed":True, "color": "#ff00ff"},
                {"time":0.6, "description":"Do something unusual", "list":"the-day-after-that", "completed":False, "color": "#00ffff"}   
            ]
        )
    taskbook_db.close()