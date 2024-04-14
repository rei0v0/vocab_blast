import 'package:freezed_annotation/freezed_annotation.dart';

part 'download_file.freezed.dart';

@freezed
abstract class DownloadFile with _$DownloadFile {
  const factory DownloadFile({
    @Default('') String textId,
    @Default('') String type,
    @Default('取得中') String size,
    @Default(false) bool isDownloading,
    @Default(false) bool isExists,
  }) = _DownloadFile;
}