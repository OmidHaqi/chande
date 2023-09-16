import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Bidad',
      ),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('fa'), //persian
      ],
      home: Scaffold(
        backgroundColor: const Color.fromARGB(255, 243, 243, 243),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          actions: [
            Image.asset("assets/images/currency_icon.png"),
            const Align(
              alignment: Alignment.centerRight,
              child: Text(
                "قیمت بروز ارز ",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.centerLeft,
                child: Image.asset("assets/images/menu_icon.png"),
              ),
            ),
            const SizedBox(width: 8),
          ],
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 24, 16, 0),
              child: Row(
                children: [
                  Image.asset("assets/images/question_icon.png"),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "نرخ آزاد ارز چیست؟",
                    ),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
              child: Text(
                "نرخ ارزها در معاملات نقدی و رایج روزانه است معاملات نقدی معاملاتی هستند که خریدار و فروشنده به محض انجام معامله، ارز و ریال را با هم تبادل می نمایند.",
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
              child: Container(
                width: double.infinity,
                height: 35,
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 130, 130, 130),
                  borderRadius: BorderRadius.all(
                    Radius.circular(50),
                  ),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      "نام ارز",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "قیمت",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "تغییر",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
              child: Container(
                width: double.infinity,
                height: 400,
                child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: 30,
                  itemBuilder: (BuildContext context, int it) {
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(1, 8, 1, 1),
                      child: Container(
                        width: double.infinity,
                        height: 50,
                        decoration: BoxDecoration(
                          boxShadow: const <BoxShadow>[
                            BoxShadow(blurRadius: 1.0, color: Colors.grey)
                          ],
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(1000),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              "دلار",
                            ),
                            Text(
                              "۴۸۰۰۰",
                            ),
                            Text(
                              "+۳",
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
