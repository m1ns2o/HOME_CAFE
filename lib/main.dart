import 'package:flutter/material.dart';
import 'package:knue_home_cafe/view/main_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: main_view(),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// // import 'package:async/async.dart';
//
// class main_view extends StatefulWidget {
//   const main_view({Key? key}) : super(key: key);
//
//   @override
//   State<main_view> createState() => _main_viewState();
// }

// class _main_viewState extends State<main_view> {
//   // static late SharedPreferences prefs;
//
//   // void initState() {
//   //   super.initState();
//   //   print("initState");
//   //   load_count();
//   // }
//   //
//   // late final int load_value;
//   //
//   late int tira_count;
//   Future<int> getStringFromSharedPref(String key) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     int value = await prefs.getInt(key) ?? 0;
//     print("getstring");
//     print(value);
//     return value;
//   }
//
//   late int myVariable;
//   Future<void> loadPreferences() async {
//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//     int myValue = prefs.getInt('티라미수') ?? 0;
//     if (myValue != null) {
//       myVariable = myValue;
//     }
//     print(myVariable);
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     // int val = getStringFromSharedPref("티라미수");
//     // print(val);
//     // loadPreferences();
//
//     // getStringFromSharedPref("티라미수").then((value) => this.tira_count = value);
//   }

//   Future<List> setcount() async {
//     loadPreferences();
//     // menu_data tira_data = menu_data("티라미수", 3500, myVariable);
//     // menu_container tira =
//     //         menu_container(menu: "티라미수", cost: 3500, count: myVariable),
//     //     oreo = menu_container(menu: "오레오", cost: 3500, count: 0),
//     //     americano = menu_container(menu: "아메리카노", cost: 2000, count: 0),
//     //     jori = menu_container(menu: "조리퐁라떼", cost: 3500, count: 0),
//     //     ogok = menu_container(menu: "오곡라떼", cost: 3000, count: 0);
//     print("future builder");
//     print(myVariable);
//     return [myVariable];
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // print(tira.count);
//     return Scaffold(
//       body: Padding(
//         padding: EdgeInsets.all(40),
//         child: FutureBuilder<List>(
//           future: setcount(),
//           builder: (context, AsyncSnapshot<List> snapshot) {
//             if (!snapshot.hasData) {
//               print("snapshot");
//               print(snapshot);
//               return Container();
//             }
//             return Column(
//               children: [
//                 Expanded(
//                     child: menu_container(
//                       menu: "티라미수",
//                       cost: 3500,
//                       count: snapshot.data![0],
//                     )),
//               ],
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
//
// class menu_container extends StatefulWidget {
//   menu_container(
//       {Key? key, required this.menu, required this.cost, required this.count})
//       : super(key: key);
//   final String menu;
//   final int cost;
//   int count;
//   @override
//   State<menu_container> createState() => _menu_containerState();
// }
//
// class _menu_containerState extends State<menu_container> {
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       // child: Expanded(
//       child: Container(
//         height: 100,
//         decoration: BoxDecoration(
//             color: Colors.white,
//             boxShadow: const [
//               BoxShadow(
//                 blurRadius: 1,
//                 offset: Offset(0, 1),
//                 color: Colors.grey,
//               ),
//             ],
//             borderRadius: BorderRadius.circular(15)),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(widget.menu),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.white,
//                         foregroundColor: Color(0xFF26C6DA)),
//                     onPressed: () async {
//                       final SharedPreferences prefs =
//                       await SharedPreferences.getInstance();
//                       widget.count--;
//                       await prefs.setInt(widget.menu, widget.count);
//                       setState(() {});
//                     },
//                     child: Icon(Icons.remove)),
//                 Text('${widget.count}'),
//                 ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.white,
//                         foregroundColor: Color(0xFF26C6DA)),
//                     onPressed: () async {
//                       final SharedPreferences prefs =
//                       await SharedPreferences.getInstance();
//                       widget.count++;
//                       await prefs.setInt(widget.menu, widget.count);
//                       setState(() {});
//                     },
//                     child: Icon(Icons.add)),
//               ],
//             ),
//             Text('${widget.count * widget.cost}'),
//           ],
//         ),
//       ),
//       // ),
//     );
//   }
// }
//
// class menu_data {
//   final String menu;
//   final int cost;
//   final int count;
//   menu_data(this.menu, this.cost, this.count);
// }
//
