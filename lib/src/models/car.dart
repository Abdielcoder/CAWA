


import 'dart:convert';

Car categoryFromJson(String str) => Car.fromJson(json.decode(str));

String categoryToJson(Car data) => json.encode(data.toJson());

class Car{

  String id;
  String marca;
  String modelo;
  String year;
  String placa;
  String color;
  List<Car> toList = [];

  Car({
    this.id,
    this.marca,
    this.modelo,
    this.year,
    this.placa,
    this.color
  });

  factory Car.fromJson(Map<String, dynamic> json) => Car(
    id: json["id"] is int ? json["id"].toString() : json['id'],
    marca: json["name"],
    modelo: json["modelo"],
    year: json["year"],
    placa: json["placa"],
    color: json["color"],
  );

  Car.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;
    jsonList.forEach((item) {
      Car category = Car.fromJson(item);
      toList.add(category);
    });
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": marca,
    "modelo": modelo,
    "year": year,
    "placa": placa,
    "color": color,
  };
}