import 'dart:io';

abstract class IListState {}

class LoadListState extends IListState {}

class ListState extends IListState {
  List<String> directorylist = [];
  ListState(this.directorylist);
}
