import 'package:flutter_boilerplate_app/bloc/service/hive_db_manager.dart';
import 'package:hive/hive.dart';
part 'splash_data_model.g.dart';

@HiveType(typeId: SplashDataModelHiveType)
class SplashDataModel extends HiveObject {

  @HiveField(0)
  bool isNew;

  SplashDataModel({required this.isNew});
}