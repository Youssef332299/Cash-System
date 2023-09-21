import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import '../../../core/routes/routes.dart';
import '../provider/setDataProvider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // ScreenshotController screenController = ScreenshotController();

    return Scaffold(
      appBar: AppBar(
      backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
        title: Column(
          children: [
            const SizedBox(height: 4),
            Text(
                context.watch<SetDataProvider>().state.timeString.isNotEmpty
                    ? context.watch<SetDataProvider>().state.timeString
                    : '',
                style: const TextStyle(
                    fontSize: 22,
                    fontFamily: "Poppins",
                    color: Color(0xFFF77D8E)),
              ),
              const SizedBox(height: 2),
              Text(
                context.watch<SetDataProvider>().state.dateString,
                style:
                const TextStyle(fontSize: 16, color: Color(0xFFF77D8E)),
              ),
          ],
        )
      ),
      backgroundColor: Colors.white,
      body: Consumer<SetDataProvider>(builder: (context, object, child) {
        return  Container(
            height: MediaQuery.of(context).size.height / 1,
            child: Row(
              children: [
                SizedBox(
                  // width: MediaQuery.of(context).size.width / 20,
                  width: 50,
                  height: double.infinity,
                  child: Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 30,
                      ),
                      Center(
                          child: IconButton(
                              onPressed: () {
                                if (object.state.isSelected) {
                                  object.isSelected(0);
                                }
                              },
                              icon: Icon(
                                Iconsax.category,
                                color: object.state.isSelected
                                    ? const Color(0xFFF77D8E)
                                    : Colors.black,
                              ))),
                      const Divider(
                        endIndent: 10,
                        indent: 10,
                        height: 30,
                      ),
                      Center(
                          child: IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Iconsax.activity,
                                color: !object.state.isSelected
                                    ? const Color(0xFFF77D8E)
                                    : Colors.black,
                              ))),
                      const Divider(
                        endIndent: 10,
                        indent: 10,
                        height: 30,
                      ),
                      Center(
                          child: IconButton(
                              onPressed: () {
                                object.endShift(context);
                                Navigator.of(context).pushNamed(Routes.endShift);
                              },
                              icon: const Icon(
                                Iconsax.keyboard_open,
                                color: Color(0xFFF77D8E),
                              ))),
                      const Divider(
                        endIndent: 10,
                        indent: 10,
                        height: 30,
                      ),
                      Center(
                          child: IconButton(
                              onPressed: () {
                                Navigator.of(context).pushNamed(Routes.onPrep);
                              },
                              icon: const Icon(
                                Iconsax.timer_1,
                                color: Color(0xFFF77D8E),
                              ))),
                      const Divider(
                        endIndent: 10,
                        indent: 10,
                        height: 30,
                      ),
                      Center(
                          child: IconButton(
                                onPressed: () {
                                  Navigator.of(context).pushNamed(Routes.purchases);
                                },
                                //   showDialog(
                                //     context: context,
                                //     builder: (BuildContext context) {
                                //       return AlertDialog(
                                //         title: const Text('المشتريات',
                                //             style: TextStyle(
                                //                 fontWeight: FontWeight.w500,
                                //                 color: Color(0xFFF77D8E))),
                                //         content: TextFormField(
                                //             autovalidateMode:
                                //             AutovalidateMode.onUserInteraction,
                                //             validator: (value) =>
                                //             int.tryParse(value!) == null
                                //                 ? 'يرجى ادخال الكمية بلارقام'
                                //                 : null,
                                //             controller:
                                //             object.state.counterController,
                                //             autofocus: true,
                                //             decoration: const InputDecoration(
                                //               labelText: 'الكمية',
                                //               labelStyle: TextStyle(
                                //                   fontSize: 14,
                                //                   fontWeight: FontWeight.w500,
                                //                   color: Color(0xFFF77D8E)),
                                //             ),
                                //             onFieldSubmitted: (_) {
                                //               object.onSave(i, context);
                                //             }),
                                //         actions: [
                                //           TextButton(
                                //             child: const Text('إلغاء',
                                //                 style: TextStyle(
                                //                     fontWeight: FontWeight.bold,
                                //                     color: Colors.red)),
                                //             onPressed: () {
                                //               Navigator.of(context).pop();
                                //               object.state.counterController
                                //                   .clear();
                                //             },
                                //           ),
                                //         ],
                                //       );
                                //     },
                                //   );
                                // },
                              icon: const Icon(
                                Iconsax.shopping_cart,
                                color: Color(0xFFF77D8E),
                              ))),
                      const Divider(
                        endIndent: 10,
                        indent: 10,
                        height: 30,
                      ),
                      Center(
                          child: IconButton(
                              onPressed: () {
                                Navigator.of(context).pushNamed(Routes.setData);
                              },
                              icon: const Icon(
                                Iconsax.card_add,
                                color: Color(0xFFF77D8E),
                              ))),
                    ],
                  ),
                ),
                const SizedBox(width: 10,),
                Container(
                  alignment: Alignment.topCenter,
                      // margin: const EdgeInsets.only(bottom: 10,top: 10),
                      height: MediaQuery.of(context).size.height / 1.1,
                      width: MediaQuery.of(context).size.width / 1.8,
                      decoration: BoxDecoration(
                        color: Colors.black12,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: object.state.isSelected
                          ? GridView.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2, mainAxisExtent: 133),
                              itemCount: object.state.sections[object.state.secIndex].items.length,
                              itemBuilder: (ctx, i) {
                                return Container(
                                  margin: const EdgeInsets.all(2),
                                  child: MaterialButton(
                                    color: const Color(0xFFF77D8E),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20)),
                                    padding: const EdgeInsets.symmetric(vertical: 14),
                                    elevation: 110,
                                    splashColor: Colors.black,
                                    highlightColor: const Color(0xDA0D5E77),
                                    hoverColor: const Color(0xFFCCC4C4),
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: const Text('الكمية المطلوبة',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    color: Color(0xFFF77D8E))),
                                            content: TextFormField(
                                                autovalidateMode:
                                                    AutovalidateMode.onUserInteraction,
                                                validator: (value) =>
                                                    int.tryParse(value!) == null
                                                        ? 'يرجى ادخال الكمية بلارقام'
                                                        : null,
                                                controller:
                                                    object.state.counterController,
                                                autofocus: true,
                                                decoration: const InputDecoration(
                                                  labelText: 'الكمية',
                                                  labelStyle: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.w500,
                                                      color: Color(0xFFF77D8E)),
                                                ),
                                                keyboardType: TextInputType.number,
                                                onFieldSubmitted: (_) {
                                                  object.onSave(i, context);
                                                }),
                                            actions: [
                                              TextButton(
                                                child: const Text('إلغاء',
                                                    style: TextStyle(
                                                        fontWeight: FontWeight.bold,
                                                        color: Colors.red)),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                  object.state.counterController
                                                      .clear();
                                                },
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                    child: Column(
                                      children: [
                                        Center(
                                          child: Container(
                                            width: 120,
                                            height: 70,
                                            child: Text(
                                              object
                                                  .state
                                                  .sections[object.state.secIndex]
                                                  .items[i]
                                                  .name,
                                              style: const TextStyle(
                                                  fontSize: 22,
                                                  fontWeight: FontWeight.w800,
                                                  color: Colors.white,fontFamily: "Poppins"),
                                            ),
                                          ),
                                        ),
                                        Center(
                                          child: Text(
                                            "${object.state.sections[object.state.secIndex].items[i].price} ج ",
                                            style: const TextStyle(
                                                shadows: [
                                                  BoxShadow(
                                                      blurRadius: 20,
                                                      offset: Offset(2, 5)),
                                                ],
                                                fontSize: 18,
                                                fontWeight: FontWeight.w800,
                                                color: Colors.black),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            )
                          : GridView.builder(
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2, mainAxisExtent: 140),
                              itemCount: object.state.sections.length,
                              itemBuilder: (ctx, i) {
                                return Container(
                                  margin: const EdgeInsets.all(10),
                                  child: MaterialButton(
                                    color: Colors.black,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20)),
                                    padding: const EdgeInsets.symmetric(vertical: 14),
                                    elevation: 200,
                                    splashColor: Colors.black,
                                    hoverColor: const Color(0xFFF77D8E),
                                    onPressed: () {
                                      object.isSelected(i);
                                    },
                                    child: Center(
                                      child: Text(
                                        object.state.sections[i].name,
                                        style: const TextStyle(
                                            fontSize: 26,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                    ),
                const SizedBox(width: 10,),
                Container(
                          margin: const EdgeInsets.only(bottom: 5),
                          height: MediaQuery.of(context).size.height / 1.08,
                          width: MediaQuery.of(context).size.width / 6,
                          decoration: BoxDecoration(
                            color: Colors.black12,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            children: [
                              object.state.edit.name.isEmpty || object.state.edit.price == 0
                                  ? SizedBox(
                                height: MediaQuery.of(context).size.height / 5,
                              )
                                  : Container(
                                margin: const EdgeInsets.all(10),
                                height: MediaQuery.of(context).size.height / 5,
                                child: Column(
                                  children: [
                                    const Center(
                                      child: Text(
                                        "تعديل الطلب",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 22,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width / 1,
                                      alignment: Alignment.centerLeft,
                                      child: Text(object.state.edit.name,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16)),
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width / 1,
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "x${object.state.counterEdit}",
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 18),
                                      ),
                                    ),
                                    Container(
                                          alignment: Alignment.centerLeft,
                                          width: MediaQuery.of(context).size.width / 1,
                                          child: Text(
                                              "${object.state.edit.price * object.state.counterEdit}ج",
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 14,
                                                  color: Colors.green)),
                                        ),
                                  ],
                                ),
                              ),
                              SizedBox(height: MediaQuery.of(context).size.height / 3,),
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 5.2,
                                height: MediaQuery.of(context).size.height / 14,
                                child: ElevatedButton(
                                  onPressed: () {
                                    object.delete();
                                  },
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xDAB00D0D),
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(14)),
                                      padding:
                                      const EdgeInsets.symmetric(vertical: 14)),
                                  child: const Text("ازالة"),
                                ),
                              ),
                              const SizedBox(height: 10,),
                              Container(
                                margin: const EdgeInsets.only(left: 5),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width / 15,
                                      height: MediaQuery.of(context).size.height / 14,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          object.minus();
                                        },
                                        style: ElevatedButton.styleFrom(
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(14)),
                                            backgroundColor: Colors.red.shade300,
                                            padding:
                                            const EdgeInsets.symmetric(vertical: 14)),
                                        child: const Icon(
                                          Iconsax.minus_cirlce,
                                          size: 25,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width / 50,
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width /15,
                                      height: MediaQuery.of(context).size.height / 14,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          object.plus();
                                        },
                                        style: ElevatedButton.styleFrom(
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(14)),
                                            backgroundColor: const Color(0xDA0D5E77),
                                            padding:
                                            const EdgeInsets.only(right: 5)),
                                        child: const Icon(
                                          Iconsax.add_circle,
                                          size: 25,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 2.8,
                                height: 56,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFFF77D8E),
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(14)),
                                      padding: const EdgeInsets.symmetric(vertical: 14)),
                                  onPressed: () {
                                    // final im = await object.state.screenController.capture();
                                    // final setDataProvider = Provider.of<SetDataProvider>(context, listen: false);
                                    // final image = await screenController.captureFromWidget(setDataProvider.bill(context));
                                    // print(image);
                                    // print(screenController);
                                    // // print(image.runtimeType);
                                    // final imageFile = File('D:\\images\\screenshot.png');
                                    // await imageFile.create(recursive: true);
                                    // await imageFile.writeAsBytes(image);
                                    //  هام
                                  },
                                  child: const Text(
                                    "طباعة الفاتورة",
                                    style: TextStyle(fontSize: 18, color: Colors.white),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: MediaQuery.of(context).size.height / 60,
                              ),
                              MaterialButton(
                                onPressed: () {
                                  object.orderDone();
                                },
                                height: MediaQuery.of(context).size.height / 12,
                                minWidth: MediaQuery.of(context).size.width / 2.8,
                                elevation: 100,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(14)),
                                splashColor: const Color(0xFFF77D8E),
                                hoverColor: Colors.black,
                                color: Colors.white,
                                child: const Text("اغلاق الفاتورة",
                                    style: TextStyle(
                                        color: Color(0xFFF77D8E),
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700)),
                              ),
                            ],
                          ),
                        ),
                        object.bill(context)
              ],
            ),);
      }),
    );
  }
}
