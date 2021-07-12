import 'package:dio/dio.dart';

class StarwarsRepo {
  Future<List<People>> fetchPeople(int page) async {
    print("we're in fetchPeople");
    var response = await Dio().get('https://swapi.dev/api/people/?page=$page');
    List<People> listPeople = People.toList(response.data['results']);
    return listPeople;
  }
}

class People {
  final String id;
  final String name;
  final String height;
  final String mass;
  final String gender;
  

  People(this.id, this.name, this.height, this.mass, this.gender);

  factory People.fromJson(Map<String, dynamic> json) {
    print("factory works");
    var id = json["url"].toString().substring(28).split('/')[1];
    print(id);

    return People(id, json["name"], json["height"], json["mass"], json["gender"]);
  }

  static List<People> toList(List<dynamic> list) {
    print("toList works");
    return list.map((e) => People.fromJson(e)).toList();
  }
}
