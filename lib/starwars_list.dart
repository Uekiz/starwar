import 'package:flutter/material.dart';
import 'package:starwar/starwars_repo.dart';

class StarwarsList extends StatefulWidget {
  StarwarsList({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _StarwarsListState();
  }
}

class _StarwarsListState extends State<StarwarsList> {

  final StarwarsRepo repo;
  late int page;
  late List<People> people;

  _StarwarsListState() : repo = StarwarsRepo();

  @override
  void initState() {
    super.initState();
    page = 1;
    people = [];
    fetchPeople();
  }

  @override
  Widget build(BuildContext context) {
    return Text("hello world");
  }
}

Future<void> fetchPeople() async {
  
}
