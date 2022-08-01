from routes import *
from flask_cors import CORS

cors = CORS(app, resources={r"/api/*": {"origins": "*"}})

if __name__ == '__main__':
    app.run(host='0.0.0.0',debug=True)