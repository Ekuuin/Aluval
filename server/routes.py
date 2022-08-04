from threading import local
from time import strftime
from flask import Flask, jsonify, request, redirect
from flaskext.mysql import MySQL
from pymysql.cursors import DictCursor
from datetime import datetime
import locale

locale.setlocale(locale.LC_ALL, 'es-MX')

app = Flask(__name__)
# Importamos DictCursor para mostrar los resultados obtenidos de la query en modo diccionario
mysql = MySQL(cursorclass=DictCursor)
app.config['MYSQL_DATABASE_HOST'] = 'localhost'
app.config['MYSQL_DATABASE_USER'] = 'root'
app.config['MYSQL_DATABASE_PASSWORD'] = ''
app.config['MYSQL_DATABASE_DB'] = 'aluval'
app.config['MYSQL_DATABASE_PORT'] = 3306


try:
    mysql.init_app(app)
    con = mysql.connect()
except:
    print("---------Error conexion DB---------")
else:
    print("---------Conexion DB establecida---------")


@app.route('/api/mensaje2')
def mensajeBienvenida():
    a = "asdad"
    return jsonify("alaberga")


@app.route('/api/mensaje')
def mensaje():
    return jsonify(mensaje="Nuevo mensaje desde un servidor Flask")


# Rutas de inventario

@app.route('/api/inventario/nuevoProducto', methods=["POST"])
def nuevoProducto():
    _post_data = request.get_json(silent=True)
    _productName = _post_data['name']
    _productIDCategory = _post_data['category']
    _productBrand = _post_data['brand']
    _productCost = _post_data['cost']
    _productUnit = _post_data['units']
    query = """INSERT INTO productos (pro_name, pro_category, pro_brand, pro_cost, pro_unit) VALUES (%s, %s, %s, %s, %s)"""
    datos = (_productName, _productIDCategory,
             _productBrand, _productCost, _productUnit)
    conn = mysql.connect()
    cursor = conn.cursor()
    cursor.execute(query, datos)
    conn.commit()
    return jsonify(msg="OK", product=_post_data)


@app.route('/api/inventario/nuevaCategoria', methods=["POST"])
def nuevaCategoria():
    _categoryName = request.get_json(silent=True)
    _categoryName = _categoryName['category']
    query = """INSERT INTO categoria (cat_name) VALUES (%s)"""
    conn = mysql.connect()
    cursor = conn.cursor()
    cursor.execute(query, _categoryName)
    conn.commit()

    query = "SELECT MAX(cat_id) AS id FROM categoria"
    cursor.execute(query)
    data = cursor.fetchall()
    conn.commit()
    return jsonify(data)


@app.route('/api/inventario/obtenerProductos')
def obtenerProductos():
    query = """SELECT * FROM productos AS p, categoria AS c WHERE p.pro_category = c.cat_id"""
    conn = mysql.connect()
    cursor = conn.cursor()
    cursor.execute(query)
    data = cursor.fetchall()
    for product in data:
        product['pro_cost'] = locale.currency(product['pro_cost'], grouping=True)
    return jsonify(data)


@app.route('/api/inventario/obtenerCategorias')
def obtenerCategorias():
    query = """SELECT * FROM categoria"""
    conn = mysql.connect()
    cursor = conn.cursor()
    cursor.execute(query)
    data = cursor.fetchall()
    return jsonify(data)


@app.route('/api/inventario/borrarProducto/<int:id>')
def borrarProducto(id):
    query = "DELETE FROM productos WHERE pro_id = %s"
    conn = mysql.connect()
    cursor = conn.cursor()
    cursor.execute(query, id)
    conn.commit()
    return jsonify(msg="Successfully deleted", id=id)


@app.route('/api/inventario/borrarCategoria/<int:id>')
def borrarCategoria(id):
    query = "DELETE FROM categoria WHERE cat_id = %s"
    conn = mysql.connect()
    cursor = conn.cursor()
    cursor.execute(query, id)
    conn.commit()
    return jsonify(msg="Successfully deleted", id=id)


@app.route('/api/inventario/actualizarProducto', methods=["POST"])
def actualizarProducto():
    data = request.get_json(silent=True)
    _productId = data['pro_id']
    _productName = data['pro_name']
    _productCategory = data['pro_category']
    _productBrand = data['pro_brand']
    _productCost = data['pro_cost']
    _productUnit = data['pro_unit']
    data = (_productName, _productCategory, _productBrand,
            _productCost, _productUnit, _productId)

    query = "UPDATE productos SET pro_name = %s, pro_category = %s, pro_brand = %s, pro_cost = %s, pro_unit = %s WHERE pro_id = %s"
    conn = mysql.connect()
    cursor = conn.cursor()
    cursor.execute(query, data)
    conn.commit()
    return jsonify(f"Product ID {_productId} successfully updated")


@app.route('/api/inventario/actualizarCategoria', methods=["POST"])
def actualizarCategoria():
    data = request.get_json(silent=True)
    data = (data['cat_name'], data['cat_id'])
    query = "UPDATE categoria SET cat_name = %s WHERE cat_id = %s"
    conn = mysql.connect()
    cursor = conn.cursor()
    cursor.execute(query, data)
    conn.commit()
    return jsonify(f"Category ID {data[0]} successfully updated")

# Rutas de Historial


@app.route('/api/historial/obtenerProyectos')
def obtenerProyectos():
    query = "SELECT * FROM proyectos"
    conn = mysql.connect()
    cursor = conn.cursor()
    cursor.execute(query)
    data = cursor.fetchall()
    for project in data:
        project['proy_fecha'] = project['proy_fecha'].strftime("%d/%B/%Y")
        project['proy_total'] = locale.currency(project['proy_total'], grouping=True)
    return jsonify(data)


@app.route('/api/historial/obtenerDetalles', methods=["POST"])
def obtenerDetalles():
    data = request.get_json(silent=True)
    query = "SELECT * FROM detalles_pedido WHERE dp_proy_id = %s"
    conn = mysql.connect()
    cursor = conn.cursor()
    cursor.execute(query, data['id'])
    data = cursor.fetchall()
    return jsonify(data)


#Rutas de Inicio

@app.route('/api/inicio/obtenerProyectosActivos')
def obtenerProyectosActivos():
    query = "SELECT * FROM proyectos WHERE proy_estado = 'ACTIVO'"
    conn = mysql.connect()
    cursor = conn.cursor()
    cursor.execute(query)
    data = cursor.fetchall()
    for project in data:
        project['proy_fecha'] = project['proy_fecha'].strftime("%d/%B/%Y")
        project['proy_total'] = locale.currency(project['proy_total'], grouping=True)
    return jsonify(data)