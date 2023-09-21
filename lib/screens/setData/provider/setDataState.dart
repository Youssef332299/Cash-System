import 'dart:typed_data';

import 'package:cash/data/model/onPrep/onPrepModel.dart';
import 'package:cash/screens/setData/widgets/onPrep.dart';
import 'package:flutter/cupertino.dart';
import 'package:screenshot/screenshot.dart';
import '../../../data/model/itemSold/itemSoldModel.dart';
import '../../../data/model/section/itemModel.dart';
import '../../../data/model/section/sectionModel.dart';

class SetDataState {

  // sedData __________________________________________________________________

  List<Section> sections = [];
  TextEditingController sectionNameController = TextEditingController();
  TextEditingController priceController       = TextEditingController();
  TextEditingController itemName              = TextEditingController();

  // home _______________________________________________________________________

  int secIndex     = 0;
  int itemIndex    = 0;
  int counterEdit  = 0;
  int counterIndex = 0;
  int purchasesSale = 0;
  double total     = 0;
  double totalSold     = 0;

  late String timeString;
  late String dateString;

  bool isSelected = false;

  List<int> secList = [];
  List<int> itemList = [];
  List<int> counter = [];
  List<String> purchases = [];
  List<Item> check  = [];
  List<List<OnPrepModel>> order = [];

  Item edit = Item(name: "", price: 0);

  TextEditingController counterController = TextEditingController();

  late Uint8List theimageThatComesfromThePrinter ;

  // start shift _______________________________________________________________________
  List<ItemSold> itemSold = [];
  List<List<int>> soldCount = [];

}