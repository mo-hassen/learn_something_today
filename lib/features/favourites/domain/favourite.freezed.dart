// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'favourite.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Favourite {

 String get id; String get articleId; Article get article; DateTime get savedAt;/// The signed-in reader who saved it, or null for a guest.
 String? get userId;
/// Create a copy of Favourite
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FavouriteCopyWith<Favourite> get copyWith => _$FavouriteCopyWithImpl<Favourite>(this as Favourite, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Favourite&&(identical(other.id, id) || other.id == id)&&(identical(other.articleId, articleId) || other.articleId == articleId)&&(identical(other.article, article) || other.article == article)&&(identical(other.savedAt, savedAt) || other.savedAt == savedAt)&&(identical(other.userId, userId) || other.userId == userId));
}


@override
int get hashCode => Object.hash(runtimeType,id,articleId,article,savedAt,userId);

@override
String toString() {
  return 'Favourite(id: $id, articleId: $articleId, article: $article, savedAt: $savedAt, userId: $userId)';
}


}

/// @nodoc
abstract mixin class $FavouriteCopyWith<$Res>  {
  factory $FavouriteCopyWith(Favourite value, $Res Function(Favourite) _then) = _$FavouriteCopyWithImpl;
@useResult
$Res call({
 String id, String articleId, Article article, DateTime savedAt, String? userId
});


$ArticleCopyWith<$Res> get article;

}
/// @nodoc
class _$FavouriteCopyWithImpl<$Res>
    implements $FavouriteCopyWith<$Res> {
  _$FavouriteCopyWithImpl(this._self, this._then);

  final Favourite _self;
  final $Res Function(Favourite) _then;

/// Create a copy of Favourite
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? articleId = null,Object? article = null,Object? savedAt = null,Object? userId = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,articleId: null == articleId ? _self.articleId : articleId // ignore: cast_nullable_to_non_nullable
as String,article: null == article ? _self.article : article // ignore: cast_nullable_to_non_nullable
as Article,savedAt: null == savedAt ? _self.savedAt : savedAt // ignore: cast_nullable_to_non_nullable
as DateTime,userId: freezed == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of Favourite
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ArticleCopyWith<$Res> get article {
  
  return $ArticleCopyWith<$Res>(_self.article, (value) {
    return _then(_self.copyWith(article: value));
  });
}
}


/// Adds pattern-matching-related methods to [Favourite].
extension FavouritePatterns on Favourite {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Favourite value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Favourite() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Favourite value)  $default,){
final _that = this;
switch (_that) {
case _Favourite():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Favourite value)?  $default,){
final _that = this;
switch (_that) {
case _Favourite() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String articleId,  Article article,  DateTime savedAt,  String? userId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Favourite() when $default != null:
return $default(_that.id,_that.articleId,_that.article,_that.savedAt,_that.userId);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String articleId,  Article article,  DateTime savedAt,  String? userId)  $default,) {final _that = this;
switch (_that) {
case _Favourite():
return $default(_that.id,_that.articleId,_that.article,_that.savedAt,_that.userId);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String articleId,  Article article,  DateTime savedAt,  String? userId)?  $default,) {final _that = this;
switch (_that) {
case _Favourite() when $default != null:
return $default(_that.id,_that.articleId,_that.article,_that.savedAt,_that.userId);case _:
  return null;

}
}

}

/// @nodoc


class _Favourite implements Favourite {
  const _Favourite({required this.id, required this.articleId, required this.article, required this.savedAt, this.userId});
  

@override final  String id;
@override final  String articleId;
@override final  Article article;
@override final  DateTime savedAt;
/// The signed-in reader who saved it, or null for a guest.
@override final  String? userId;

/// Create a copy of Favourite
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FavouriteCopyWith<_Favourite> get copyWith => __$FavouriteCopyWithImpl<_Favourite>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Favourite&&(identical(other.id, id) || other.id == id)&&(identical(other.articleId, articleId) || other.articleId == articleId)&&(identical(other.article, article) || other.article == article)&&(identical(other.savedAt, savedAt) || other.savedAt == savedAt)&&(identical(other.userId, userId) || other.userId == userId));
}


@override
int get hashCode => Object.hash(runtimeType,id,articleId,article,savedAt,userId);

@override
String toString() {
  return 'Favourite(id: $id, articleId: $articleId, article: $article, savedAt: $savedAt, userId: $userId)';
}


}

/// @nodoc
abstract mixin class _$FavouriteCopyWith<$Res> implements $FavouriteCopyWith<$Res> {
  factory _$FavouriteCopyWith(_Favourite value, $Res Function(_Favourite) _then) = __$FavouriteCopyWithImpl;
@override @useResult
$Res call({
 String id, String articleId, Article article, DateTime savedAt, String? userId
});


@override $ArticleCopyWith<$Res> get article;

}
/// @nodoc
class __$FavouriteCopyWithImpl<$Res>
    implements _$FavouriteCopyWith<$Res> {
  __$FavouriteCopyWithImpl(this._self, this._then);

  final _Favourite _self;
  final $Res Function(_Favourite) _then;

/// Create a copy of Favourite
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? articleId = null,Object? article = null,Object? savedAt = null,Object? userId = freezed,}) {
  return _then(_Favourite(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,articleId: null == articleId ? _self.articleId : articleId // ignore: cast_nullable_to_non_nullable
as String,article: null == article ? _self.article : article // ignore: cast_nullable_to_non_nullable
as Article,savedAt: null == savedAt ? _self.savedAt : savedAt // ignore: cast_nullable_to_non_nullable
as DateTime,userId: freezed == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of Favourite
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ArticleCopyWith<$Res> get article {
  
  return $ArticleCopyWith<$Res>(_self.article, (value) {
    return _then(_self.copyWith(article: value));
  });
}
}

// dart format on
