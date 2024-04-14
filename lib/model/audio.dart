import 'package:audioplayers/audioplayers.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'audio.freezed.dart';

@freezed
abstract class Audio with _$Audio {
  const factory Audio({
    @Default('') String wavFile,
    @Default(false) bool isPlaying,
    @Default(null) AudioPlayer? player,
  }) = _Audio;
}