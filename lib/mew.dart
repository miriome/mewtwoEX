import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

class Mew {
  static final pc = ProviderContainer();
  static final tabPrimaryScrollControllers = List.generate(5, (index) => ScrollController());
}