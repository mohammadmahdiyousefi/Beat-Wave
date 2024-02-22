import 'package:equatable/equatable.dart';

abstract class DirectoryListState extends Equatable {
  const DirectoryListState();
  @override
  List<Object> get props => [];
}

final class DirectoryListLoading extends DirectoryListState {
  const DirectoryListLoading();
  @override
  List<Object> get props => [];
}

final class DirectoryList extends DirectoryListState {
  final List<String> directorylist;
  const DirectoryList(this.directorylist);
  @override
  List<Object> get props => [directorylist];
}

final class DirectoryListEmpty extends DirectoryListState {
  final String empty;
  const DirectoryListEmpty(this.empty);
  @override
  List<Object> get props => [empty];
}

final class DirectoryListError extends DirectoryListState {
  final String error;
  const DirectoryListError(this.error);
  @override
  List<Object> get props => [error];
}
