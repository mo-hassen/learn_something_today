import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_user.freezed.dart';

/// A signed-in reader.
@freezed
abstract class AppUser with _$AppUser {
  const factory AppUser({
    required String id,
    required String email,
    required String displayName,
    required DateTime createdAt,
  }) = _AppUser;
}
