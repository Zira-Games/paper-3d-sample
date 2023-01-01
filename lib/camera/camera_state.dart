part of 'camera_cubit.dart';

class CameraState extends Equatable {
  final CameraDirection direction;

  const CameraState(this.direction);

  @override List<Object?> get props => [direction];
}

enum CameraDirection {
  across(0),
  up(1),
  back(2),
  down(3);

  final int order;
  const CameraDirection(this.order);

  CameraDirection increment() => CameraDirection.values[(index - 1) % 4];
  CameraDirection decrement() => CameraDirection.values[(index + 1) % 4];
}

