import 'package:flutter/material.dart';

class InputPage extends StatefulWidget {
  @override
  _InputPageState createState() => _InputPageState();
}
  
class _InputPageState extends State<InputPage> {

String _nombre = '';
String _email = '';
String _password = '';
String _fecha = '';
String _equipoSeleccionado = 'Boca';

List _equipos = ['Boca','River','Racing','Independiente','San Lorenzo'];

TextEditingController _inputFieldDateController = new TextEditingController();

  @override 
  Widget build(BuildContext context ) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inputs de texto'),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
        children: [
          _crearInput(),
          Divider(),
          _crearEmail(),
          Divider(),
          _crearPassword(),
          Divider(),
          _crearFecha(context),
          Divider(),
          _crearDropDown(),
          Divider(),
          _crearPersona(),
         
        ],
      ),
      );
  }

  Widget _crearInput() {
    return TextField(
      //autofocus: true,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration (
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0)
        ),
        counter: Text('Letras ${ _nombre.length }'),
        hintText: "Nombre de la persona",
        labelText: "Nombre",
        helperText: "Sólo el nombre",
        suffixIcon: Icon (Icons.accessibility),
        icon: Icon (Icons.account_circle),
      ),
      onChanged: (valor) {
        setState((){
          _nombre = valor;
        });
      }
    );
  }

  Widget _crearEmail() {
    return TextField(
      //autofocus: true,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration (
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0)
        ),
        hintText: "Email",
        labelText: "Email",
        suffixIcon: Icon (Icons.alternate_email),
        icon: Icon (Icons.email),
      ),
      onChanged: (valor) =>
        setState((){
          _email = valor;
        })
    );
  }

    Widget _crearPassword() {
    return TextField(
      //autofocus: true,
      obscureText: true,
      decoration: InputDecoration (
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0)
        ),
        hintText: "Password",
        labelText: "Password",
        suffixIcon: Icon (Icons.lock_open),
        icon: Icon (Icons.lock),
      ),
      onChanged: (valor) =>
        setState((){
          _password = valor;
        })
    );
  }

    Widget _crearPersona() {
    return ListTile(
      title: Text('Nombre es: $_nombre'),
      subtitle: Text('Email: $_email'),
      trailing: Text(_equipoSeleccionado),
    );
  }


  Widget _crearFecha(BuildContext context){
    return TextField(
      enableInteractiveSelection: false,
      controller: _inputFieldDateController,
      decoration: InputDecoration (
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0)
        ),
        hintText: "Fecha de nacimiento",
        labelText: "Fecha de nacimiento",
        suffixIcon: Icon (Icons.perm_contact_calendar),
        icon: Icon (Icons.calendar_today),
      ),
      onTap: () {

        FocusScope.of(context).requestFocus(new FocusNode());
        _selectDate(context);

      }
    );
  }

  _selectDate(BuildContext context) async {
    DateTime elegida = await showDatePicker(
      context: context,
      initialDate: new DateTime.now(),
      firstDate: new DateTime(2021),
      lastDate: new DateTime(2023),
      locale: Locale('es','ES')
      );

    if(elegida != null )
    {
      setState(() {
        _fecha = elegida.toString();
        _inputFieldDateController.text = _fecha;
      });
    }
  }


  List<DropdownMenuItem<String>> getOpcionesDropdown () {
    List<DropdownMenuItem<String>> lista = new List();

    _equipos.forEach( (equipo) {
      lista.add(DropdownMenuItem(
        child: Text(equipo),
        value: equipo
      ));
    });

    return lista;
  }

  Widget _crearDropDown(){

    return Row(
      children: <Widget> [
        Icon(Icons.select_all),
        SizedBox(width: 30.0),
        Expanded(child: 
          DropdownButton(
            value:_equipoSeleccionado,
            items: getOpcionesDropdown(),
            onChanged: (opcion) {
            setState(() {
              _equipoSeleccionado = opcion;
            });
          },
        ), 
      )
    ],

    );
  
  }



}