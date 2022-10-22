
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:maleapp/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:rxdart/rxdart.dart';

abstract class BaseViewModel extends BaseViewModelInputs with BaseViewModelOutPuts
{
  final StreamController _inputStreamController=BehaviorSubject<FlowState>();

  @override
  dispose(){
    _inputStreamController.close();
  }


  @override
  Sink get inputState => _inputStreamController.sink;


  @override
  Stream<FlowState> get outputState => _inputStreamController.stream.map((flowState) => flowState);

}

abstract class BaseViewModelInputs
{
  void start();
  void dispose();
  Sink get inputState;
}

abstract class BaseViewModelOutPuts
{
  Stream<FlowState> get outputState;
}