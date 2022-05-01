import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:progress_dialog/progress_dialog.dart';
import 'package:uber_clone_flutter/src/api/environment.dart';
import 'package:uber_clone_flutter/src/models/category.dart';
import 'package:uber_clone_flutter/src/models/response_api.dart';
import 'package:uber_clone_flutter/src/models/user.dart';
import 'package:uber_clone_flutter/src/utils/my_snackbar.dart';
import 'package:uber_clone_flutter/src/utils/shared_pref.dart';

import '../models/car.dart';


class CarProvider {

  String _url = Environment.API_DELIVERY;
  String _api = '/api/cars';
  BuildContext context;
  User sessionUser;


  Future init(BuildContext context, User sessionUser) {
    this.context = context;
    this.sessionUser = sessionUser;

  }


  Future<ResponseApi> create(Car car) async {
    try {
      //FINAL URL
      Uri url = Uri.http(_url, '$_api/create');
      //DATA FROM JSON OBJECT
      String bodyParams = json.encode(car);
      print("Body Param OBjeto mycar : ${bodyParams}");
      //SEND HEADERS
      Map<String, String> headers = {
        'Content-type': 'application/json'
      };
      //SEND PETTITION
      final res = await http.post(url, headers: headers, body: bodyParams);
      //VALIDATED SESSION TOKEN
      if (res.statusCode == 401) {
        MySnackbar.show(context, 'Sesion expirada');
        new SharedPref().logout(context, sessionUser.id);
      }

      //GET RESPONSE DATA
      final data = json.decode(res.body);
      //VALIDATED RESPONSE
      ResponseApi responseApi = ResponseApi.fromJson(data);
      return responseApi;
    }
    catch(e) {
      print('Error: $e');
      return null;
    }
  }

}