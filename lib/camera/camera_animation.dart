import 'dart:math';

import 'package:flutter/animation.dart';
import 'package:paper_3d/paper_3d.dart';
import 'package:state_machine_animation/state_machine_animation.dart';
import 'package:vector_math/vector_math_64.dart';

import 'camera_cubit.dart';
import 'camera_state_machine.dart';


class CameraAnimation extends AnimationContainer<CameraState, AwesomeCameraModel> {

  CameraAnimation(CameraAnimationStateMachine stateMachine) :
    super(
      initial: AwesomeCameraModel(0),
      stateMachine: stateMachine,
      defaultCurve: Curves.easeInOutQuad,
      properties: [
        ModdedDoubleAnimationProperty(
          mod: 2 * pi,
          name: "rotationX",
          keyEvaluator: (key, sourceState){
            if ( key == "ACROSS" ) {
              return 0;
            } else if ( key == "UP" ) {
              return pi / 2;
            } else if ( key == "BACK" ) {
              return pi;
            } else if ( key == "DOWN" ) {
              return pi * 3 / 2;
            }
          }
        )
      ]
    );

}


class AwesomeCameraModel extends CameraModel {

  static Vector3 getLookAtVector(double rotationX) =>
      Quaternion.axisAngle(WorldAssetRenderModel.xAxis, rotationX).rotated(Vector3(0.0, 0.0, 1.0));

  static Vector3 getUpVector(double rotationX) =>
      Quaternion.axisAngle(WorldAssetRenderModel.xAxis, rotationX).rotated(Vector3(0.0, -1.0, 0.0));

  final double rotationX;

  AwesomeCameraModel(this.rotationX): super(Vector3.zero(), getLookAtVector(rotationX), getUpVector(rotationX));

  @override
  AwesomeCameraModel copyWith(Map<String, dynamic> valueMap) => AwesomeCameraModel(
    valueMap["rotationX"] ?? rotationX
  );

}
