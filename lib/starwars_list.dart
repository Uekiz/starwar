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
  late bool _error;
  late bool _loading;
  late bool _hasMore;
  final int _nextPageThreshold = 5;

  _StarwarsListState() : repo = StarwarsRepo();

  @override
  void initState() {
    super.initState();
    page = 1;
    people = [];
    fetchPeopleFromRepo();
    _hasMore = true;
    _error = false;
    _loading = true;
  }

  @override
  Widget build(BuildContext context) {
    if (people.isEmpty) {
      if (_loading) {
        return Center(
            child: Padding(
          padding: const EdgeInsets.all(8),
          child: CircularProgressIndicator(),
        ));
      } else if (_error) {
        return Center(
            child: InkWell(
          onTap: () {
            setState(() {
              _loading = true;
              _error = false;
              fetchPeopleFromRepo();
            });
          },
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Text("Error while loading photos, tap to try agin"),
          ),
        ));
      }
    } else {
      return ListView.builder(
          itemCount: people.length + (_hasMore ? 1 : 0),
          itemBuilder: (context, index) {
            if (index == people.length - _nextPageThreshold) {
              print("threshold");
              fetchPeopleFromRepo();
            }
            if (index == people.length) {
              print("length");
              if (_error) {
                return Center(
                    child: InkWell(
                  onTap: () {
                    setState(() {
                      _loading = true;
                      _error = false;
                      fetchPeopleFromRepo();
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text("Error while loading photos, tap to try agin"),
                  ),
                ));
              } else if (people.length == 82) {
                return Container();
              } else {
                return Center(
                    child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: CircularProgressIndicator(),
                ));
              }
            }
            final People person = people[index];
            return Card(
              child: Column(
                children: <Widget>[
                  ListTile(
                    leading: CircleAvatar(
                      child: Image.network(
                        'https://starwars-visualguide.com/assets/img/characters/${person.id}.jpg',
                        fit: BoxFit.fitWidth,
                        width: double.infinity,
                        height: 160,
                      ),
                    ),
                    title: Text("${person.name}",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 24)),
                    subtitle: Row(
                      children: [
                        Text("gender : ${person.gender}   ",
                            style: TextStyle(
                                fontWeight: FontWeight.normal, fontSize: 16)),
                        Text("height : ${person.height}   ",
                            style: TextStyle(
                                fontWeight: FontWeight.normal, fontSize: 16)),
                        Text("mass : ${person.mass}   ",
                            style: TextStyle(
                                fontWeight: FontWeight.normal, fontSize: 16)),
                      ],
                    ),
                  )
                ],
              ),
            );
          });
    }
    return Container();
  }

  Future<void> fetchPeopleFromRepo() async {
    print("we're in fetchPeopleFromRepo");
    if (this.page <= 9) {
      var fetchedPeople = await repo.fetchPeople(this.page);
      this.page = this.page + 1;
      people.addAll(fetchedPeople);
      // print(people.length);
      setState(() {});
    }
  }
}
