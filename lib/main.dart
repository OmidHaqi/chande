import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'Model/Currency.dart';
import 'dart:developer' as developer;
import 'package:intl/intl.dart';

void main() {
   // run App => app az inja run mishe 
  runApp(const MyApp());
}

// widget => در واقع کلاسی است که میداند رابط کاربری خود را توصیف کند 
// extends => ارث بری از تابع استست لس ویجت
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //برای حذف کردن برچسب دیباگ در اپ 
      debugShowCheckedModeBanner: false,
      //برای راست چین کردن اپ 
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      //تم دادن به اپ در حد استایل لوکال برای تکست ها  این روش منسوخ شده است                                                               
      theme: ThemeData(
        fontFamily: 'dana',
        textTheme: const TextTheme(
          headline1: TextStyle(
              fontFamily: 'dana',
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w700),
          bodyText1: TextStyle(
              fontFamily: 'dana',
              fontSize: 13,
              color: Colors.white,
              fontWeight: FontWeight.w300),
          bodyText2: TextStyle(
              fontFamily: 'dana',
              fontSize: 13,
              color: Colors.black,
              fontWeight: FontWeight.w300),
          headline2: TextStyle(
              fontFamily: 'dana', fontSize: 14, fontWeight: FontWeight.w300),
          headline3: TextStyle(
              fontFamily: 'dana',
              fontSize: 14,
              color: Colors.red,
              fontWeight: FontWeight.w700),
          headline4: TextStyle(
              fontFamily: 'dana',
              fontSize: 14,
              color: Colors.green,
              fontWeight: FontWeight.w700),
        ),
      ),
      
      supportedLocales: const [
        Locale("fa"), //Persian
      ],
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  Home({
    super.key,
  });

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Currency> currency = [];
// تابع دریافت اطلاعات از سرور از طریق ای پی ای
  Future getResponse(BuildContext context) async {
    var url = "http://sasansafari.com/flutter/api.php?access_key=flutter123456";
    var value = await http.get(Uri.parse(url));

    if (currency.isEmpty) {
      if (value.statusCode == 200) {
        // ignore: use_build_context_synchronously
        _showSnackBar(context, "بروزرسانی اطلاعات با موفقیت انجام شد");
        List jsonList = convert.jsonDecode(value.body);

        if (jsonList.isNotEmpty) {
          for (int i = 0; i < jsonList.length; i++) {
            setState(() {
              currency.add(Currency(
                  id: jsonList[i]["id"],
                  title: jsonList[i]["title"],
                  price: jsonList[i]["price"],
                  changes: jsonList[i]["changes"],
                  status: jsonList[i]["status"]));
            });
          }
        }
      }
    }
    return value;
  }

  @override
  void initState() {
    super.initState();
    getResponse(context);
  }

  @override
  Widget build(BuildContext context) {
    //داربست یا اسکفولد : اسکلت بندی صفحه نمایش 
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 243, 243, 243),
      //قسمت بالایی اپ
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        actions: [
          Image.asset("assets/images/icon.png"),
          Align(
            alignment: Alignment.centerRight,
            child: Text("قیمت به روز ارز",
                style: Theme.of(context).textTheme.headline1),
          ),
          //یه ویجت برای پر کردن فضای خالی بین ویجت ها
          Expanded(
            child: Align(
              alignment: Alignment.centerLeft,
              child: Image.asset("assets/images/menu.png"),
            ),
          ),
          const SizedBox(width: 16),
        ],
      ),
      //بدنه‌ی اپ رو داخل بادی مینویسیم
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 30, 20, 10),
          child: Column(children: [
            Row(
              children: [
                Image.asset("assets/images/q.png"),
                const SizedBox(width: 8),
                Text("نرخ آزاد ارز چیست ؟",
                    style: Theme.of(context).textTheme.headline1),
              ],
            ),
            const SizedBox(height: 12),
            // ignore: prefer_const_constructors
            Text(
              " نرخ ارزها در معاملات نقدی و رایج روزانه است معاملات نقدی معاملاتی هستند که خریدار و فروشنده به محض انجام معامله، ارز و ریال را با هم تبادل می نمایند.",
              textAlign: TextAlign.right,
              style: Theme.of(context).textTheme.headline2,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(1, 20, 1, 0),
              //عنوان گزینه ها 
              child: Container(
                width: double.infinity,
                height: 35,
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 130, 130, 130),
                  borderRadius: BorderRadius.all(Radius.circular(100)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      "نام آزاد ارز",
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    Text(
                      "قیمت",
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    Text(
                      "تغییر",
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: MediaQuery.of(context).size.height/1.7,
              child: listFutureBuilder(context),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
              child: Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height/16,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 232, 232, 232),
                  borderRadius: BorderRadius.circular(1000),
                ),
                child:
                // ردیف نمایش ساعت بروزرسانی و دکمه بروزرسانی 
                  Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //دکمه بروزرسانی 
                    SizedBox(
                      height: MediaQuery.of(context).size.height/16,
                      child: TextButton.icon(
                        //تایع ان‌پرس دکمه
                        onPressed: () {
                          currency.clear();
                          listFutureBuilder(context);
                        },
                        icon: const Icon(
                          CupertinoIcons.refresh_bold,
                          color: Colors.black,
                        ),
                        label: Padding(
                          padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                          child: Text("بروزرسانی",
                              style: Theme.of(context).textTheme.headline1),
                        ),
                        style: ButtonStyle(
                          //استفاده از تم متریال در دکمه
                          backgroundColor: MaterialStateProperty.all(
                            const Color.fromARGB(255, 202, 193, 255),
                          ),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(1000),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(80, 0, 0, 0),
                      child: Text("آخرین بروزسانی ${_getTime()}"),
                    )
                  ],
                ),
              ),
            )
          ]),
        ),
      ),
    );
  }

  FutureBuilder<dynamic> listFutureBuilder(BuildContext context) {
    return FutureBuilder(
      //نمایش انیمیش لودینگ قبل از لود شدن لیست ارز ها 
      //***** ? $$$$$ : @@@@@
      builder: (context, snapshot) {
        return snapshot.hasData
            ? ListView.separated(
                physics: const BouncingScrollPhysics(),
                itemCount: currency.length,
                itemBuilder: (BuildContext context, int postion) {
                  return Padding(
                    padding: EdgeInsets.fromLTRB(1, 8, 1, 1),
                    child: MyItem(postion, currency),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  if (index % 9 == 0) {
                    return const Padding(
                      padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
                      child: Add(),
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              )
            : const Center(
                child: CircularProgressIndicator(),
              );
      },
      //فراخوانی اطلاعات از سمت سرور با استفاده از این تابع انجام میشود
      future: getResponse(context),
    );
  }

//تابع گرفتن ساعت دستگاه هنگام بروزرسانی 
  String _getTime() {
    DateTime now = DateTime.now();
    return DateFormat('kk:mm:ss').format(now);
  }
}

// ایتم گزینه ها 
class MyItem extends StatelessWidget {
  int position;
  List<Currency> currency;

  MyItem(this.position, this.currency);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        boxShadow: const <BoxShadow>[
          BoxShadow(blurRadius: 1.0, color: Colors.grey),
        ],
        color: Colors.white,
        borderRadius: BorderRadius.circular(1000),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            currency[position].title!,
            style: Theme.of(context).textTheme.bodyText2,
          ),
          Text(
            getFarsiNumber(currency[position].price.toString()),
            style: Theme.of(context).textTheme.bodyText2,
          ),
          Text(
            getFarsiNumber(currency[position].changes.toString()),
            style: currency[position].status == "n"
                ? Theme.of(context).textTheme.headline3
                : Theme.of(context).textTheme.headline4,
          )
        ],
      ),
    );
  }
}
// کلاس گزینه‌ی تبلغات بین گزینه ها
class Add extends StatelessWidget {
  const Add({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        boxShadow: const <BoxShadow>[
          BoxShadow(blurRadius: 1.0, color: Colors.grey),
        ],
        color: Colors.red,
        borderRadius: BorderRadius.circular(1000),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            "تبلیغات",
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ],
      ),
    );
  }
}
// تابع نمایش اسنک برا کلیک رو دکمه بروزرسانی 
void _showSnackBar(BuildContext context, String msg) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        msg,
        style: Theme.of(context).textTheme.bodyText1,
      ),
      backgroundColor: Colors.green));
}

//تابع تبدیل اعداد لاتین به فارسی
String getFarsiNumber(String number) {
  const en = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
  const fa = ['۰', '۱', '۲', '۳', '۴', '۵', '۶', '۷', '۸', '۹'];
  en.forEach((element) {
    number = number.replaceAll(element, fa[en.indexOf(element)]);
  });

  return number;
}
