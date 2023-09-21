import 'package:cash/screens/setData/provider/setDataProvider.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';


class SetDataScreen extends StatelessWidget {
  const SetDataScreen({super.key});

  @override
    Widget build(BuildContext context) {

    var sections = context.watch<SetDataProvider>().state.sections;

    return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.black,
              elevation: 40,
              title: const Text('قائمة التعديلات',style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold,color: Color(0xFFF77D8E))),
              centerTitle: true,
              actions:[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: IconButton(
                  onPressed: (){
                    context.read<SetDataProvider>().saveSections(context);
                  },
                  icon: const Icon(Iconsax.save_add,color: Colors.green,size: 32,),
              ),
                ),
              ]
            ),
            backgroundColor: Colors.white,
            body: Directionality(
              textDirection: TextDirection.rtl,
              child: ListView.builder(
                itemCount: sections.length + 1,
                itemBuilder: (BuildContext context, int index) {
                  if (index == 0) {
                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const SizedBox(height: 15,),
                          ExpansionTile(
                            title: Row(
                              children: [
                                const SizedBox(width: 5,),
                                Container(
                                    height: 50,
                                    width: 130,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: const Color(0xFFF77D8E),),
                                      borderRadius: const BorderRadius.only(topLeft: Radius.circular(20), bottomRight:  Radius.circular(20), bottomLeft:  Radius.circular(20) ),
                                    ),
                                    child: const Text("اضافة قسم",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Color(0xFFF77D8E)))),
                              ],
                            ),
                            childrenPadding: const EdgeInsets.all(10),
                            children: [
                              TextFormField(
                                controller: context.watch<SetDataProvider>().state.sectionNameController,
                                onFieldSubmitted: (_) => context.read<SetDataProvider>().saveSectionCompleted(context),
                                decoration: const InputDecoration(
                                    labelText: 'اسم القسم',
                                    labelStyle: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Color(0xFFF77D8E))
                                ),
                              ),
                              const SizedBox(height: 16.0),
                              InkWell(
                                onTap: (){
                                  context.read<SetDataProvider>().saveSectionCompleted(context);
                                },
                                child: Center(
                                  child: Container(
                                    width: 180,
                                    height: 50,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFF77D8E),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: const Text('حفظ القسم',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white)),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 15,),
                        ],
                      ),
                    );
                  } else {
                    final sectionIndex = index - 1;
                    return Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black12,),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      margin: const EdgeInsets.all(10.0),
                      child: ExpansionTile(
                        title: Row(
                          children: [
                            // const SizedBox(width: ,),
                            SizedBox(
                                width: MediaQuery.of(context).size.width/15,
                                child: IconButton(onPressed: (){
                                  context.read<SetDataProvider>().removeSection(index);
                                }, icon: const Icon(Iconsax.close_circle,color: Colors.red,))),
                            // const SizedBox(width: 200,),
                            Container(
                                width: MediaQuery.of(context).size.width/ 1.5,
                                alignment: Alignment.centerRight,
                                child: Text(
                                    sections[sectionIndex].name,
                                    style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Color(0xFFF77D8E)))),
                          ],
                        ),
                        children: [
                          Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                children: [
                                  ExpansionTile(
                                    title: Row(
                                      children: [
                                        const SizedBox(width: 5,),
                                        Container(
                                            height: MediaQuery.of(context).size.height/ 15,
                                            width: MediaQuery.of(context).size.width/ 2.6,
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                              border: Border.all(color: const Color(0xFFF77D8E),),
                                              borderRadius: const BorderRadius.only(topLeft: Radius.circular(17), bottomRight:  Radius.circular(20), bottomLeft:  Radius.circular(20) ),
                                            ),
                                            child: const Text("اضافة صنف",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Color(0xFFF77D8E)))),
                                      ],
                                    ),
                                    childrenPadding: const EdgeInsets.all(10),
                                    children: [
                                      TextFormField(
                                        controller: context.watch<SetDataProvider>().state.itemName,
                                        decoration: const InputDecoration(
                                          labelText: 'اسم الصنف',
                                          labelStyle: TextStyle(fontWeight: FontWeight.bold,color: Color(0xFFF77D8E)),
                                        ),
                                        onFieldSubmitted: (_) {
                                          if(Provider.of<SetDataProvider>(context, listen: false).state.itemName.text.characters.length < 22){
                                            showDialog(context: context, builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: const Text('سعر الصنف',style: TextStyle(fontWeight: FontWeight.w500,color: Color(0xFFF77D8E))),
                                                content: TextFormField(
                                                    autovalidateMode: AutovalidateMode.onUserInteraction,
                                                    validator: (value) => value!.isEmpty ?'يرجى إدخال السعر' : double.tryParse(value) == null ? 'يرجى إدخال رقم فقط' : null,
                                                    controller: context.watch<SetDataProvider>().state.priceController,
                                                    autofocus: true,
                                                    decoration: const InputDecoration(
                                                      labelText: 'السعر',
                                                      labelStyle: TextStyle(fontSize: 14,fontWeight: FontWeight.w500,color: Color(0xFFF77D8E)),
                                                    ),
                                                    onFieldSubmitted: (_){
                                                      context.read<SetDataProvider>().onFiledSubmitted(sectionIndex, context);
                                                    }
                                                ),
                                                actions: [
                                                  TextButton(
                                                    child: const Text('إلغاء',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.red)),
                                                    onPressed: () {
                                                      Navigator.of(context).pop();
                                                    },
                                                  ),
                                                  TextButton(
                                                    child: const Text('إضافة',style: TextStyle(fontWeight: FontWeight.w500,color: Colors.green),),
                                                    onPressed: () {
                                                      context.read<SetDataProvider>().onFiledSubmitted(sectionIndex, context);
                                                    },
                                                  ),
                                                ],
                                              );
                                            });
                                          }else{
                                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("اسم الصنف يجب ان يحتوي على عدد احرف اقل من 15")));
                                          }
                                        },
                                      ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                    children: [
                                      const SizedBox(height: 16.0),
                                      ListView.builder(
                                        shrinkWrap: true,
                                        physics: const NeverScrollableScrollPhysics(),
                                        itemCount: sections[sectionIndex].items.length,
                                        itemBuilder: (BuildContext context, int itemIndex) {
                                          return InkWell(
                                            onTap: (){},
                                            child: Container(
                                              margin: const EdgeInsets.all(10),
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(20),
                                                  border: Border.all(color: Colors.black,)
                                              ),
                                              child: Card(
                                                color: Colors.white24,
                                                elevation: 20,
                                                child: Row(
                                                  children: [
                                                    const SizedBox(width: 10,),
                                                    Container(
                                                        width: MediaQuery.of(context).size.width/ 2.6,
                                                        alignment: Alignment.centerRight,
                                                        child: Text(sections[sectionIndex].items[itemIndex].name,style: const TextStyle(fontSize: 20,fontWeight: FontWeight.w500,color: Color(0xFFF77D8E)))),
                                                    const SizedBox(width: 10,),
                                                    Container(
                                                        alignment: Alignment.centerLeft,
                                                        width: MediaQuery.of(context).size.width/ 5,
                                                        child: Text('${sections[sectionIndex].items[itemIndex].price} ج',style: const TextStyle(fontSize: 20,fontWeight: FontWeight.w500,color: Colors.green))),
                                                    Padding(
                                                      padding: const EdgeInsets.only(right: 5),
                                                      child: Container(
                                                        width: MediaQuery.of(context).size.width/ 10,
                                                        alignment: Alignment.centerRight,
                                                        child: IconButton(
                                                            onPressed: (){
                                                              context.read<SetDataProvider>().removeItem(sectionIndex, itemIndex);
                                                            },
                                                            icon: const Icon(Iconsax.close_circle,color: Colors.red,)),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              )
                          ),
                        ],
                      ),
                    );
                  }
                },
              ),
            ),
          );
    }
}
