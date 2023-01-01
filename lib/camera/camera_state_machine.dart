import 'package:rxdart/rxdart.dart';
import 'package:state_machine_animation/state_machine_animation.dart';
import '../main.dart';
import 'camera_cubit.dart';

class CameraAnimationStateMachine extends AnimationStateMachine<CameraState> {

  CameraAnimationStateMachine(BehaviorSubject<CameraState> source, AppTickerManager tickerManager)
      : super(source, tickerManager);

  @override bool isReady(CameraState state) => true;

  @override
  AnimationStateMachineConfig<CameraState> getConfig(CameraState state) =>
      const AnimationStateMachineConfig(
          defaultDuration: 600,
          nodes: ["UP","DOWN","BACK","ACROSS"],
          initialState: Idle("ACROSS")
      );

  @override
  void reactToStateChanges(state, previous) {
    transitionTo(Idle(state.direction.name.toUpperCase()));
  }

}