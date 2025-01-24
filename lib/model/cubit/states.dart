abstract class TravelState {}

class TravelInitialState extends TravelState {}

class TravelBottomnavBarState extends TravelState {}

class TravelGetDataLoadingState extends TravelState {}

class TravelGetDataSuccessState extends TravelState {
  final List<dynamic> Recipe;
  TravelGetDataSuccessState(this.Recipe);
}

class TravelGetDataErrorState extends TravelState {
  final String error;
  TravelGetDataErrorState(this.error);
}

class TravelGetSearchLodingState extends TravelState {}
class TravelGetSearchEmptyState extends TravelState {}


class TravelGetSearchSuccessState extends TravelState {}

class TravelErrorState extends TravelState {
  final String error;

  TravelErrorState({required this.error});
}

class AppChangeModeState extends TravelState {
  final bool isDark;

  AppChangeModeState(this.isDark);
}
