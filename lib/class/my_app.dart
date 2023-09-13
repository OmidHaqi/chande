import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          actions: [
            const SizedBox(width: 8),
            Expanded(
              child: Align(
                alignment: Alignment.centerLeft,
                child: Image.asset("assets/images/menu_icon.png"),
              ),
            ),
            const Align(
              alignment: Alignment.centerRight,
              child: Text(
                "قیمت بروز ارز ",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
            Image.asset("assets/images/currency_icon.png")
          ],

          // title: Row(
          //   children: [
          //     Expanded(
          //       child: Align(
          //         alignment: Alignment.centerLeft,
          //         child: Image.asset("assets/images/menu_icon.png"),
          //       ),
          //     ),
          //     const Text("قیمت بروز ارز "),
          //     Image.asset("assets/images/currency_icon.png")
          //   ],
          // ),
          // actions: [
          //   Icon(
          //     Icons.menu,
          //     color: Color(0xFFffffff),
          //   ),
          // ],
        ),
        body: const Center(
          child: Text("Hello World"),
        ),
      ),
    );
  }
}
