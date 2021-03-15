import 'package:flutter_boilerplate_app/bloc/data_model/splash_data_model.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
//import 'package:path_provider/path_provider.dart' as pathProvider;

// * Add all hive data models here as a constant
// * HiveType between 0 and 223
const int SplashDataModelHiveType = 0;

Future initHive() async {
  // * Path Provider doesn't work with Web
  /*final appDocumentDirectory =
      await pathProvider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);*/
  await Hive.initFlutter();
  registerHiveAdapters();
}

registerHiveAdapters() {
  Hive.registerAdapter(SplashDataModelAdapter());
}

Future openHiveBox({required String boxName}) async {
  return await Hive.openBox('testBox');
}

Future putHiveBox(
    {required Box box, required dynamic key, required dynamic data}) async {
  return await box.put(key, data);
}

Future putHiveBoxAt(
    {required Box box, required int index, required dynamic data}) async {
  return await box.putAt(index, data);
}

Future addHiveBox({required Box box, required dynamic data}) async {
  return await box.add(data);
}

getHiveBox({required Box box, required dynamic key}) {
  return box.get(key);
}

getHiveBoxAt({required Box box, required int index}) {
  return box.getAt(index);
}

Future deleteHiveBox({required Box box, required dynamic key}) async {
  return await box.delete(key);
}

Future deleteHiveBoxAt({required Box box, required int index}) async {
  return box.deleteAt(index);
}

Future closeHiveBox({required Box box}) async {
  return box.close();
}

Future closeAllHiveBox() async {
  return Hive.close();
}
