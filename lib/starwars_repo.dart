import 'package:dio/dio.dart';

class StarwarsRepo {
  Future<List<People>> fetchPeople(int page ) async {
    var response = await Dio().get('https://swapi.dev/api/people/?page=$page');
    List<People> listPeople = People.toList(response.data['results']);
    return listPeople;
  }
}

class People {
  final String name;
  final String height;
  final String mass;
  final String gender;

  People(this.name, this.height, this.mass, this.gender);

  factory People.fromJson(Map<String, dynamic> json) {
    return People(json["name"], json["height"], json["mass"], json["gender"]);
  }

  static List<People> toList(List<dynamic> list) {
    return list.map((e) => People.fromJson(e)).toList();
  }
}
