import 'package:flutter/material.dart';

class LoaderBody extends StatelessWidget {
  const LoaderBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
