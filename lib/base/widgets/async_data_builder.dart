import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AsyncDataBuilder<T> extends StatelessWidget {
  final AsyncValue<T> data;
  final Widget Function(T data) dataBuilder;
const AsyncDataBuilder({ Key? key, required this.data, required this.dataBuilder }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return data.when(data: dataBuilder, error: (e, s) => const SizedBox.shrink(), loading: () => const Center(child: CircularProgressIndicator(),));
  }
}