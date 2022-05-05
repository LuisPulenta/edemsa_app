import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:edemsa_app/components/loader_component.dart';
import 'package:edemsa_app/helpers/api_helper.dart';
import 'package:edemsa_app/models/obra.dart';
import 'package:edemsa_app/models/response.dart';
import 'package:edemsa_app/models/user.dart';

class ReclamoAgregarScreen extends StatefulWidget {
  final User user;
  ReclamoAgregarScreen({required this.user});

  @override
  _ReclamoAgregarScreenState createState() => _ReclamoAgregarScreenState();
}

class _ReclamoAgregarScreenState extends State<ReclamoAgregarScreen> {
  bool _showLoader = false;

  int _obraId = 0;
  String _obraIdError = '';
  bool _obraIdShowError = false;
  List<Obra> _obras = [];

  String _zona = '';
  String _zonaError = '';
  bool _zonaShowError = false;
  TextEditingController _zonaController = TextEditingController();

  String _direccion = '';
  String _direccionError = '';
  bool _direccionShowError = false;
  TextEditingController _direccionController = TextEditingController();

  String _numero = '';
  String _numeroError = '';
  bool _numeroShowError = false;
  TextEditingController _numeroController = TextEditingController();

  String _asreclamo = '';
  String _asreclamoError = '';
  bool _asreclamoShowError = false;
  TextEditingController _asreclamoController = TextEditingController();

  String _descripcion = '';
  String _descripcionError = '';
  bool _descripcionShowError = false;
  TextEditingController _descripcionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Agregar Nuevo Reclamo'),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: <Widget>[
                _showObra(),
                _showZona(),
                _showDireccion(),
                _showNumero(),
                _showASReclamo(),
                _showDescripcion(),
                SizedBox(
                  height: 30,
                ),
                _showButton(),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
          _showLoader
              ? LoaderComponent(
                  text: 'Por favor espere...',
                )
              : Container(),
        ],
      ),
    );
  }

  Widget _showObra() {
    return Container(
      padding: EdgeInsets.all(10),
      child: _obras.length == 0
          ? Text('Cargando obras...')
          : DropdownButtonFormField(
              items: _getComboObras(),
              value: _obraId,
              onChanged: (option) {
                setState(() {
                  _obraId = option as int;
                });
              },
              decoration: InputDecoration(
                hintText: 'Seleccione una obra...',
                labelText: 'Obra',
                errorText: _obraIdShowError ? _obraIdError : null,
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              )),
    );
  }

  List<DropdownMenuItem<int>> _getComboObras() {
    List<DropdownMenuItem<int>> list = [];
    list.add(DropdownMenuItem(
      child: Text('Seleccione una Obra...'),
      value: 0,
    ));

    _obras.forEach((obra) {
      list.add(DropdownMenuItem(
        child: Text(obra.nombreObra),
        value: obra.nroObra,
      ));
    });

    return list;
  }

  Widget _showZona() {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextField(
        controller: _zonaController,
        decoration: InputDecoration(
            hintText: 'Ingresa Zona...',
            labelText: 'Zona',
            errorText: _zonaShowError ? _zonaError : null,
            suffixIcon: Icon(Icons.map),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
        onChanged: (value) {
          _zona = value;
        },
      ),
    );
  }

  Widget _showDireccion() {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextField(
        controller: _direccionController,
        decoration: InputDecoration(
            hintText: 'Ingresa Dirección...',
            labelText: 'Dirección',
            errorText: _direccionShowError ? _direccionError : null,
            suffixIcon: Icon(Icons.home),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
        onChanged: (value) {
          _direccion = value;
        },
      ),
    );
  }

  Widget _showNumero() {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextField(
        controller: _numeroController,
        decoration: InputDecoration(
            hintText: 'Ingresa Número...',
            labelText: 'Número',
            errorText: _numeroShowError ? _numeroError : null,
            suffixIcon: Icon(Icons.tag),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
        onChanged: (value) {
          _numero = value;
        },
      ),
    );
  }

  Widget _showASReclamo() {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextField(
        controller: _asreclamoController,
        decoration: InputDecoration(
            hintText: 'Ingresa AS/N° Reclamo...',
            labelText: 'AS/N° Reclamo',
            errorText: _asreclamoShowError ? _asreclamoError : null,
            suffixIcon: Icon(Icons.pin),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
        onChanged: (value) {
          _asreclamo = value;
        },
      ),
    );
  }

  Widget _showDescripcion() {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextField(
        controller: _descripcionController,
        decoration: InputDecoration(
            hintText: 'Ingresa Descripción / Nombre...',
            labelText: 'Descripción / Nombre',
            errorText: _descripcionShowError ? _descripcionError : null,
            suffixIcon: Icon(Icons.notes),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
        onChanged: (value) {
          _descripcion = value;
        },
      ),
    );
  }

  Widget _showButton() {
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Expanded(
            child: ElevatedButton(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.save),
                  SizedBox(
                    width: 20,
                  ),
                  Text('Guardar cambios'),
                ],
              ),
              style: ElevatedButton.styleFrom(
                primary: Color(0xff4ec9f5),
                minimumSize: Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              onPressed: _save,
            ),
          ),
        ],
      ),
    );
  }

  _save() {
    if (!validateFields()) {
      return;
    }
    _addRecord();
  }

  void _loadData() async {
    await _getObras();
  }

  Future<Null> _getObras() async {
    setState(() {
      _showLoader = true;
    });

    var connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult == ConnectivityResult.none) {
      setState(() {
        _showLoader = false;
      });
      await showAlertDialog(
          context: context,
          title: 'Error',
          message: 'Verifica que estés conectado a Internet',
          actions: <AlertDialogAction>[
            AlertDialogAction(key: null, label: 'Aceptar'),
          ]);
      return;
    }

    Response response = Response(isSuccess: false);

    if (widget.user.modulo == 'Rowing') {
      response = await ApiHelper.getObrasReclamosRowing();
    } else if (widget.user.modulo == 'Energia') {
      response = await ApiHelper.getObrasReclamosEnergia();
    } else if (widget.user.modulo == 'ObrasTasa') {
      response = await ApiHelper.getObrasReclamosTasa();
    } else {
      setState(() {
        _showLoader = false;
      });
      return;
    }

    setState(() {
      _showLoader = false;
    });

    if (!response.isSuccess) {
      await showAlertDialog(
          context: context,
          title: 'Error',
          message: response.message,
          actions: <AlertDialogAction>[
            AlertDialogAction(key: null, label: 'Aceptar'),
          ]);
      return;
    }

    setState(() {
      _obras = response.result;
    });
  }

  bool validateFields() {
    bool isValid = true;

    if (_obraId == 0) {
      isValid = false;
      _obraIdShowError = true;
      _obraIdError = 'Debes seleccionar una Obra';
    } else {
      _obraIdShowError = false;
    }

    if (_zona.isEmpty) {
      isValid = false;
      _zonaShowError = true;
      _zonaError = 'Debes ingresar una Zona';
    } else {
      _zonaShowError = false;
    }

    if (_direccion.isEmpty) {
      isValid = false;
      _direccionShowError = true;
      _direccionError = 'Debes ingresar una Dirección';
    } else {
      _direccionShowError = false;
    }

    if (_numero.isEmpty) {
      isValid = false;
      _numeroShowError = true;
      _numeroError = 'Debes ingresar un Número';
    } else {
      _numeroShowError = false;
    }

    if (_asreclamo.isEmpty) {
      isValid = false;
      _asreclamoShowError = true;
      _asreclamoError = 'Debes ingresar un AS/N° Reclamo';
    } else {
      _asreclamoShowError = false;
    }

    if (_descripcion.isEmpty) {
      isValid = false;
      _descripcionShowError = true;
      _descripcionError = 'Debes ingresar una Descripción';
    } else {
      _descripcionShowError = false;
    }

    setState(() {});

    return isValid;
  }

  void _addRecord() async {
    setState(() {
      _showLoader = true;
    });

    var connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult == ConnectivityResult.none) {
      setState(() {
        _showLoader = false;
      });
      await showAlertDialog(
          context: context,
          title: 'Error',
          message: 'Verifica que estés conectado a Internet',
          actions: <AlertDialogAction>[
            AlertDialogAction(key: null, label: 'Aceptar'),
          ]);
      return;
    }

    Map<String, dynamic> request = {
      //'nroregistro': _ticket.nroregistro,
      'nroobra': _obraId,
      'asticket': _asreclamo,
      'cliente': "",
      'direccion': _direccion,
      'numeracion': _numero,
      'localidad': "",
      'telefono': "",
      'tipoImput': "Reclamos",
      'certificado': "No",
      'serieMedidorColocado': "",
      'precinto': "",
      'cajaDAE': "",
      'observaciones': "",
      'lindero1': "",
      'lindero2': "",
      'zona': _zona,
      'terminal': _descripcion,
      'subcontratista': widget.user.codigogrupo,
      'causanteC': widget.user.codigocausante,
      'grxx': "",
      'gryy': "",
      'idUsrIn': widget.user.idUsuario,
      'observacionAdicional': "App",
      'fechaCarga': DateTime.now().toString(),
      'riesgoElectrico': "No",
      'fechaasignacion': DateTime.now().toString(),
      'mes': DateTime.now().month,
    };

    Response response =
        await ApiHelper.post('/api/ObrasPostes/PostReclamo', request);

    setState(() {
      _showLoader = false;
    });

    if (!response.isSuccess) {
      await showAlertDialog(
          context: context,
          title: 'Error',
          message: response.message,
          actions: <AlertDialogAction>[
            AlertDialogAction(key: null, label: 'Aceptar'),
          ]);
      return;
    }
    Navigator.pop(context, 'yes');
  }
}
