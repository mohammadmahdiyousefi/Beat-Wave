abstract class IDirectoryListState {}

class LoadDirectoryListState extends IDirectoryListState {}

class DirectoryListState extends IDirectoryListState {
  List<String> directorylist;
  DirectoryListState(this.directorylist);
}

class DirectoryErrorListState extends IDirectoryListState {
  String error;
  DirectoryErrorListState(this.error);
}
