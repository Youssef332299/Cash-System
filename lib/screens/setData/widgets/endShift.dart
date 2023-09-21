import 'package:cash/screens/setData/provider/setDataProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EndShift extends StatelessWidget {
  const EndShift({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SetDataProvider>(
      builder: (BuildContext context, o, Widget? child) {
        // o is object
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: Color(0xFF25254B),
            elevation: 0,
            title: Column(
              children: [
                Text(
                  o.state.timeString.isNotEmpty ? o.state.timeString : '',
                  style: const TextStyle(
                      fontSize: 20,
                      fontFamily: "Poppins",
                      color: Color(0xFFF77D8E)),
                ),
                const SizedBox(height: 2),
                Text(
                  o.state.dateString,
                  style:
                      const TextStyle(fontSize: 14, color: Color(0xFFF77D8E)),
                ),
              ],
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
                  children: [
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  // height: 400,
                  height: MediaQuery.of(context).size.height/1.24,
                  child: ListView.builder(

                    itemCount: o.state.itemSold.length,
                    itemBuilder: (context, i) {
                      return Row(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 40,
                          ),
                          SizedBox(
                              width: MediaQuery.of(context).size.width / 3.5,
                              child: Text("${o.state.itemSold[i].total} ج")),
                          SizedBox(
                              width: MediaQuery.of(context).size.width / 7,
                              child: Text("${o.state.itemSold[i].count}")),
                          Container(
                            alignment: Alignment.centerRight,
                            width: MediaQuery.of(context).size.width / 2,
                            child: Text(
                              o.state.itemSold[i].name,
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w700),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
                const Center(
                  child: Text("TOTAL CASH",
                    style: TextStyle(
                        fontSize: 17, fontWeight: FontWeight.w900, fontFamily: "Poppins"),),
                ),
                Center(
                  child: Text("${o.state.totalSold} ج",
                    style: const TextStyle(
                        fontSize: 19, fontWeight: FontWeight.w700,fontFamily: "Poppins"),),
                ),
              ]),
          ),
        );
      },
    );
  }
}
