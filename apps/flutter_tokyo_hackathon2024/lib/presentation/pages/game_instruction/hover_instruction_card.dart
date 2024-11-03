import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'dart:math' as math;

class HoverInstructionCard extends StatefulWidget {
  const HoverInstructionCard({
    super.key,
    required this.assetPath,
    required this.description,
    required this.size,
  });

  final String assetPath;
  final String description;
  final double size;

  @override
  State<HoverInstructionCard> createState() => _HoverInstructionCardState();
}

class _HoverInstructionCardState extends State<HoverInstructionCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  double _dragPosition = 0;
  bool _isDragging = false;
  bool _showingFront = true;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onHorizontalDragStart(DragStartDetails details) {
    setState(() => _isDragging = true);
  }

  void _onHorizontalDragUpdate(DragUpdateDetails details) {
    setState(() {
      _dragPosition += details.delta.dx;
      // 드래그 위치를 0-1 사이의 값으로 정규화
      _controller.value =
          (_dragPosition.abs() / (widget.size * 0.8)).clamp(0.0, 1.0);
    });
  }

  void _onHorizontalDragEnd(DragEndDetails details) {
    setState(() => _isDragging = false);

    // 드래그가 절반 이상 진행되었다면 카드 상태 변경
    if (_controller.value > 0.5) {
      _controller.forward().then((_) {
        setState(() => _showingFront = !_showingFront);
        _controller.value = 0.0;
      });
    } else {
      _controller.reverse();
    }
    _dragPosition = 0.0;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragStart: _onHorizontalDragStart,
      onHorizontalDragUpdate: _onHorizontalDragUpdate,
      onHorizontalDragEnd: _onHorizontalDragEnd,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          final rotation = _controller.value * math.pi;
          return Transform(
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001)
              ..rotateY(rotation),
            alignment: Alignment.center,
            child: SizedBox(
              width: widget.size,
              height: widget.size,
              child: rotation < math.pi / 2
                  ? (_showingFront ? _buildFrontSide() : _buildBackSide())
                  : Transform(
                      transform: Matrix4.identity()..rotateY(math.pi),
                      alignment: Alignment.center,
                      child: (_showingFront
                          ? _buildBackSide()
                          : _buildFrontSide()),
                    ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildFrontSide() {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          children: [
            Center(
              child: widget.assetPath.endsWith('.json')
                  ? Lottie.asset(
                      widget.assetPath,
                      width: widget.size * 0.8,
                      height: widget.size * 0.8,
                      fit: BoxFit.contain,
                    )
                  : Image.asset(
                      widget.assetPath,
                      width: widget.size * 0.8,
                      height: widget.size * 0.8,
                      fit: BoxFit.contain,
                    ),
            ),
            if (!_isDragging)
              Positioned(
                left: 0,
                right: 0,
                bottom: 8,
                child: Icon(
                  Icons.swipe,
                  color: Colors.black.withOpacity(0.5),
                  size: 24,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildBackSide() {
    final theme = Theme.of(context);

    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                theme.colorScheme.primary,
                theme.colorScheme.secondary,
              ],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.description,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              if (!_isDragging)
                const Icon(
                  Icons.swipe,
                  color: Colors.white,
                  size: 24,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
