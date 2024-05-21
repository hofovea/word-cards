import 'package:flutter/material.dart';
import 'package:word_cards/generated/assets.gen.dart';

enum AssetButtonType { next, back }

class AssetButton extends StatefulWidget {
  final AssetButtonType _type;

  final VoidCallback onClick;

  const AssetButton({
    super.key,
    required AssetButtonType type,
    required this.onClick,
  }) : _type = type;

  const AssetButton.next({
    Key? key,
    required VoidCallback onClick,
  }) : this(key: key, onClick: onClick, type: AssetButtonType.next);

  const AssetButton.back({
    Key? key,
    required VoidCallback onClick,
  }) : this(key: key, onClick: onClick, type: AssetButtonType.back);

  @override
  State<AssetButton> createState() => _AssetButtonState();
}

class _AssetButtonState extends State<AssetButton> with TickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: const Duration(milliseconds: 150), vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onClick,
      onTapDown: (_) {
        _controller.forward();
      },
      onTapUp: (_) {
        _controller.reverse();
      },
      onTapCancel: () {
        _controller.reverse();
      },
      child: ScaleTransition(
        scale: Tween(begin: 1.0, end: 0.95).animate(
          CurvedAnimation(parent: _controller, curve: Curves.easeIn),
        ),
        child: switch (widget._type) {
          AssetButtonType.next => Assets.ui.uiButtonNext.image(),
          AssetButtonType.back => Assets.ui.uiButtonBack.image(),
        },
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
