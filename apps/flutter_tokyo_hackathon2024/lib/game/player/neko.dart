import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

import 'package:flame_rive/flame_rive.dart';
import 'package:flame_riverpod/flame_riverpod.dart';
import '../../riverpod/game_state/game_state_notifier.dart';
import '../../riverpod/playing_state.dart';
import '../../riverpod/playing_state_notifier.dart';
import '../components/orb_type.dart';
import '../components/shield.dart';
import '../neko_game.dart';


class Neko extends PositionComponent
    with
        HasGameRef<NekoGame>,
        CollisionCallbacks,
        ParentIsA<MyWorld>, RiverpodComponentMixin {
  Neko({
    double size = 100,
  }) : super(
          size: Vector2.all(size),
          position: Vector2.all(0),
          anchor: Anchor.center,
        );

  late final Shield fireShield;
  late final Shield iceShield;

  double rotationSpeed = 0.0;

  double get radius => size.x / 2;

  /*
  * StateMachine guide:
  * Entry -> Idle
  * Idle -> fire-hit
  * Idle -> ice-hit
  * idle -> heart-hit
  * Idle -> Die -> Respawn
  * Idle -> Scared
  * Idle -> Amazed
  * Scared -> ToIdle
  * Scared -> Die
  * */
  late StateMachineController _controller;
  late SMITrigger fireHitTrigger;
  late SMITrigger iceHitTrigger;
  late SMITrigger heartHitTrigger;
  late SMITrigger dieTrigger;
  late SMITrigger scaredTrigger;
  late SMITrigger toIdleTrigger;
  late SMITrigger amazedTrigger;

  @override
  Future<void> onLoad() async {
    super.onLoad();
    add(CircleHitbox(
      collisionType: CollisionType.active,
      radius: radius * 0.7,
      position: size / 2,
      anchor: Anchor.center,
    ));

    final potatoArtBoard = await loadArtboard(
      RiveFile.asset('assets/rive/potato.riv'),
    );

    _controller = StateMachineController.fromArtboard(
      potatoArtBoard,
      "State Machine 1",
    )!;
    fireHitTrigger = _controller.findInput<bool>('fire-hit') as SMITrigger;
    iceHitTrigger = _controller.findInput<bool>('ice-hit') as SMITrigger;
    heartHitTrigger = _controller.findInput<bool>('heart-hit') as SMITrigger;
    dieTrigger = _controller.findInput<bool>('Die') as SMITrigger;
    scaredTrigger = _controller.findInput<bool>('Scared') as SMITrigger;
    toIdleTrigger = _controller.findInput<bool>('ToIdle') as SMITrigger;
    amazedTrigger = _controller.findInput<bool>('Amazed') as SMITrigger;
    potatoArtBoard.addController(_controller);
    add(RiveComponent(
      artboard: potatoArtBoard,
      size: Vector2.all(152),
      anchor: Anchor.center,
      position: size / 2,
    ));
    add(fireShield = Shield(type: OrbType.fire));
    add(iceShield = Shield(type: OrbType.ice));


    // if (game.playingState.isGuide) {
    //   add(GuideTitle());
    // }

    mounted.then((_) {
     // _lastState = bloc.state;
    });
  }

  @override
  void update(double dt) {
    super.update(dt);
    final playState = ref.watch(playingStateProvider);
    final gameState = ref.watch(gameStateProvider);
 
    if(playState.isNone){
      final rotationSpeed = gameState.shieldsAngleRotationSpeed;

      if(rotationSpeed != 0){
        fireShield.angle += rotationSpeed * dt;
      }
    }

    iceShield.angle = fireShield.angle - pi;
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    // if (other is MovingComponent) {
    //   switch (other) {
    //     case MovingHealth():
    //       getIt.get<AnalyticsHelper>().heartReceived();
    //       _audioHelper.playHeartHitSound();
    //       game.onHealthPointReceived();
    //       heartHitTrigger.fire();
    //     case FireOrb():
    //       _audioHelper.playOrbHitSound();
    //       game.onOrbHit();
    //       if (bloc.state.healthPoints > 0) {
    //         fireHitTrigger.fire();
    //       }
    //     case IceOrb():
    //       _audioHelper.playOrbHitSound();
    //       game.onOrbHit();
    //       if (bloc.state.healthPoints > 0) {
    //         iceHitTrigger.fire();
    //       }
    //   }
      other.removeFromParent();
    
  }

  @override
  void onRemove() {
   // _controller.dispose();
  }
}
