from flask import Flask, jsonify
app = Flask(__name__)

@app.route('/api/mensaje2')
def mensajeBienvenida():
    return jsonify("Que onda prro")

@app.route('/api/mensaje')
def mensaje():
    return jsonify("Nuevo mensaje desde un servidor Flask")