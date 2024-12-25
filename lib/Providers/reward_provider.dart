
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo/models/reward_model.dart';

final rewardsProvider = StateNotifierProvider<RewardNotifier, List<RewardModel>>((ref) => RewardNotifier());

class RewardNotifier extends StateNotifier<List<RewardModel>>{

  RewardNotifier() : super([]);



}