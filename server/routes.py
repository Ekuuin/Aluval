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
        product['pro_cost'] = locale.currency(
            product['pro_cost'], grouping=True)
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
        project['proy_total'] = locale.currency(
            project['proy_total'], grouping=True)
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


@app.route('/api/historial/actualizarEstatus', methods=["POST"])
def actualizarEstado():
    data = request.get_json(silent=True)
    query = "UPDATE proyectos SET proy_estado = %s WHERE proy_id = %s"
    conn = mysql.connect()
    cursor = conn.cursor()
    cursor.execute(query, (data['status'], data['id']))
    conn.commit()
    return jsonify(f"Project ID-{data['id']} updated successfully")


# Rutas de Inicio

@app.route('/api/inicio/obtenerProyectosActivos')
def obtenerProyectosActivos():
    query = "SELECT * FROM proyectos WHERE proy_estado = 'ACTIVO'"
    conn = mysql.connect()
    cursor = conn.cursor()
    cursor.execute(query)
    data = cursor.fetchall()
    for project in data:
        project['proy_fecha'] = project['proy_fecha'].strftime("%d/%B/%Y")
        project['proy_total'] = locale.currency(
            project['proy_total'], grouping=True)
    return jsonify(data)


# Rutas de Cotización

@app.route('/api/cotizacion/nuevoProyecto', methods=["POST"])
def nuevoProyecto():
    data = request.get_json(silent=True)
    _name = data['customer']
    _address = data['address']
    _total = data['total']

    query = """INSERT INTO proyectos (proy_fecha, proy_cliente, proy_domicilio, proy_total) VALUES (CURDATE(), %s, %s, %s);"""
    conn = mysql.connect()
    cursor = conn.cursor()
    cursor.execute(query, (_name, _address, _total))
    conn.commit()

    query = "SELECT MAX(proy_id) AS id FROM proyectos"
    cursor.execute(query)
    id = cursor.fetchall()

    for data in data['product']:
        _prodId = data['cristal']
        _type = data["type"]
        _perfil = data['perfil']
        _quantity = data["quantity"]
        _width = data["width"]
        _height = data["height"]
        _comments = data["comments"]
        _cost = data["cost"]
        query = """INSERT INTO detalles_pedido(dp_prod_id, dp_proy_id, dp_costo, dp_tipo, dp_perfil, dp_cantidad, dp_ancho, dp_altura, dp_comentarios)
                VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s)"""
        cursor.execute(query, (_prodId, id[0]['id'], _cost, _type,
                       _perfil, _quantity, _width, _height, _comments))
        conn.commit()
    return jsonify("OK")


@app.route('/api/cotizacion/obtenerCristales')
def obtenerCristales():
    query = "SELECT p.* FROM productos AS p INNER JOIN categoria AS c ON p.pro_category = c.cat_id AND c.cat_name = 'Cristales'"
    conn = mysql.connect()
    cursor = conn.cursor()
    cursor.execute(query)
    products = cursor.fetchall()
    return jsonify(products)


@app.route('/api/cotizacion/obtenerPerfiles')
def obtenerPerfiles():
    query = "SELECT p.* FROM productos AS p INNER JOIN categoria AS c ON p.pro_category = c.cat_id AND c.cat_name = 'Perfiles'"
    conn = mysql.connect()
    cursor = conn.cursor()
    cursor.execute(query)
    products = cursor.fetchall()
    return jsonify(products)


# Rutas PDF

@app.route('/api/pdf/obtenerProyecto', methods=['POST'])
def obtenerProyecto():
    data = request.get_json(silent=True)
    query = "SELECT * FROM proyectos WHERE proy_id = %s"
    conn = mysql.connect()
    cursor = conn.cursor()
    cursor.execute(query, data['id'])
    project = cursor.fetchall()
    project[0]['proy_fecha'] = project[0]['proy_fecha'].strftime("%d/%m/%Y")
    return jsonify(project)

@app.route('/api/pdf/obtenerProductos', methods=['POST'])
def obtenerProductosPDF():
    data = request.get_json(silent=True)
    query = "SELECT * FROM detalles_pedido AS dp INNER JOIN productos AS p ON dp.dp_prod_id = p.pro_id INNER JOIN productos AS p2 ON dp.dp_perfil = p2.pro_id WHERE dp.dp_proy_id = %s"
    conn = mysql.connect()
    cursor = conn.cursor()
    cursor.execute(query, data['id'])
    products = cursor.fetchall()
    return jsonify(products)