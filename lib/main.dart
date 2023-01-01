import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paper_3d/paper_3d.dart';
import 'package:paper_3d_sample/camera/camera_state_machine.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:state_machine_animation/state_machine_animation.dart';
import 'package:uuid/uuid.dart';

import 'assets/across.dart';
import 'assets/back.dart';
import 'assets/down.dart';
import 'assets/up.dart';
import 'camera/camera_animation.dart';
import 'camera/camera_cubit.dart';

void main() {
  final previousCheck = Provider.debugCheckInvalidValueType;
  Provider.debugCheckInvalidValueType = <T>(T value) {
    if (value is BehaviorSubject) return;
    previousCheck!<T>(value);
  };

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: BlocProvider<CameraCubit>(
      create: (context) => CameraCubit(),
      child: const BoxWorld()
    ));
  }
}

class BoxWorld extends StatelessWidget {
  const BoxWorld({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const uuid = Uuid();
    final AppTickerManager tickerManager = AppTickerManager();

    final ScreenSize screenSize = ScreenSize(MediaQuery.of(context).size);
    final BehaviorSubject<Size> screenSubject = BehaviorSubject<Size>.seeded(screenSize.size);

    final cameraCubit = context.read<CameraCubit>();
    final animationStateMachine = CameraAnimationStateMachine(cubitToSubject(cameraCubit), tickerManager);
    final animation = CameraAnimation(animationStateMachine);

    return PaperWorldWidget(
        background: const Color(0xFFAAAAAA),
        camera: animation.output,
        screen: screenSubject,
        assets: [
          UpAsset(uuid.v4(), screenSize, tickerManager),
          DownAsset(uuid.v4(), screenSize, tickerManager),
          AcrossAsset(uuid.v4(), screenSize, tickerManager),
          BackAsset(uuid.v4(), screenSize, tickerManager)
        ]
    );
  }
}


class AppTickerManager implements TickerManager {

  final List<Ticker> _tickers = <Ticker>[];

  @override
  Ticker createTicker(TickerCallback onTick) {
    final ticker = Ticker(onTick);
    _tickers.add(ticker);
    return ticker;
  }

  @override
  void disposeTicker(Ticker ticker){
    ticker.dispose();
    _tickers.remove(ticker);
  }

}