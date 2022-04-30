import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:uber_clone_flutter/src/pages/client/create/client_car_create_controller.dart';
import 'package:uber_clone_flutter/src/pages/restaurant/categories/create/restaurant_categories_create_controller.dart';
import 'package:uber_clone_flutter/src/utils/my_colors.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class CLientCarCreatePage extends StatefulWidget {
  const CLientCarCreatePage({Key key}) : super(key: key);

  @override
  _CLientCarCreatePageState createState() => _CLientCarCreatePageState();
}

class _CLientCarCreatePageState extends State<CLientCarCreatePage> {

  ClientCarCreateController _con = new ClientCarCreateController();
  Color currentColor = Colors.limeAccent;

  String dropdownValue = 'Año';
  void changeColor(Color color) => setState(() => currentColor = color);
  @override
  void initState() {


    // TODO: implement initState
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _con.init(context, refresh);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [Colors.blue.shade900, Colors.cyan.shade900])
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text('Agrega un auto'),
        ),
        body: Column(
          children: [
            SizedBox(height: 10),
            _imageUser(),
            SizedBox(height: 10),
            _marcaModelo(),
            SizedBox(height: 10),
            _yearDescripcion(),
            SizedBox(height: 10),
            _placa(),
            SizedBox(height: 10),
            _changeColor(),
            SizedBox(height: 20),
            _imageCar()
          ],

        ),


        bottomNavigationBar: _buttonCreate(),
      ),
    );
  }

  Widget _marcaModelo(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
         child: _textFieldName(),
        ),
        Expanded(
          child: _textFieldDescription(),
        ),

      ],
    );
  }
  Widget _yearDescripcion(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
            child: _textFieldYear()
        )
      ],
    );
  }

  Widget _placa(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
            child: _textFieldPlaca()
        )
      ],
    );
  }

  Widget _changeColor(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
            child: _color()
        )
      ],
    );
  }

  Widget _color(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        RaisedButton(
            elevation: 3.0,
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    titlePadding: const EdgeInsets.all(0.0),
                    contentPadding: const EdgeInsets.all(0.0),
                    content: SingleChildScrollView(
                      child: ColorPicker(
                        pickerColor: currentColor,
                        onColorChanged: changeColor,
                        colorPickerWidth: 300.0,
                        pickerAreaHeightPercent: 0.7,
                        enableAlpha: true,
                        displayThumbColor: true,
                        showLabel: true,
                        paletteType: PaletteType.hsv,
                        pickerAreaBorderRadius: const BorderRadius.only(
                          topLeft: const Radius.circular(2.0),
                          topRight: const Radius.circular(2.0),
                        ),
                      ),
                    ),
                  );
                },
              );
            },
            child: const Text('Selecciona color'),
            color: MyColors.primaryColor,
            textColor: Colors.white
        ),
      ],
    );
  }

  Widget _imageUser() {
    return GestureDetector(
      onTap: _con.showAlertDialog,
      child: CircleAvatar(
        backgroundImage: _con.imageFile != null
            ? FileImage(_con.imageFile)
            : AssetImage('assets/img/user_profile_2.png'),
        radius: 60,
        backgroundColor: Colors.grey[200],
      ),
    );
  }
  Widget _imageCar() {
    return GestureDetector(
      onTap: (){},
      child: CircleAvatar(
        backgroundImage:
        AssetImage('assets/img/car_color.png'),
        radius: 50,
          backgroundColor: currentColor,
      ),
    );
  }

  Widget _textFieldName() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30)
      ),
      child: TextField(
        controller: _con.nameController,
        decoration: InputDecoration(
            hintText: 'Marca',
            border: InputBorder.none,
            contentPadding: EdgeInsets.all(15),
            hintStyle: TextStyle(
                color: MyColors.primaryColorDark
            ),
            suffixIcon: Icon(
              Icons.list_alt,
              color: MyColors.primaryColor,
            )
        ),
      ),
    );
  }

  Widget _textFieldYear() {

    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: 195),
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30)
      ),
      child:DropdownButton<String>(
        isExpanded: true,
        value: dropdownValue,
        alignment: Alignment.center,
        icon: const Icon(Icons.arrow_downward),
        elevation: 16,
        style: const TextStyle(

            color: Colors.black,
            fontSize: 17,
            fontWeight: FontWeight.bold),
        underline: Container(

          height: 2,
          color: Colors.deepPurpleAccent,
        ),
        onChanged: (String newValue) {
          setState(() {
            dropdownValue = newValue;
          });
        },
        items: <String>['Año', '2022', '2021', '2020']
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      )

        );
  }
  Widget _textFieldPlaca() {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: 180),
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30)
      ),
      child: TextField(
        controller: _con.nameController,
        decoration: InputDecoration(
            hintText: 'Placa',

            border: InputBorder.none,
            contentPadding: EdgeInsets.all(15),
            hintStyle: TextStyle(
                color: MyColors.primaryColorDark
            ),
            suffixIcon: Icon(
              Icons.list_alt,
              color: MyColors.primaryColor,
            )
        ),
      ),
    );
  }

  // Widget _textFieldDescription() {
  //   return Container(
  //     margin: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
  //     padding: EdgeInsets.all(10),
  //     decoration: BoxDecoration(
  //         color: MyColors.primaryOpacityColor,
  //         borderRadius: BorderRadius.circular(30)
  //     ),
  //     child: TextField(
  //       controller: _con.descriptionController,
  //       maxLines: 3,
  //       maxLength: 255,
  //       decoration: InputDecoration(
  //           hintText: 'Descripcion de la categoria',
  //           border: InputBorder.none,
  //           contentPadding: EdgeInsets.all(15),
  //           hintStyle: TextStyle(
  //               color: MyColors.primaryColorDark
  //           ),
  //           suffixIcon: Icon(
  //             Icons.description,
  //             color: MyColors.primaryColor,
  //           ),
  //       ),
  //     ),
  //   );
  // }

  Widget _textFieldDescription() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30)
      ),
      child: TextField(
        controller: _con.nameController,
        decoration: InputDecoration(
            hintText: 'Modelo',
            border: InputBorder.none,
            contentPadding: EdgeInsets.all(15),
            hintStyle: TextStyle(
                color: MyColors.primaryColorDark
            ),
            suffixIcon: Icon(
              Icons.list_alt,
              color: MyColors.primaryColor,
            )
        ),
      ),
    );
  }


  Widget _buttonCreate() {
    return Container(
      height:70,
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 135, vertical: 40),
      child: ElevatedButton(
        onPressed: _con.createCategory,
        child: Text('Agregar Auto',
        style: TextStyle(
          fontSize: 17.0,
          color: Colors.white
        ),),
        style: ElevatedButton.styleFrom(

          onPrimary: Colors.black,
            primary: MyColors.primaryColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30)
            ),
            padding: EdgeInsets.symmetric(vertical: 5),

        ),
      ),
    );
  }

  void refresh() {
    setState(() {});
  }

}
