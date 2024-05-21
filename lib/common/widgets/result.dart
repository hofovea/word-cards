import 'package:flutter/material.dart';

enum ResultType { failed, empty }

class Result extends StatelessWidget {
  final ResultType _type;

  const Result({super.key, required ResultType type}) : _type = type;

  const Result.failed({Key? key}) : this(key: key, type: ResultType.failed);

  const Result.empty({Key? key}) : this(key: key, type: ResultType.empty);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Icon(
            switch (_type) {
              ResultType.failed => Icons.clear,
              ResultType.empty => Icons.block,
            },
            size: 200,
            color: switch (_type) {
              ResultType.failed => Colors.red,
              ResultType.empty => Colors.white,
            },
          ),
        ),
        const SizedBox(height: 30),
        switch (_type) {
          ResultType.failed => Text(
              'Failed to get result',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ResultType.empty => Text(
              'Not found',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
            ),
        },
      ],
    );
  }
}
