import 'package:get_it/get_it.dart';
import 'package:todo/service/dialogue_service.dart';

GetIt getIt = GetIt.instance;

void setupLocator(){
  getIt.registerLazySingleton(()=> DialogueService());

}