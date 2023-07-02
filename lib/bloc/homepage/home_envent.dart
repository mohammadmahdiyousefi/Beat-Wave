import 'package:flutter/material.dart';

abstract class IHomeEvent {}

class HomeEvent extends IHomeEvent {
  int index;

  HomeEvent(this.index);
}
