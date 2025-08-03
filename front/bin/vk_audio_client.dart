import '../lib/vk_api_client.dart';

// https://oauth.vk.com/blank.html#access_token=vk1.a.WYUSJELSx6s38e0ehnS1fyof_o_lo9giD0u_YG_CjBpjPxd2WyFkilV-IkJcBcxAn_Yi_jDnToH2UaP-Qg2QChU2nPm_YVrQBYm-nKTN6wdx9iJTqJKMN8Se1zJHtzQkv9n3n9hYdfi6UgO1XtS0-AJvCJyo97RXYs7uZTCBWPFqRJDzAcAxWb6BeLi_R5Hzo1YgEtpPkZbzbGAJFse3-Q&expires_in=0&user_id=206942551
void main() async {
  // Извлеченный токен из URL
  const token =
      'vk1.a.WYUSJELSx6s38e0ehnS1fyof_o_lo9giD0u_YG_CjBpjPxd2WyFkilV-IkJcBcxAn_Yi_jDnToH2UaP-Qg2QChU2nPm_YVrQBYm-nKTN6wdx9iJTqJKMN8Se1zJHtzQkv9n3n9hYdfi6UgO1XtS0-AJvCJyo97RXYs7uZTCBWPFqRJDzAcAxWb6BeLi_R5Hzo1YgEtpPkZbzbGAJFse3-Q';
  const audioId = '206942551_456240374';

  print('🎵 VK Audio Client Test');
  print('=======================');
  print('');
  print('✅ Using extracted token from URL');
  print('📡 Requesting audio info for: $audioId');
  print('');

  try {
    final client = VkApiClient(token);
    final audio = await client.getSingleAudioById(audioId);

    if (audio != null) {
      print('✅ Audio found:');
      _printAudioInfo(audio);
    } else {
      print('❌ Audio not found or access denied');
      print('');
      print('💡 Possible reasons:');
      print('- Audio ID is incorrect');
      print('- Audio is private or deleted');
      print('- Token doesn\'t have required permissions');
    }
  } catch (error) {
    print('❌ Error: $error');
  }
}

void _printAudioInfo(Map<String, dynamic> audio) {
  final artist = audio['artist'] ?? 'Unknown Artist';
  final title = audio['title'] ?? 'Unknown Title';
  final duration = audio['duration'] ?? 0;
  final url = audio['url'] ?? 'No URL';
  final id = audio['id'] ?? 'Unknown ID';
  final ownerId = audio['owner_id'] ?? 'Unknown Owner';

  final minutes = duration ~/ 60;
  final seconds = duration % 60;
  final durationStr = '${minutes}:${seconds.toString().padLeft(2, '0')}';

  print('''
🎵 $artist - $title
📊 ID: $id
👤 Owner ID: $ownerId
⏱️  Duration: $durationStr
🔗 URL: $url
''');
}
