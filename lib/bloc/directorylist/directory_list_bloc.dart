import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:external_path/external_path.dart';
import 'package:justaudioplayer/bloc/directorylist/directory_list_event.dart';
import 'package:justaudioplayer/bloc/directorylist/directory_list_state.dart';
import 'package:justaudioplayer/di/di.dart';
import 'package:justaudioplayer/repository/localrepository/directoryrepository.dart';

class DirectoryListBloc extends Bloc<IDirectoryListEvent, IDirectoryListState> {
  final IDirectoryRepository _repository = locator.get();
  DirectoryListBloc(super.initialState) {
    on<LoadDirectoryListEvent>((event, emit) async {
      emit(LoadDirectoryListState());
      var directoryrepository = await _repository.getdirectoryrepository();
      directoryrepository.fold((error) {
        emit(DirectoryErrorListState(error));
      }, (directoryPaths) {
        emit(DirectoryListState(directoryPaths));
      });
    });
  }
}
