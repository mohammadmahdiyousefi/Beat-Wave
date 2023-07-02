import 'package:flutter/material.dart';

abstract class IHomeState {}

class InitHomeState extends IHomeState {}

class HomeState extends IHomeState {
  int index;

  HomeState(this.index);
}
