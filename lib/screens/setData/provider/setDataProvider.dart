import 'dart:async';
import 'dart:convert';
import 'package:cash/data/model/onPrep/onPrepModel.dart';
import 'package:cash/screens/setData/provider/setDataState.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import '../../../core/routes/routes.dart';
import '../../../data/model/itemSold/itemSoldModel.dart';
import '../../../data/model/section/itemModel.dart';
import '../../../data/model/section/sectionModel.dart';
import 'package:shared_preferences/shared_preferences.dart';



class SetDataProvider extends ChangeNotifier {
  SetDataState state = SetDataState();

  void init() {
    Timer.periodic(const Duration(), (Timer t) => getCurrentTime());
    setClient();
  }

  // set data ***********************************************************

  Future<void> setClient() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getBool("newClient") == null) {
      await prefs.setBool("newClient", false);
    }
  }

  Future<void> saveSections(context) async {
    final prefs = await SharedPreferences.getInstance();
    final json = state.sections.map((section) => section.toJson()).toList();
    final jsonString = jsonEncode(json);
    await prefs.setString('sections', jsonString);
    Navigator.of(context).pushNamedAndRemoveUntil(Routes.startShift, (route) => false);
  }

  Future<void> loadSections() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString('sections') ?? '[]';
    List<dynamic> jsonList = jsonDecode(jsonString);
    for (int i = 0; i < jsonList.length; i++) {
      state.sections.add(Section(
          name: jsonList[i]["name"],
          items: List<Item>.from(
            jsonList[i]['items'].map((item) => Item.fromJson(item)),
          )));
    }
    notifyListeners();
  }

  void addSection(String sectionName) {
    state.sections.add(Section(name: sectionName, items: []));
    notifyListeners();
  }

  void addItem(int sectionIndex, String itemName, double itemPrice, context) {
    if (state.itemName.text.isNotEmpty) {
      state.sections[sectionIndex].items
          .add(Item(name: itemName, price: itemPrice));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("يرجى ادخال اسم الصنف")));
    }
    notifyListeners();
  }

  void removeSection(index) {
    if (index == 1) {
      state.sections.remove(state.sections[1 - index as int]);
    } else {
      state.sections.remove(state.sections[index - 1]);
    }
    notifyListeners();
  }

  void onFiledSubmitted(sectionIndex, context) {
    if (state.priceController.text.isNotEmpty) {
      final price = double.parse(state.priceController.text);
      addItem(sectionIndex, state.itemName.text, price, context);
      state.itemName.clear();
      state.priceController.clear();
      Navigator.of(context).pop();
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("يرجى ادخال السعر")));
    }
    notifyListeners();
  }

  void saveSectionCompleted(context) {
    if (state.sectionNameController.text.isNotEmpty) {
      addSection(state.sectionNameController.text);
      state.sectionNameController.clear();
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("يرجى ادخال اسم القسم")));
    }
    notifyListeners();
  }

  void removeItem(sectionIndex, itemIndex) {
    state.sections[sectionIndex].items
        .remove(state.sections[sectionIndex].items[itemIndex]);
    notifyListeners();
  }

  void startShift(context){
    for(int i = 0; i < state.sections.length; i++){
      state.soldCount.add([]);
      for(int j = 0; j < state.sections[i].items.length; j++){
        state.soldCount[i].add(0);
      }
    }
    print(state.sections);
    print(state.soldCount);
    Navigator.of(context).pushNamed(Routes.home);
    notifyListeners();
  }

  // void endShift(context){
  //   // print item sold
  //   for(int i = 0; i < state.soldCount.length; i++){
  //     for(int j = 0; j < state.soldCount[i].length; j++){
  //       state.itemSold.add(ItemSold(name: state.sections[i].name, count: state.soldCount[i][j], total: state.sections[i].items[i].price * state.soldCount[i][j]));
  //       state.totalSold += state.itemSold[i].total;
  //       print(state.totalSold);
  //       print("${state.itemSold[i]} \n");
  //     }
  //   }
  //   // state.itemSold.clear();
  //   // state.soldCount.clear();
  //   // Navigator.of(context).pushNamed(Routes.init);
  // }

  void endShift(context) {
    state.itemSold.clear();
    state.totalSold = 0;
      for (int i = 0; i < state.sections.length; i++) {
        print("i : [$i]");
        print("len: [${state.sections.length}]");
        for (int j = 0; j < state.soldCount[i].length; j++) {
          state.itemSold.add(
              ItemSold(
                name: state.sections[i].items[j].name,
                count: state.soldCount[i][j],
                total: state.sections[i].items[j].price * state.soldCount[i][j]));
          print("total:  ${state.sections[i].items[j].price * state.soldCount[i][j]}");
          state.totalSold += state.sections[i].items[j].price * state.soldCount[i][j];
          print(state.totalSold);
          // print("${state.itemSold[i]} \n");
      }
    }
  }

  // home ***********************************************************

  void getCurrentTime() {
    final now = DateTime.now();
    final formatter = DateFormat('h:mm a');
    state.timeString = formatter.format(now);
    state.dateString = _formatDateTime(DateTime.now(), 'EEEE, MMMM d');
    notifyListeners();
  }

  String _formatDateTime(DateTime dateTime, String format) {
    final formatter = DateFormat(format);
    return formatter.format(dateTime);
  }

  void isSelected(i) {
    if (state.isSelected == false) {
      state.isSelected = true;
      state.secIndex = i;
      print("sec I: ${state.secIndex}");
    } else {
      state.isSelected = false;
    }
    // print("section Index : ${state.secIndex}");
    notifyListeners();
  }

  void addOrder() {
    int index = state.secIndex;
    int i = state.itemIndex;
    state.secList.add(index);
    state.itemList.add(i);
    state.check.add(Item(name: state.sections[index].items[i].name, price: state.sections[index].items[i].price));
    notifyListeners();
  }

  void addToEdit(int checkIndex){

    int secIndex = state.secList[checkIndex]; //done
    int i = state.itemList[checkIndex]; //done
    state.counterIndex = checkIndex;
    state.counterEdit = state.counter[checkIndex];
    state.edit = Item(name: state.sections[secIndex].items[i].name, price: state.sections[secIndex].items[i].price);

    notifyListeners();
  }

  void onSave(i, context) {
    state.itemIndex = i;

    if(state.counterController.text.isNotEmpty && state.counterController.text != "0"){
      int counterIndex = int.parse(state.counterController.text);
      state.counter.add(counterIndex);
    }else{
      state.counter.add(1);
    }
    addOrder();
    addToEdit(state.check.length - 1);
    total();
    state.counterController.clear();
    Navigator.of(context).pop();
    notifyListeners();
  }

  void delete(){
    if(state.edit.price != 0 && state.edit.name != ""){
      int i = state.counterIndex;
      state.edit = Item(name: '', price: 0);
      state.check.removeAt(i);
      state.counter.removeAt(i);
      state.secList.removeAt(i);
      state.itemList.removeAt(i);
      state.counterEdit = 0;
      state.counterIndex = 0;
      total();
    }
    notifyListeners();
  }

  void total(){
    double count = 0;
    for(int i = 0; i < state.check.length; i++){
        count += state.check[i].price * state.counter[i];
    }
    state.total = count;
    notifyListeners();
  }

  void minus(){
    if(state.counterEdit > 1){
      int i = state.counterIndex;
      state.counterEdit --;
      state.counter[i] = state.counterEdit;
      total();
    }
    notifyListeners();
  }

  void plus(){
    if(state.counterEdit != 0){
      int i = state.counterIndex;
      state.counterEdit ++;
      state.counter[i] = state.counterEdit;
      total();
    }
    notifyListeners();
  }

  void orderDone(){
    for(int i = 0; i < state.check.length; i++){
      state.soldCount[state.secList[i]][state.itemList[i]] += state.counter[i];
    }
    billOff();
    state.check.clear();
    state.edit = Item(name: '', price: 0);
    state.counterEdit = 0;
    state.counterIndex = 0;
    state.counter.clear();
    state.secList.clear();
    state.itemList.clear();
    state.isSelected = false;
    total();
  }

  void billOff(){
      state.order.add([]);
      if(state.order.isEmpty){
        for(int i = 0; i < state.check.length; i++){
          state.order[i].add(OnPrepModel(name: state.check[i].name, count: state.counter[i], total: state.counter[i] * state.check[i].price));
        }
      }else{
        int len = state.order.length - 1;
        for(int i = 0; i < state.check.length; i++){
          state.order[len].add(OnPrepModel(name: state.check[i].name, count: state.counter[i], total: state.counter[i] * state.check[i].price));
        }
      }
  }
  // void reiteration(){
  //   int i = state.counterIndex;
  //   int secIndex = state.secList[i];
  //   int itemIndex = state.itemList[i];
  //   state.counter.add(state.counterEdit);
  //   state.check.add(Item(name: state.sections[secIndex].items[itemIndex].name, price: state.sections[secIndex].items[itemIndex].price));
  //   total();
  //   notifyListeners();
  // }

  // void testReceipt(NetworkPrinter printer) {
  //   printer.text(
  //       'Regular: aA bB cC dD eE fF gG hH iI jJ kK lL mM nN oO pP qQ rR sS tT uU vV wW xX yY zZ');
  //   printer.text('Special 1: àÀ èÈ éÉ ûÛ üÜ çÇ ôÔ');
  //
  //
  //   printer.text('Bold text');
  //   printer.text('Reverse text');
  //
  //
  //   printer.feed(2);
  //   printer.cut();
  // }

  // void saveImageToFile(List<int> imageBytes, String filePath) async {
  //   final imageFile = File(filePath);
  //   await imageFile.create(recursive: true);
  //   await imageFile.writeAsBytes(imageBytes);
  // }
  //
  // Future<void> saveScreen(bill, context) async {
  //   final image = await state.screenController.captureFromWidget(bill(context));
  //   saveImageToFile(image, 'D:\\images\\screenshot.png');
  // }

  Widget bill(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 1.08,
      width: MediaQuery.of(context).size.width / 5,
        margin: const EdgeInsets.only(bottom: 10,left: 10),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: const Color(0xFFF77D8E))),
        child: Column(
          children: [
            //     Image.asset(
            //   "assets/logo/logo.PNG",
            //   scale: 4,
            // ),
                Text(
                  state.timeString.isNotEmpty
                      ? state.timeString
                      : '',
                  style: const TextStyle(
                      fontSize: 20,
                      fontFamily: "Poppins",
                      color: Color(0xFFF77D8E)),
                ),
                const SizedBox(height: 2),
                Text(
                  state.dateString,
                  style:
                  const TextStyle(fontSize: 14, color: Color(0xFFF77D8E)),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 1.4,
                  child: ListView.builder(
                      itemCount: state.check.length,
                      itemBuilder: (ctx, i) {
                        return InkWell(
                          onTap: () {
                            addToEdit(i);
                          },
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    const SizedBox(width: 10,),
                                    Text("ج",style: TextStyle(color: Colors.green.shade800),),
                                    Container(
                                        width: MediaQuery.of(context).size.width / 30,
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "${state.check[i].price * state.counter[i]}",
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                            color: Colors.green.shade800
                                          ),
                                        )),
                                    Container(
                                        width: MediaQuery.of(context).size.width / 45,
                                        alignment: Alignment.center,
                                        child: Text(
                                          "x${state.counter[i]}",
                                          style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                          ),
                                        )),

                                    const SizedBox(width: 10,),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width / 40,
                                      child: Text(
                                        "${state.check[i].price}",
                                        style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width / 11.5,
                                      height: 19,
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        state.check[i].name,
                                        style: const TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600,),
                                      ),
                                    ),

                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                ),
                Center(
                    child: Text(
                      "${state.total}",
                      style: const TextStyle(
                          fontWeight: FontWeight.w800, fontSize: 25),
                    )),
                const Center(
                  child: Text(
                    "TOTAL",
                    style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 16,
                        fontFamily: "Poppins"),
                  ),
                ),
              ],
            ),
    );
  }

  // end shift___________________________________________________

  // Future<void> getSoldItems() async {
  //
  //   for (int i = 0; i < state.soldCount.length; i++) {
  //     ItemSold(name: name, count: count, total: total)
  //   }
  //   notifyListeners();
  // }

}
