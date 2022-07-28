from routes import *
from db import conn
from flask_cors import CORS

cors = CORS(app, resources={r"/api/*": {"origins": "*"}})
conn()

if __name__ == '__main__':
    app.run(debug=True)