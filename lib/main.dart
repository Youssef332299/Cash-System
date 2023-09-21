// import 'dart:typed_data';
// import 'package:flutter/material.dart';
// import 'package:image/image.dart';
// import 'package:screenshot/screenshot.dart';
// import 'package:esc_pos_printer/esc_pos_printer.dart';
// import 'package:esc_pos_utils/esc_pos_utils.dart';
// import 'dart:io';
//
// void main() {
//   runApp(const MyApp());
// }
//
// class MyApp extends StatefulWidget {
//   const MyApp({Key? key}) : super(key: key);
//
//   @override
//   State<MyApp> createState() => _MyAppState();
// }
//
// class _MyAppState extends State<MyApp> {
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: const MyHomePage(title: 'Flutter Demo Home Page'),
//     );
//   }
// }
//
// class MyHomePage extends StatefulWidget {
//   const MyHomePage({Key? key, required this.title}) : super(key: key);
//   final String title;
//
//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   ScreenshotController screenshotController = ScreenshotController();
//   String dir = Directory.current.path;
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     // print(dir);
//     // setState(() {
//     //   Process.run('$dir/images/installerX64/install.exe', [' start '])
//     //       .then((ProcessResult results) {
//     //     print(results.stdout);
//     //   });
//     // });
//   }
//   void testPrint(String printerIp, Uint8List theimageThatComesfr) async {
//     print("im inside the test print 2");
//     // TODO Don't forget to choose printer's paper size
//     const PaperSize paper = PaperSize.mm80;
//     final profile = await CapabilityProfile.load();
//     final printer = NetworkPrinter(paper, profile);
//
//     final PosPrintResult res = await printer.connect(printerIp, port: 9100);
//
//     if (res == PosPrintResult.success) {
//       // DEMO RECEIPT
//       await testReceipt(printer, theimageThatComesfr);
//       print(res.msg);
//       await Future.delayed(const Duration(seconds: 3), () {
//         print("prinnter desconect");
//         printer.disconnect();
//       });
//     }
//   }
//   TextEditingController Printer = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("معاينة الوصل قبل الطباعة "),
//       ),
//       body: Center(
//           child: ListView(
//             children: [
//               Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   TextField(
//                     controller: Printer,
//                     decoration: const InputDecoration(hintText: "printer ip"),
//                   ),
//
//                   const SizedBox(
//                     height: 10,
//                   ),
//                   ElevatedButton(
//                     child: const Text(
//                       'print res',
//                       style: TextStyle(fontSize: 40),
//                     ),
//                     onPressed: () {
//                       screenshotController
//                           .capture(delay: const Duration(milliseconds: 10))
//                           .then((capturedImage) async {
//                         theimageThatComesfromThePrinter = capturedImage!;
//                         setState(() {
//                           theimageThatComesfromThePrinter = capturedImage;
//                           testPrint(Printer.text, theimageThatComesfromThePrinter);
//                         });
//                       }).catchError((onError) {
//                         print(onError);
//                       });
//                     },
//                   ),
//                   const SizedBox(
//                     height: 10,
//                   ),
//                   Screenshot(
//                     controller: screenshotController,
//                     child: Container(
//                         width: 140,
//                         child: Column(
//                           children: [
//                             Row(
//                               children: const [
//                                 Text(
//                                   "محمد نعم 臺灣  ",
//                                   style: TextStyle(
//                                       fontSize: 10, fontWeight: FontWeight.bold),
//                                 ),
//                               ],
//                               mainAxisAlignment: MainAxisAlignment.center,
//                             ),
//                             const Text(
//                                 "-----------------"),
//                             Padding(
//                               padding: const EdgeInsets.only(bottom: 20.0),
//                               child: Row(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: const [
//                                   Text(
//                                     "(  汉字 )",
//                                     style: TextStyle(
//                                         fontSize: 10, fontWeight: FontWeight.bold),
//                                   ),
//                                   SizedBox(
//                                     width: 2,
//                                   ),
//                                   Text(
//                                     "رقم الطلب",
//                                     style: TextStyle(
//                                         fontSize: 10, fontWeight: FontWeight.bold),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             const SizedBox(
//                               height: 20,
//                               child: Text(
//                                   "-----------------------"),
//                             ),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: const [
//                                 Expanded(
//                                   child: Center(
//                                     child: Text(
//                                       "التفاصيل",
//                                       style: TextStyle(
//                                           fontSize: 10,
//                                           fontWeight: FontWeight.bold),
//                                     ),
//                                   ),
//                                   flex: 6,
//                                 ),
//                                 Expanded(
//                                   child: Center(
//                                     child: Text(
//                                       "السعر ",
//                                       style: TextStyle(
//                                           fontSize: 10,
//                                           fontWeight: FontWeight.bold),
//                                     ),
//                                   ),
//                                   flex: 2,
//                                 ),
//                                 Expanded(
//                                   child: Center(
//                                     child: Text(
//                                       "العدد",
//                                       style: TextStyle(
//                                           fontSize: 10,
//                                           fontWeight: FontWeight.bold),
//                                     ),
//                                   ),
//                                   flex: 2,
//                                 ),
//                               ],
//                             ),
//                             ListView.builder(
//                               scrollDirection: Axis.vertical,
//                               shrinkWrap: true,
//                               physics: const ScrollPhysics(),
//                               itemCount: 1,
//                               itemBuilder: (context, index) {
//                                 return Card(
//                                   child: Row(
//                                     mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                     crossAxisAlignment: CrossAxisAlignment.start,
//                                     children: const [
//                                       Expanded(
//                                         child: Center(
//                                           child: Text(
//                                             "臺灣",
//                                             style: TextStyle(fontSize: 10),
//                                           ),
//                                         ),
//                                         flex: 6,
//                                       ),
//                                       Expanded(
//                                         child: Center(
//                                           child: Text(
//                                             "تجربة عيوني انتة ",
//                                             style: TextStyle(fontSize: 10),
//                                           ),
//                                         ),
//                                         flex: 2,
//                                       ),
//                                       Expanded(
//                                         child: Center(
//                                           child: Text(
//                                             "Test",
//                                             style: TextStyle(fontSize: 10),
//                                           ),
//                                         ),
//                                         flex: 2,
//                                       ),
//                                     ],
//                                   ),
//                                 );
//                               },
//                             ),
//                             const Text(
//                                 "----------"),
//                           ],
//                         )),
//                   ),
//                   const SizedBox(
//                     height: 25,
//                   ),
//                 ],
//               ),
//             ],
//           )),
//     );
//   }
//     Future<void> testReceipt(
//       NetworkPrinter printer,  Uint8List theimageThatC) async {
//
//
//     dynamic image = decodeImage(theimageThatC);
//     printer.image(image! , align: PosAlign.center);
//
//
//     printer.cut();
//
//   }
//   late Uint8List theimageThatComesfromThePrinter ;
// }


import 'package:cash/screens/onboding/onboding_screen.dart';
import 'package:cash/screens/setData/provider/setDataProvider.dart';
import 'package:cash/screens/setData/setDataScreen.dart';
import 'package:cash/screens/setData/widgets/endShift.dart';
import 'package:cash/screens/setData/widgets/homeScreen.dart';
import 'package:cash/screens/setData/widgets/onPrep.dart';
import 'package:cash/screens/setData/widgets/purchasesScreen.dart';
import 'package:cash/screens/setData/widgets/startShiftScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'core/routes/routes.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return MultiProvider(
        providers: [
          ChangeNotifierProvider<SetDataProvider>(
              create: (context) => SetDataProvider()..init()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'The Flutter Way',
          theme: ThemeData(
            scaffoldBackgroundColor: const Color(0xFFEEF1F8),
            primarySwatch: Colors.blue,
            fontFamily: "Intel",
            inputDecorationTheme: const InputDecorationTheme(
              filled: true,
              fillColor: Colors.white,
              errorStyle: TextStyle(height: 0),
              border: defaultInputBorder,
              enabledBorder: defaultInputBorder,
              focusedBorder: defaultInputBorder,
              errorBorder: defaultInputBorder,
            ),
          ),
          routes: {
            Routes.init: (context) => const OnboardingScreen(),
            Routes.startShift: (context) => const StartShift(),
            Routes.setData: (context) => const SetDataScreen(),
            Routes.home: (context) => const HomeScreen(),
            Routes.endShift: (context) => const EndShift(),
            Routes.onPrep: (context) => const OnPrep(),
            Routes.purchases: (context) => const PurchasesScreen(),
          },
        ),
      );
    });
  }
}

const defaultInputBorder = OutlineInputBorder(
  borderRadius: BorderRadius.all(Radius.circular(16)),
  borderSide: BorderSide(
    color: Color(0xFFDEE3F2),
    width: 1,
  ),
);
