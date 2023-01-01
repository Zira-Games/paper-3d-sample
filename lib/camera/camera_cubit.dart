import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'camera_state.dart';

class CameraCubit extends Cubit<CameraState> {

  CameraCubit() : super(const CameraState(CameraDirection.across));

  increment() => emit(CameraState(state.direction.increment()));

  decrement() => emit(CameraState(state.direction.decrement()));

}
