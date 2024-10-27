import 'package:get_it/get_it.dart';
import 'package:todo/service/dialogue_service.dart';
import 'package:todo/service/startup_service.dart';
import 'package:todo/service/storage_service.dart';

GetIt getIt = GetIt.instance;

void setupLocator(){
  getIt.registerLazySingleton(()=> DialogueService());
  //getIt.registerLazySingleton(()=> StorageService());
  getIt.registerLazySingleton(()=> StartupService());

}