import 'package:comments/common/domain/failure.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final failureProvider = StateProvider<Failure?>((_) => null);
final successMessageProvider = StateProvider<String?>((_) => null);
