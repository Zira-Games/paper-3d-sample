import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paper_3d/paper_3d.dart';
import 'package:state_machine_animation/state_machine_animation.dart';
import 'package:vector_math/vector_math_64.dart' as vm;

import '../camera/camera_cubit.dart';

class UpAsset extends WorldAsset {

  UpAsset(String id, ScreenSize screenSize, TickerManager tickerManager) : super(
    controller: DefaultAssetController<UpAssetModel>(
      UpAssetModel(id, screenSize),
      tickerManager,
      initialControllerState: const WorldAssetLoaded(0)
    ),
    child: const UpAssetWidget()
  );

}

class UpAssetModel extends WorldAssetModel {

  UpAssetModel(String id, ScreenSize screenSize) : super(
      id,
      screenSize,
      rotateX: pi / 2,
      position: vm.Vector3(0.0, 1.0, 0.0)
  );

  @override
  AnimationModel copyWith(Map<String, dynamic> valueMap) => UpAssetModel(
    valueMap["id"] ?? id,
    valueMap["screenSize"] ?? screenSize,
  );

}

class UpAssetWidget extends StatelessWidget {
  const UpAssetWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.read<CameraCubit>().increment(),
      child: Container(color: Colors.green, child: const Center(
        child: Text("1", style: TextStyle(color: Colors.white, fontSize: 200, decoration: TextDecoration.none)),
      ))
    );
  }
}
