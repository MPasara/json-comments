import 'package:comments/common/data/api_client.dart';
import 'package:comments/common/utils/constants/api_path_constants.dart';
import 'package:dio/dio.dart';
import 'package:flutter_loggy_dio/flutter_loggy_dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final apiClientProvider = Provider<ApiClient>(
  (ref) => ApiClient(ref.watch(dioProvider(ApiPathConstants.baseUrl))),
  name: 'Api Client Provider',
);

final dioProvider = Provider.family<Dio, String>((ref, baseUrl) {
  final dio = Dio(BaseOptions(baseUrl: baseUrl));
  dio.interceptors.addAll([
    LoggyDioInterceptor(requestBody: true, requestHeader: true),
  ]);
  return dio;
}, name: 'Dio provider');
