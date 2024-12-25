
import 'package:cloud_firestore/cloud_firestore.dart';

class RewardModel {

  final String title;
  final String? description;
  final double cost;
  final String id;

  RewardModel({
    required this.title,
    required this.cost,
    required this.id,
    this.description,
  });


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['title'] = title;
    data['cost'] = cost;
    data['description'] = description;
    return data;
  }

  factory RewardModel.fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return RewardModel(
        title: snapshot['title'],
        description: snapshot['description'],
        id: snapshot['id'],
        cost: snapshot['cost'],
        );
        
  }

}
