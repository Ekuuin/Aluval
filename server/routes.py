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

def nl2br(s):
    return '<br>\n'.join(s.split('\n'))

# Rutas de inventario

@app.route('/api/inventario/nuevoProducto', methods=["POST"])
def nuevoProducto():
    _data = request.get_json(silent=True)
    _productName = _data['name']
    _productIDCategory = _data['category']
    _productBrand = _data['brand']
    _productCost = _data['cost']
    _productUnit = _data['units']
    _jambaC = _data['jambaC']
    _mosquiteroC = _data['mosquiteroC']
    _rielC = _data['rielC']
    _adaptadorC = _data['adaptadorC']
    _traslapeC = _data['traslapeC']
    _zocloC = _data['zocloC']
    _bolsaF = _data['bolsaF']
    _escalonadoF = _data['escalonadoF']
    _junquilloF = _data['junquilloF']
    _marcoPE = _data['marcoPE']
    _cercoPE = _data['cercoPE']
    _zocloPE = _data['zocloPE']
    _tubularPEsp = _data['tubularPEsp']
    _hojaPEsp = _data['hojaPEsp']
    _zocloPEsp = _data['zocloPEsp']
    _junquilloPEsp = _data['junquilloPEsp']
    query = """INSERT INTO productos (pro_name, pro_category, pro_brand, pro_cost, pro_unit, jambaC, mosquiteroC, rielC,
            adaptadorC, traslapeC, zocloC, bolsaF, escalonadoF, junquilloF, marcoPE, cercoPE, zocloPE, tubularPEsp, hojaPEsp, zocloPEsp,
            junquilloPEsp) VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)"""
    datos = (_productName, _productIDCategory, _productBrand, _productCost, _productUnit,
            _jambaC, _mosquiteroC, _rielC, _adaptadorC, _traslapeC, _zocloC, _bolsaF, _escalonadoF,
            _junquilloF, _marcoPE, _cercoPE, _zocloPE, _tubularPEsp, _hojaPEsp, _zocloPEsp, _junquilloPEsp)
    conn = mysql.connect()
    cursor = conn.cursor()
    cursor.execute(query, datos)
    conn.commit()
    return jsonify(msg="OK", product=_data)


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
    _data = request.get_json(silent=True)
    _productId = _data['pro_id']
    _productName = _data['pro_name']
    _productCategory = _data['pro_category']
    _productBrand = _data['pro_brand']
    _productCost = _data['pro_cost']
    _productUnit = _data['pro_unit']
    _jambaC = _data['jambaC']
    _mosquiteroC = _data['mosquiteroC']
    _rielC = _data['rielC']
    _adaptadorC = _data['adaptadorC']
    _traslapeC = _data['traslapeC']
    _zocloC = _data['zocloC']
    _bolsaF = _data['bolsaF']
    _escalonadoF = _data['escalonadoF']
    _junquilloF = _data['junquilloF']
    _marcoPE = _data['marcoPE']
    _cercoPE = _data['cercoPE']
    _zocloPE = _data['zocloPE']
    _tubularPEsp = _data['tubularPEsp']
    _hojaPEsp = _data['hojaPEsp']
    _zocloPEsp = _data['zocloPEsp']
    _junquilloPEsp = _data['junquilloPEsp']
    data = (_productName, _productCategory, _productBrand,
            _productCost, _productUnit, _jambaC, _mosquiteroC, _rielC, _adaptadorC,
            _traslapeC, _zocloC, _bolsaF, _escalonadoF, _junquilloF, _marcoPE, 
            _cercoPE, _zocloPE, _tubularPEsp, _hojaPEsp, _zocloPEsp, _junquilloPEsp, _productId)

    query = """UPDATE productos SET pro_name = %s, pro_category = %s, pro_brand = %s, pro_cost = %s, pro_unit = %s,
            jambaC = %s, mosquiteroC = %s, rielC = %s, adaptadorC = %s, traslapeC = %s, zocloC = %s, bolsaF =%s,
            escalonadoF = %s, junquilloF = %s, marcoPE = %s, cercoPE = %s, zocloPE = %s, tubularPEsp = %s, hojaPEsp =%s,
            zocloPEsp = %s, junquilloPEsp = %s WHERE pro_id = %s"""
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
    query = "SELECT dp_comentarios, dp_tipo, dp_ancho, dp_altura FROM detalles_pedido WHERE dp_proy_id = %s"
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

@app.route('/api/historial/borrarProyecto', methods=["POST"])
def borrarProyecto():
    data = request.get_json(silent=True)
    query = 'DELETE FROM proyectos WHERE proy_id = %s'
    conn = mysql.connect()
    cursor = conn.cursor()
    cursor.execute(query, data["id"])
    conn.commit()
    return jsonify(f"Project ID-{data['id']} deleted successfully")


# Rutas de Editar

@app.route('/api/editar/obtenerInfoCliente/<int:id>')
def obtenerInfoCliente(id):
    query = 'SELECT * FROM proyectos WHERE proy_id = %s'
    conn = mysql.connect()
    cursor = conn.cursor()
    cursor.execute(query, id)
    data = cursor.fetchall()
    return jsonify(data)

@app.route('/api/editar/obtenerInfoProductos/<int:id>')
def obtenerInfoProductos(id):
    query = 'SELECT * FROM detalles_pedido WHERE dp_proy_id = %s'
    conn = mysql.connect()
    cursor = conn.cursor()
    cursor.execute(query, id)
    data = cursor.fetchall()
    return jsonify(data)

@app.route('/api/editar/actualizarInfo', methods=['POST'])
def actualizarInfo():
    data = request.get_json(silent=True)
    query = 'UPDATE proyectos SET proy_cliente = %s, proy_domicilio = %s, proy_total = %s WHERE proy_id = %s'
    conn = mysql.connect()
    cursor = conn.cursor()
    cursor.execute(query, (data['name'], data['addr'], data['total'], data['id']))
    conn.commit()

    proyID = data['id']
    for data in data['product']:
        if(data['id'] == None):
            _prodId = None
            if ( data["cristal"] != None):
                _prodId = data['cristal']['pro_id']
            _type = data["type"]
            _perfil = data['perfil']['pro_id']
            _quantity = data["quantity"]
            _width = data["width"]
            _height = data["height"]
            _comments = data["comments"]
            _comments = _comments.replace("\n", "<br>")
            _cost = data["cost"]
            _extra = data["extra"]
            _mosq = data['mosq']
            query = """INSERT INTO detalles_pedido(dp_prod_id, dp_proy_id, dp_costo, dp_tipo, dp_perfil, dp_cantidad, dp_ancho, dp_altura, dp_comentarios, dp_extra, dp_mosq)
                    VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)"""
            cursor.execute(query, (_prodId, proyID, _cost, _type,
                           _perfil, _quantity, _width, _height, _comments, _extra, _mosq))
        else:
            _dpID = data['id']
            _prodId = None
            if ( data["cristal"] != None):
                _prodId = data['cristal']['pro_id']
            _type = data["type"]
            _perfil = data['perfil']['pro_id']
            _quantity = data["quantity"]
            _width = data["width"]
            _height = data["height"]
            _comments = data["comments"]
            _comments = _comments.replace("\n", "<br>")
            _cost = data["cost"]
            _extra = data["extra"]
            _mosq = data['mosq']
            query = """UPDATE detalles_pedido SET dp_prod_id = %s, dp_proy_id = %s, dp_costo = %s, dp_tipo = %s, dp_perfil = %s, 
                    dp_cantidad = %s, dp_ancho = %s, dp_altura = %s, dp_comentarios = %s, dp_extra = %s, dp_mosq = %s WHERE dp_id = %s"""
            cursor.execute(query, (_prodId, proyID, _cost, _type,
                    _perfil, _quantity, _width, _height, _comments, _extra, _mosq, _dpID))

        conn.commit()
    return jsonify("OK")

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
        _prodId = None
        if ( data["cristal"] != None):
            _prodId = data['cristal']['pro_id']
        _type = data["type"]
        _perfil = data['perfil']['pro_id']
        _quantity = data["quantity"]
        _width = data["width"]
        _height = data["height"]
        _comments = data["comments"]
        _comments = _comments.replace("\n", "<br>")
        _cost = data["cost"]
        _extra = data["extra"]
        _mosq = data['mosq']
        query = """INSERT INTO detalles_pedido(dp_prod_id, dp_proy_id, dp_costo, dp_tipo, dp_perfil, dp_cantidad, dp_ancho, dp_altura, dp_comentarios, dp_extra, dp_mosq)
                VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)"""
        cursor.execute(query, (_prodId, id[0]['id'], _cost, _type,
                       _perfil, _quantity, _width, _height, _comments, _extra, _mosq))
        conn.commit()
    return jsonify("OK")


@app.route('/api/cotizacion/obtenerCristales')
def obtenerCristales():
    query = "SELECT p.* FROM productos AS p INNER JOIN categoria AS c ON p.pro_category = c.cat_id AND (c.cat_name = 'Cristales' OR c.cat_name = 'Cristal' OR c.cat_name = 'Vidrio' OR c.cat_name = 'Vidrios')"
    conn = mysql.connect()
    cursor = conn.cursor()
    cursor.execute(query)
    products = cursor.fetchall()
    return jsonify(products)


@app.route('/api/cotizacion/obtenerPerfiles')
def obtenerPerfiles():
    query = "SELECT p.* FROM productos AS p INNER JOIN categoria AS c ON p.pro_category = c.cat_id AND (c.cat_name = 'Perfiles' OR c.cat_name = 'Perfil')"
    conn = mysql.connect()
    cursor = conn.cursor()
    cursor.execute(query)
    products = cursor.fetchall()
    return jsonify(products)


# Rutas PDF

@app.route('/api/pdf/obtenerProyecto/<int:id>')
def obtenerProyecto(id):
    query = "SELECT * FROM proyectos WHERE proy_id = %s"
    conn = mysql.connect()
    cursor = conn.cursor()
    cursor.execute(query, id)
    project = cursor.fetchall()
    project[0]['proy_fecha'] = project[0]['proy_fecha'].strftime("%d/%m/%Y")
    return jsonify(project)

@app.route('/api/pdf/obtenerProductos/<int:id>')
def obtenerProductosPDF(id):
    query = "SELECT * FROM detalles_pedido AS dp LEFT JOIN productos AS p ON dp.dp_prod_id = p.pro_id INNER JOIN productos AS p2 ON dp.dp_perfil = p2.pro_id WHERE dp.dp_proy_id = %s;"
    conn = mysql.connect()
    cursor = conn.cursor()
    cursor.execute(query, id)
    products = cursor.fetchall()
    return jsonify(products)