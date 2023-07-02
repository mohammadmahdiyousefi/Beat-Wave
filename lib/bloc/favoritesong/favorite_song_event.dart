abstract class IFavoriteSongeEvent {}

class FavoriteSongeEvent extends IFavoriteSongeEvent {}

class AddFavoriteSongeEvent extends IFavoriteSongeEvent {
  String favoritesong;
  AddFavoriteSongeEvent(this.favoritesong);
}

class DeleteFavoriteSongeEvent extends IFavoriteSongeEvent {
  String favoritesong;
  DeleteFavoriteSongeEvent(this.favoritesong);
}
