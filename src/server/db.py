from routes import app
from flaskext.mysql import MySQL

def conn():
    try:
        mysql = MySQL()
        app.config['MYSQL_DATABASE_HOST'] = 'localhost'
        app.config['MYSQL_DATABASE_USER'] = 'root'
        app.config['MYSQL_DATABASE_PASSWORD'] = ''
        app.config['MYSQL_DATABASE_DB'] = 'aluval'
        app.config['MYSQL_DATABASE_PORT'] = 3306
        mysql.init_app(app)
        con = mysql.connect()
    except:
        print("---------Error conexion DB---------")
    else:
        print("---------Conexion DB establecida---------")