import 'package:cash/screens/setData/provider/setDataProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PurchasesScreen extends StatelessWidget {
  const PurchasesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("المشتريات"),
        centerTitle: true,
        elevation: 20,
        backgroundColor: Colors.black,
        leading: GestureDetector(
          onTap: ()=> Navigator.of(context).pop(),
            child: const Icon(Icons.arrow_back)),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height / 50,),
            const Text("القيمة المدفوعة",style: TextStyle(fontWeight: FontWeight.w700,fontSize: 14),),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                autocorrect: true,
                keyboardType: TextInputType.number,
                onFieldSubmitted: (value){
                  // context.watch<SetDataProvider>().state.purchasesSale = ;
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
