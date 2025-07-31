import 'package:dio/dio.dart';

void main() async {
  const state = 'blablabla123fdsfjasd@#@#';
  const codeVerifier = 'fdslfjs_dlfjewiophvn_3423423';

  final dio = Dio();

  final commonKeys = {
    'client_id': '53128792',
    'state': state,
    'scope': 'status',
  };

  //https://id.vk.com/about/business/go/docs/ru/vkid/latest/vk-id/connection/api-integration/api-description#Zapros-koda-podtverzhdeniya-i-rabota-s-formoj-razresheniya-dostupov-polzovatelya
  final req = await dio.getUri(Uri.https(
    'id.vk.com',
    '/authorize',
    {
      ...commonKeys,
      'response_type': 'code',
      'grant_type': 'authorization_code',
      'code_challenge_method': 'S256',
      'code_challenge': codeVerifier,
      'redirect_uri': 'stub',
      'promp': 'none',
    },
  ));

  print(req);

  if (false)
    dio.getUri(
      Uri.https(
        'id.vk.com',
        '/oauth2/auth',
        {
          ...commonKeys,
          'device_id': '???',
          'grant_type': 'authorization_code',
          'code_verifier': codeVerifier,
        },
      ),
      options: Options(
        contentType: 'application/x-www-form-urlencoded',
      ),
    );
}
