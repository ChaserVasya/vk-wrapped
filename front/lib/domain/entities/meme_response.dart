import 'package:freezed_annotation/freezed_annotation.dart';

part 'generated/meme_response.freezed.dart';
part 'generated/meme_response.g.dart';

@freezed
abstract class MemeResponse with _$MemeResponse {
  const factory MemeResponse({
    @JsonKey(name: 'meme_id') required String memeId,
    required String url,
    @JsonKey(name: 'is_liked') required bool isLiked,
  }) = _MemeResponse;

  factory MemeResponse.fromJson(Map<String, dynamic> json) =>
      _$MemeResponseFromJson(json);
}
