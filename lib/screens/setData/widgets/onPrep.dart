import 'package:cash/screens/setData/provider/setDataProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OnPrep extends StatelessWidget {
  const OnPrep({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SetDataProvider>(
      builder: (BuildContext context, o, Widget? child) {
        // o is object
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              "تحت التجهيز",
              style: TextStyle(
                  color: Colors.black,
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.w800),
            ),
            centerTitle: true,
            backgroundColor: const Color(0xFFF77D8E),
            elevation: 20,
          ),
          backgroundColor: Colors.white,
          body: SizedBox(
              height: 900,
              width: double.infinity,
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3, mainAxisExtent: MediaQuery.of(context).size.height/ 2.3),
                itemCount: o.state.order.length,
                itemBuilder: (context, i) {
                  return InkWell( 
                    onLongPress: (){
                      o.state.order.removeAt(i);
                    },
                    child: Container(
                        // height: MediaQuery.of(context).size.height / 1,
                        // width: MediaQuery.of(context).size.width / 1,
                        margin: const EdgeInsets.only(top: 20, left: 10),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: const Color(0xFFF77D8E))),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height:MediaQuery.of(context).size.height / 3,
                              width: MediaQuery.of(context).size.width / 2,
                              child: ListView.builder(
                                itemCount: o.state.order[i].length,
                                itemBuilder: (context, index) => Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                        width: MediaQuery.of(context).size.width / 10,
                                        height: MediaQuery.of(context).size.height / 22 ,
                                        child: Text(
                                            "${o.state.order[i][index].total} ج",
                                            style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w700,
                                                color: Colors.green))),
                                    // const SizedBox(width: 6,),
                                    SizedBox(
                                      width: 40,
                                      height: MediaQuery.of(context).size.height / 22,
                                      child: Text(
                                          " ${o.state.order[i][index].count}x",
                                          style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w700)),
                                    ), // const SizedBox(width: 6,),

                                    Container(
                                      alignment: Alignment.centerRight,
                                      width: 200,
                                      height: MediaQuery.of(context).size.height / 22,
                                      child: Text(
                                        o.state.order[i][index].name,
                                        style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Center(child: Text("${i + 1}"),),
                          ],
                        )),
                  );
                },
              ),
            ),
        );
      },
    );
  }
}
