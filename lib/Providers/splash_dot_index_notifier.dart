import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'splash_dot_index_notifier.g.dart';

@riverpod
class DotIndex extends _$DotIndex{

  @override
  int build(){
    return 0;
  }

  void changeIndex(int value,{PageController? pagecontroller}){
    state = value;
    pagecontroller!= null ? pagecontroller.animateToPage(value, duration: Duration(milliseconds: 300), curve: Curves.easeInOut): null;
  }
}