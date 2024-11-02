import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame/particles.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_tokyo_hackathon2024/game/components/moving/moving_component.dart';
import 'package:flutter_tokyo_hackathon2024/game/neko_game.dart';

class MovingOrbTailParticles extends Component with HasGameRef<NekoGame> {
  late Paint particlePaint;

  final double _showEvery = 0.04;
  double _passedFromLastShow = 0;
  final _cachedVector2 = Vector2.zero();

  final opacityTween = Tween(begin: 0.8, end: 0).chain(
    CurveTween(curve: Curves.easeOutQuart),
  );

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    particlePaint = Paint();
  }

  void _generateParticle() {
    if (parent is! MovingOrb) {
      throw Exception('Parent must be of type Orb');
    }
    final parentOrb = parent! as MovingOrb;
    final color = parentOrb.colors.random();
    final randomOrder = parentOrb.colors;
    final colorTween = TweenSequence<Color?>([
      for (int i = 0; i < randomOrder.length - 1; i++)
        TweenSequenceItem(
          weight: 1,
          tween: ColorTween(
            begin: randomOrder[i],
            end: randomOrder[i + 1],
          ),
        ),
    ]);
    final sprite = parentOrb.smallSparkleSprites.random();
    final rnd = parentOrb.rnd;
    game.world.add(
      ParticleSystemComponent(
        position: parentOrb.positionOfAnchor(Anchor.center),
        anchor: Anchor.center,
        particle: Particle.generate(
          lifespan: 1.2,
          count: 2,
          generator: (index) {
            _cachedVector2.setValues(
              (rnd.nextDouble() * 200) - (200 / 2),
              (rnd.nextDouble() * 200) - (200 / 2),
            );
            return AcceleratedParticle(
              acceleration: _cachedVector2,
              child: ComputedParticle(
                renderer: (canvas, particle) {
                  _cachedVector2.setAll(
                    (parentOrb.size.x * parentOrb.trailSizeMultiplier) *
                        (1 - particle.progress),
                  );
                  canvas.rotate(particle.progress * pi * 2);
                  sprite.render(
                    canvas,
                    size: _cachedVector2,
                    anchor: Anchor.center,
                    overridePaint: particlePaint
                      ..colorFilter = ColorFilter.mode(
                        (rnd.nextBool()
                                ? color
                                : colorTween.transform(particle.progress))!
                            .withOpacity(
                          opacityTween.transform(particle.progress).toDouble(),
                        ),
                        BlendMode.srcIn,
                      ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  void update(double dt) {
    if (parent == null) {
      return;
    }
    _passedFromLastShow += dt;
    if (_passedFromLastShow >= _showEvery) {
      _passedFromLastShow = 0.0;
      _generateParticle();
    }
    super.update(dt);
  }
}
