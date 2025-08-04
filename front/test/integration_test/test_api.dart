import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart' hide Matcher;
import 'package:dio/dio.dart';
import 'package:front/domain/entities/audio_track.dart';

import 'meta.dart';

export 'package:flutter/material.dart' show Icons, Icon, debugDumpApp;

set api(TestApi api) => _api = api;
TestApi get api => _api;
late TestApi _api;

class TestApi {
  TestApi(this.network, this._dir);

  final DioAdapter network;
  final Directory _dir;

  /// Read JSON from the file.
  /// [fileRelativePath] is the path relative to the `integration_test` folder.
  Future<dynamic> readJson(String fileRelativePath) async {
    final path = '${_dir.path}/test/integration_test/$fileRelativePath';
    var input = await File(path).readAsString();
    return jsonDecode(input);
  }
}

typedef PathParams = Map<String, String>;

extension PathParamsRequestOptions on RequestOptions {
  PathParams pathParams() => uri.pathParams();
}

extension PathParamsUri on Uri {
  PathParams pathParams() {
    final segments = pathSegments;
    final params = <String, String>{};

    if (segments.length < 2) {
      return params;
    }
    for (var i = 0; i < segments.length; i++) {
      if (i > 0 && RegExp(r'^\d+$').hasMatch(segments[i])) {
        params[segments[i - 1]] = segments[i];
      }
    }

    return params;
  }
}

class RequestTracker {
  int callCount = 0;

  MockDataCallback call([MockDataCallback? fn]) => (opts) {
    callCount++;
    if (fn == null) {
      return (_) {};
    }
    return fn(opts);
  };
}

Matcher isCalled([int times = 1]) => isA<RequestTracker>().having(
  (tracker) => tracker.callCount,
  'callCount',
  times,
);

typedef MockDataCallback = dynamic Function(RequestOptions options);
