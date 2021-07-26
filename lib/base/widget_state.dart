import 'package:get/get.dart';

import 'base_controller.dart';
import 'base_view_view_model.dart';

enum State {
  OK,
  ERROR,
  LOADING
}

class WidgetState {
  Rx<State> _widgetState = State.LOADING.obs;
  Rx<State> stateLoading = State.LOADING.obs;
  Rx<State> stateOk = State.OK.obs;
  Rx<State> stateError = State.ERROR.obs;

  Rx<State> get getWiState => this._widgetState;

  set setWiState(Rx<State> event) => this._widgetState.value = event.value;

  bool get wiStateIsLoading => this._widgetState.value == stateLoading.value;

  bool get wiStateIsOK => this._widgetState.value == stateOk.value;
  
  bool get wiStateIsError => this._widgetState.value == stateError.value;

}


class ScreenState {
  State _screenState = State.LOADING;
  State screenStateLoading = State.LOADING;
  State screenStateOk = State.OK;
  State screenStateError = State.ERROR;

  State get getScreenState => this._screenState;

  set setScreenState(State event) => this._screenState = event;

  bool get screenStateIsLoading => this._screenState == screenStateLoading;

  bool get screenStateIsOK => this._screenState == screenStateOk;

  bool get screenStateIsError => this._screenState == screenStateError;
}