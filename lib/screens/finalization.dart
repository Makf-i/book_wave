import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Finalization extends ConsumerStatefulWidget {
  const Finalization({super.key});

  @override
  ConsumerState<Finalization> createState() => _FinalizationState();
}

class _FinalizationState extends ConsumerState<Finalization> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Finalization'),
      ),
      body: Center(
        child: Text('This is the Finalization Screen'),
      ),
    );
  }
}
