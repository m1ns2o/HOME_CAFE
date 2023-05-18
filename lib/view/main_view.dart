import 'dart:math';

import 'package:flutter/material.dart';
import 'package:knue_home_cafe/const/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:async/async.dart';

class main_view extends StatefulWidget {
  const main_view({Key? key}) : super(key: key);

  @override
  State<main_view> createState() => _main_viewState();
}

class _main_viewState extends State<main_view> {
  Future<Map> get_count() async {
    Map data = Map();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    data['strawberry'] = prefs.getInt('생딸기주스') ?? 0;
    data['icedtea'] = prefs.getInt('아이스티') ?? 0;
    data['americano'] = prefs.getInt('아메리카노') ?? 0;
    data['jori'] = prefs.getInt('조리퐁셰이크') ?? 0;
    data['cookie'] = prefs.getInt('쿠키') ?? 0;
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BACKGROUND_COLOR,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0),
          child: Column(
            children: [
              const SizedBox(
                height: 70,
              ),
              const FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  '가정과 카페',
                  style: TextStyle(
                    color: FOREGROUND_COLOR,
                    fontSize: 85,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 15.0,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Image.asset(
                'asset/image/coffee.png',
                height: MediaQuery.of(context).size.width / 4 * 1,
              ),
              const SizedBox(
                height: 30,
              ),
              const Divider(
                thickness: 3,
                color: FOREGROUND_COLOR,
              ),
              FutureBuilder<Map>(
                future: get_count(),
                builder: (context, AsyncSnapshot<Map> snapshot) {
                  if (snapshot.hasError) {
                    return Text("Error: ${snapshot.error}");
                  } else if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return Column(
                      children: [
                        menu_container(
                          menu: "생딸기주스",
                          cost: 3500,
                          count: snapshot.data!['strawberry'],
                        ),
                        menu_container(
                          menu: "아이스티",
                          cost: 2000,
                          count: snapshot.data!['icedtea'],
                        ),
                        menu_container(
                          menu: "아메리카노",
                          cost: 2000,
                          count: snapshot.data!['americano'],
                        ),
                        menu_container(
                          menu: "조리퐁셰이크",
                          cost: 3500,
                          count: snapshot.data!['jori'],
                        ),
                        menu_container(
                          menu: "쿠키",
                          cost: 3000,
                          count: snapshot.data!['cookie'],
                        ),
                      ],
                    );
                  }
                },
              ),
            ],
          ),
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
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: SizedBox(
        height: 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            menuText(text: widget.menu),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    TextButton(
                        style: TextButton.styleFrom(foregroundColor: SUB_COLOR),
                        onPressed: () async {
                          final SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          if (widget.count > 0) {
                            widget.count--;
                          }
                          await prefs.setInt(widget.menu, widget.count);
                          setState(() {});
                        },
                        child: const Icon(Icons.remove)),
                    SizedBox(
                      width: 30,
                      child: customText(
                        text: '${widget.count}',
                        color: SUB_COLOR,
                      ),
                    ),
                    TextButton(
                        // style: ElevatedButton.styleFrom(
                        //     backgroundColor: SUB_COLOR,
                        //     foregroundColor: const Color(0xFF26C6DA)),
                        style: TextButton.styleFrom(foregroundColor: SUB_COLOR),
                        onPressed: () async {
                          final SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          widget.count++;
                          await prefs.setInt(widget.menu, widget.count);
                          setState(() {});
                        },
                        child: const Icon(Icons.add)),
                  ],
                ),
                customText(
                  text: '${widget.count * widget.cost}',
                  color: SUB_COLOR,
                ),
              ],
            )
          ],
        ),
      ),
      // ),
    );
  }
}

class customText extends StatelessWidget {
  customText({Key? key, required this.text, this.color = SUB_COLOR})
      : super(key: key);

  final Color color;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(color: color, fontSize: 20),
      textAlign: TextAlign.center,
    );
  }
}

class ScaleSize {
  static double textScaleFactor(BuildContext context,
      {double maxTextScaleFactor = 2}) {
    final width = MediaQuery.of(context).size.width;
    double val = (width / 140) * maxTextScaleFactor;
    return max(1, min(val, maxTextScaleFactor));
  }
}

class menuText extends StatelessWidget {
  const menuText({Key? key, required this.text}) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        color: FOREGROUND_COLOR,
        // fontSize: 30,
        fontWeight: FontWeight.bold,
        letterSpacing: 5.0,
      ),
      textAlign: TextAlign.center,
      textScaleFactor: ScaleSize.textScaleFactor(context),
    );
  }
}

class menu_data {
  final String menu;
  final int cost;
  final int count;
  menu_data(this.menu, this.cost, this.count);
}
