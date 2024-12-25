import 'package:flutter_riverpod/flutter_riverpod.dart';

final coinsProvider = StateNotifierProvider<CoinsNotifier,double>((ref) => CoinsNotifier());

class CoinsNotifier extends StateNotifier<double>{

  CoinsNotifier() : super(0);
  
  Future<void> taskReward({double reward = 10})async{
    state += reward;
  }

}