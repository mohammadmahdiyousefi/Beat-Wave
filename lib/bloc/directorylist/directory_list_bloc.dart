import 'package:bloc/bloc.dart';
import 'package:beat_wave/bloc/directorylist/directory_list_event.dart';
import 'package:beat_wave/bloc/directorylist/directory_list_state.dart';
import 'package:beat_wave/di/di.dart';
import 'package:beat_wave/data/repository/localrepository/directoryrepository.dart';

class DirectoryListBloc extends Bloc<DirectoryListEvent, DirectoryListState> {
  final IDirectoryRepository _repository = locator.get();
  DirectoryListBloc() : super(const DirectoryListLoading()) {
    on<GetDirectoryList>((event, emit) async {
      emit(const DirectoryListLoading());
      var directoryrepository = await _repository.getdirectoryrepository();
      directoryrepository.fold((error) {
        emit(const DirectoryListError("Error loading folders"));
      }, (directoryPaths) {
        if (directoryPaths.isEmpty) {
          emit(const DirectoryListEmpty("Unfortunately, no folder was found"));
        } else {
          emit(DirectoryList(directoryPaths));
        }
      });
    });
  }
}
