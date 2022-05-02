import 'dart:async';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:uber_clone_flutter/src/models/addresss.dart';
import 'package:uber_clone_flutter/src/models/car.dart';
import 'package:uber_clone_flutter/src/utils/my_colors.dart';
import 'package:uber_clone_flutter/src/widgets/no_data_widget.dart';

import 'client_car_list_controller.dart';

class ClientCarsListPage extends StatefulWidget {
  const ClientCarsListPage({Key key}) : super(key: key);

  @override
  _ClientCarsListPageState createState() => _ClientCarsListPageState();
}

class _ClientCarsListPageState extends State<ClientCarsListPage> {

  ClientCarListController _con = new ClientCarListController();

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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.primaryColor,
        title: Text('Vehiculos'),
        actions: [
          _iconAdd()
        ],
      ),
      body: Stack(
        children: [
          Positioned(
              top: 0,
              child: _textSelectAddress()
          ),
          Container(
              margin: EdgeInsets.only(top: 50),
              child: _listAddress()
          ),


        ],
      ),


    );

  }

  Widget _noCars() {
    return Column(
      children: [
        Container(
            margin: EdgeInsets.only(top: 30),
            child: NoDataWidget(text: 'No tienes ningún Vehiculo, agrega uno')
        ),
        _buttonNewCar()
      ],
    );
  }


  Widget _buttonNewCar() {
    return Container(
      height: 40,
      child: ElevatedButton(
        onPressed: _con.goToNewCard,
        child: Text(
            'Nuevo Vehiculo'
        ),
        style: ElevatedButton.styleFrom(
            primary: Colors.blue
        ),
      ),
    );
  }

  // Widget _buttonAccept() {
  //
  //   return Container(
  //     height: 50,
  //     width: double.infinity,
  //     margin: EdgeInsets.symmetric(horizontal: 50),
  //     child: ElevatedButton(
  //       onPressed:  _con.createOrder,
  //       child: Text(
  //           'Pagar con tarjeta'
  //
  //       ),
  //       style: ElevatedButton.styleFrom(
  //           shape: RoundedRectangleBorder(
  //               borderRadius: BorderRadius.circular(30)
  //           ),
  //           primary: MyColors.primaryColor
  //       ),
  //     ),
  //   );
  //
  // }

  // Widget _buttonAcceptCash() {
  //
  //   return Container(
  //     height: 50,
  //     width: double.infinity,
  //     margin: EdgeInsets.symmetric( horizontal: 50),
  //     child: ElevatedButton(
  //       onPressed:  _con.createOrderCash,
  //       child: Text(
  //           'Pagar con efectivo'
  //
  //       ),
  //       style: ElevatedButton.styleFrom(
  //           shape: RoundedRectangleBorder(
  //               borderRadius: BorderRadius.circular(30)
  //           ),
  //           primary: MyColors.primaryColor
  //       ),
  //     ),
  //   );
  //
  // }



  // Widget _buttonAcceptCreateCard() {
  //
  //   return Container(
  //     height: 50,
  //     width: double.infinity,
  //     margin: EdgeInsets.symmetric( horizontal: 50),
  //     child: ElevatedButton(
  //       onPressed: (){
  //         _con.cardsStore.length > 2?AwesomeDialog(
  //           context: context,
  //           dialogType: DialogType.ERROR,
  //           animType: AnimType.BOTTOMSLIDE,
  //           title: 'Solo puedes ingresar hasta 3 tarjetas elimina Una.',
  //           desc: '',
  //           btnOkOnPress: () {
  //
  //           },
  //         ).show():Navigator.pushNamed(
  //             context,
  //             'client/payments/create');
  //         ;
  //       },
  //       child: Text(
  //           'Agregar Tarjeta'
  //       ),
  //       style: ElevatedButton.styleFrom(
  //           shape: RoundedRectangleBorder(
  //               borderRadius: BorderRadius.circular(30)
  //           ),
  //           primary: MyColors.primaryColor
  //       ),
  //     ),
  //   );
  //
  //
  // }

//LIST ADRESS
  Widget _listAddress() {
    return FutureBuilder(
        future: _con.getCars(),//GET LIST ADRRES FROM PROVIDER
        builder: (context, AsyncSnapshot<List<Car>> snapshot) {
          if (snapshot.hasData) {//VALIDATED
            if (snapshot.data.length > 0) {//VALIDATED

              return Stack(
                  children: [ListView.builder(
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                      itemCount: snapshot.data?.length ?? 0,
                      itemBuilder: (_, index) {
                        return _radioSelectorAddress(snapshot.data[index], index);
                      }
                  ),
                    // Container(
                    //   margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.450),
                    //
                    //   child: _buttonAcceptCreateCard(),
                    // ),
                    // Container(
                    //   margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.550),
                    //
                    //   child: _buttonAccept(),
                    // ),
                    // Container(
                    //   margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.650),
                    //
                    //   child: _buttonAcceptCash(),
                    // ),
                  ]
              );


            }
            else {
              return _noCars();
            }

          }
          else {
            return _noCars();
          }

        }

    );

  }

  Widget _radioSelectorAddress(Car cars, int index) {
    String colorCarBd =cars?.color ?? '';
    String colorWHex = "0xFF${colorCarBd}";
    int colorCar = int.parse(colorWHex);
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Row(

            children: [

              Radio(
                value: index,
                groupValue: _con.radioValue,
                onChanged:_con.handleRadioValueChange,

              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                    CircleAvatar(
                    backgroundImage: cars.image != null
                        ? NetworkImage(cars.image)
                        : AssetImage('assets/img/placac.png'),
                    radius: 40,
                    backgroundColor: Colors.grey[200],
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8,bottom: 5),
                    child: Text(
                      cars?.marca ?? '',
                      style: TextStyle(
                          color: MyColors.colorTitulosSegundos,
                          fontSize: 13,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8,bottom: 5),
                    child: Text(
                      cars?.modelo ?? '',
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                  )
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8,bottom: 5),
                    child: Text(
                    'AÑO',
                      style: TextStyle(
                          color: MyColors.colorTitulosSegundos,
                          fontSize: 13,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8,bottom: 5),
                    child: Text(
                      cars?.year ?? '',
                      style: TextStyle(
                          fontSize: 12,

                      ),
                    ),
                  ),

                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top:0, left: 8,bottom: 5),
                    child: Text(
                      'COLOR',
                      style: TextStyle(
                          color: MyColors.colorTitulosSegundos,
                          fontSize: 13,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 18,bottom: 5),
                    child: CircleAvatar(
                      backgroundImage: cars.color != null
                          ? AssetImage('')
                          : AssetImage('assets/img/car_color.png'),
                      radius: 7,
                      backgroundColor: Color(colorCar),
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top:0, left: 8,bottom: 5),
                    child: Text(
                      'PLACA',
                      style: TextStyle(
                          color: MyColors.colorTitulosSegundos,
                          fontSize: 13,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8,bottom: 5),
                    child: Text(
                      cars?.placa ?? '',
                      style: TextStyle(
                          fontSize: 12,

                      ),
                    ),
                  ),
                ],
              ),

            ],
          ),
          Divider(
            color: Colors.grey[400],
          )
        ],
      ),
    );
  }

  Widget _textSelectAddress() {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.symmetric(horizontal: 40, vertical: 30),
      child: Text(
        'Vehiculos en tu lista ',
        style: TextStyle(
            fontSize: 19,
            fontWeight: FontWeight.bold
        ),
      ),
    );
  }


  Widget _iconAdd() {
    return IconButton(
        onPressed: _con.goToNewCard,
        icon: Icon(Icons.add, color: Colors.white)
    );
  }

  void refresh() {
    setState(() {

    });

  }
}
