import 'dart:math';

import 'package:flutter/material.dart';
import 'package:paper_3d/paper_3d.dart';
import 'package:provider/provider.dart';
import 'package:state_machine_animation/state_machine_animation.dart';
import 'package:vector_math/vector_math_64.dart' as vm;

import '../camera/camera_cubit.dart';

class DownAsset extends WorldAsset {

  DownAsset(String id, ScreenSize screenSize, TickerManager tickerManager) : super(
      controller: DefaultAssetController<DownAssetModel>(
          DownAssetModel(id, screenSize),
          tickerManager,
          initialControllerState: const WorldAssetLoaded(0)
      ),
      child: const DownAssetWidget()
  );

}

class DownAssetModel extends WorldAssetModel {

  DownAssetModel(String id, ScreenSize screenSize) : super(
      id,
      screenSize,
      rotateX: pi / 2,
      position: vm.Vector3(0.0, -1.0, 0.0)
  );


  @override
  AnimationModel copyWith(Map<String, dynamic> valueMap) => DownAssetModel(
    valueMap["id"] ?? id,
    valueMap["screenSize"] ?? screenSize,
  );

}


class DownAssetWidget extends StatelessWidget {
  const DownAssetWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.read<CameraCubit>().increment(),
      child: Container(
        color: Colors.blue,
        child: const Center(
          child: Text("3", style: TextStyle(color: Colors.white, fontSize: 200, decoration: TextDecoration.none)),
        )
      )
    );
  }
}
