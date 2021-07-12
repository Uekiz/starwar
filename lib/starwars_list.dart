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
    fetchPeopleFromRepo();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: people.length,
        itemBuilder: (context, index) {
          final People person = people[index];
          return Card(
            child: Column(
              children: <Widget>[
                // Image.network(
                //   person.thumbnailUrl,
                //   fit: BoxFit.fitWidth,
                //   width: double.infinity,
                //   height: 160,
                // ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(person.name,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                ),
              ],
            ),
          );
        });
  }

  Future<void> fetchPeopleFromRepo() async {
    print("we're in fetchPeopleFromRepo");
    var fetchedPeople = await repo.fetchPeople(this.page);
    this.page = this.page + 1;
    people.addAll(fetchedPeople);
    print(people.length);
    setState(() {});
  }
}
