import 'package:flutter/widgets.dart';
import 'package:tourism_app/data/api/api_service.dart';
import 'package:tourism_app/static/tourism_list_result_state.dart';

class TourismListProvider extends ChangeNotifier {
    final ApiService _apiService;

    TourismListProvider(this._apiService);

    TourismListResultState _resulteState = TourismListNoneState();

    TourismListResultState get resultState => _resulteState;

    Future<void> fetchTourismList() async {
      try {
        _resulteState = TourismListLoadingState();
        notifyListeners();

        final result = await _apiService.getTourismList();

        if (result.error) {
          _resulteState = TourismListErrorState(result.message);
          notifyListeners();
        } else {
          _resulteState = TourismListLoadedState(result.places);
          notifyListeners();
        }
      } on Exception catch (e) {
        _resulteState = TourismListErrorState(e.toString());
        notifyListeners();
      }
    }
}