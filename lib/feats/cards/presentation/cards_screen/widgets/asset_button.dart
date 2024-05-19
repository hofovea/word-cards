import 'package:flutter/material.dart';
import 'package:word_cards/generated/assets.gen.dart';
import 'package:word_cards/common/common.dart';

enum AssetButtonType { next, back }

class AssetButton extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: switch (_type) {
        AssetButtonType.next => Assets.ui.uiButtonNext.image(),
        AssetButtonType.back => Assets.ui.uiButtonBack.image(),
      },
    );
  }
}
