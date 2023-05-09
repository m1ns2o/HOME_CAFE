import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:async/async.dart';

class main_view extends StatefulWidget {
  const main_view({Key? key}) : super(key: key);

  @override
  State<main_view> createState() => _main_viewState();
}

class _main_viewState extends State<main_view> {
  Future<Map> get_count() async {
    Map data = new Map();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    data['tira'] = prefs.getInt('티라미수') ?? 0;
    data['oreo'] = prefs.getInt('오레오') ?? 0;
    data['americano'] = prefs.getInt('아메리카노') ?? 0;
    data['jori'] = prefs.getInt('조리퐁라떼') ?? 0;
    data['ogok'] = prefs.getInt('오곡라떼') ?? 0;
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(40),
        child: FutureBuilder<Map>(
          future: get_count(),
          builder: (context, AsyncSnapshot<Map> snapshot) {
            if (snapshot.hasError) {
              return Text("Error: ${snapshot.error}");
            } else if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return Column(
                children: [
                  Expanded(
                      child: menu_container(
                    menu: "티라미수",
                    cost: 3500,
                    count: snapshot.data!['tira'],
                  )),
                  Expanded(
                      child: menu_container(
                    menu: "오레오",
                    cost: 3500,
                    count: snapshot.data!['oreo'],
                  )),
                  Expanded(
                      child: menu_container(
                    menu: "아메리카노",
                    cost: 3500,
                    count: snapshot.data!['americano'],
                  )),
                  Expanded(
                      child: menu_container(
                    menu: "조리퐁라떼",
                    cost: 3500,
                    count: snapshot.data!['jori'],
                  )),
                  Expanded(
                      child: menu_container(
                    menu: "오곡라떼",
                    cost: 3500,
                    count: snapshot.data!['ogok'],
                  )),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}

class menu_container extends StatefulWidget {
  menu_container(
      {Key? key, required this.menu, required this.cost, required this.count})
      : super(key: key);
  final String menu;
  final int cost;
  int count;
  @override
  State<menu_container> createState() => _menu_containerState();
}

class _menu_containerState extends State<menu_container> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      // child: Expanded(
      child: Container(
        height: 100,
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: const [
              BoxShadow(
                blurRadius: 1,
                offset: Offset(0, 1),
                color: Colors.grey,
              ),
            ],
            borderRadius: BorderRadius.circular(15)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(widget.menu),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Color(0xFF26C6DA)),
                    onPressed: () async {
                      final SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      widget.count--;
                      await prefs.setInt(widget.menu, widget.count);
                      setState(() {});
                    },
                    child: Icon(Icons.remove)),
                Text('${widget.count}'),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Color(0xFF26C6DA)),
                    onPressed: () async {
                      final SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      widget.count++;
                      await prefs.setInt(widget.menu, widget.count);
                      setState(() {});
                    },
                    child: Icon(Icons.add)),
              ],
            ),
            Text('${widget.count * widget.cost}'),
          ],
        ),
      ),
      // ),
    );
  }
}

class menu_data {
  final String menu;
  final int cost;
  final int count;
  menu_data(this.menu, this.cost, this.count);
}
