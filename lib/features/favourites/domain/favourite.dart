import 'package:freezed_annotation/freezed_annotation.dart';

import '../../articles/domain/article.dart';

part 'favourite.freezed.dart';

/// An article the reader saved, with the text kept so it can be read
/// again later.
@freezed
abstract class Favourite with _$Favourite {
  const factory Favourite({
    required String id,
    required String articleId,
    required Article article,
    required DateTime savedAt,

    /// The signed-in reader who saved it, or null for a guest.
    String? userId,
  }) = _Favourite;
}
