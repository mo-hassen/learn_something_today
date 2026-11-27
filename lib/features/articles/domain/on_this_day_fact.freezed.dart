// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'on_this_day_fact.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$OnThisDayFact {

 String get id; int get year; int get month; int get day; String get text; ArticleLanguage get language;/// The article that tells more, when there is one.
 String? get relatedArticleId;
/// Create a copy of OnThisDayFact
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OnThisDayFactCopyWith<OnThisDayFact> get copyWith => _$OnThisDayFactCopyWithImpl<OnThisDayFact>(this as OnThisDayFact, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OnThisDayFact&&(identical(other.id, id) || other.id == id)&&(identical(other.year, year) || other.year == year)&&(identical(other.month, month) || other.month == month)&&(identical(other.day, day) || other.day == day)&&(identical(other.text, text) || other.text == text)&&(identical(other.language, language) || other.language == language)&&(identical(other.relatedArticleId, relatedArticleId) || other.relatedArticleId == relatedArticleId));
}


@override
int get hashCode => Object.hash(runtimeType,id,year,month,day,text,language,relatedArticleId);

@override
String toString() {
  return 'OnThisDayFact(id: $id, year: $year, month: $month, day: $day, text: $text, language: $language, relatedArticleId: $relatedArticleId)';
}


}

/// @nodoc
abstract mixin class $OnThisDayFactCopyWith<$Res>  {
  factory $OnThisDayFactCopyWith(OnThisDayFact value, $Res Function(OnThisDayFact) _then) = _$OnThisDayFactCopyWithImpl;
@useResult
$Res call({
 String id, int year, int month, int day, String text, ArticleLanguage language, String? relatedArticleId
});




}
/// @nodoc
class _$OnThisDayFactCopyWithImpl<$Res>
    implements $OnThisDayFactCopyWith<$Res> {
  _$OnThisDayFactCopyWithImpl(this._self, this._then);

  final OnThisDayFact _self;
  final $Res Function(OnThisDayFact) _then;

/// Create a copy of OnThisDayFact
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? year = null,Object? month = null,Object? day = null,Object? text = null,Object? language = null,Object? relatedArticleId = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,year: null == year ? _self.year : year // ignore: cast_nullable_to_non_nullable
as int,month: null == month ? _self.month : month // ignore: cast_nullable_to_non_nullable
as int,day: null == day ? _self.day : day // ignore: cast_nullable_to_non_nullable
as int,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,language: null == language ? _self.language : language // ignore: cast_nullable_to_non_nullable
as ArticleLanguage,relatedArticleId: freezed == relatedArticleId ? _self.relatedArticleId : relatedArticleId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [OnThisDayFact].
extension OnThisDayFactPatterns on OnThisDayFact {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OnThisDayFact value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OnThisDayFact() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OnThisDayFact value)  $default,){
final _that = this;
switch (_that) {
case _OnThisDayFact():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OnThisDayFact value)?  $default,){
final _that = this;
switch (_that) {
case _OnThisDayFact() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  int year,  int month,  int day,  String text,  ArticleLanguage language,  String? relatedArticleId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OnThisDayFact() when $default != null:
return $default(_that.id,_that.year,_that.month,_that.day,_that.text,_that.language,_that.relatedArticleId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  int year,  int month,  int day,  String text,  ArticleLanguage language,  String? relatedArticleId)  $default,) {final _that = this;
switch (_that) {
case _OnThisDayFact():
return $default(_that.id,_that.year,_that.month,_that.day,_that.text,_that.language,_that.relatedArticleId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  int year,  int month,  int day,  String text,  ArticleLanguage language,  String? relatedArticleId)?  $default,) {final _that = this;
switch (_that) {
case _OnThisDayFact() when $default != null:
return $default(_that.id,_that.year,_that.month,_that.day,_that.text,_that.language,_that.relatedArticleId);case _:
  return null;

}
}

}

/// @nodoc


class _OnThisDayFact extends OnThisDayFact {
  const _OnThisDayFact({required this.id, required this.year, required this.month, required this.day, required this.text, required this.language, this.relatedArticleId}): super._();
  

@override final  String id;
@override final  int year;
@override final  int month;
@override final  int day;
@override final  String text;
@override final  ArticleLanguage language;
/// The article that tells more, when there is one.
@override final  String? relatedArticleId;

/// Create a copy of OnThisDayFact
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OnThisDayFactCopyWith<_OnThisDayFact> get copyWith => __$OnThisDayFactCopyWithImpl<_OnThisDayFact>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OnThisDayFact&&(identical(other.id, id) || other.id == id)&&(identical(other.year, year) || other.year == year)&&(identical(other.month, month) || other.month == month)&&(identical(other.day, day) || other.day == day)&&(identical(other.text, text) || other.text == text)&&(identical(other.language, language) || other.language == language)&&(identical(other.relatedArticleId, relatedArticleId) || other.relatedArticleId == relatedArticleId));
}


@override
int get hashCode => Object.hash(runtimeType,id,year,month,day,text,language,relatedArticleId);

@override
String toString() {
  return 'OnThisDayFact(id: $id, year: $year, month: $month, day: $day, text: $text, language: $language, relatedArticleId: $relatedArticleId)';
}


}

/// @nodoc
abstract mixin class _$OnThisDayFactCopyWith<$Res> implements $OnThisDayFactCopyWith<$Res> {
  factory _$OnThisDayFactCopyWith(_OnThisDayFact value, $Res Function(_OnThisDayFact) _then) = __$OnThisDayFactCopyWithImpl;
@override @useResult
$Res call({
 String id, int year, int month, int day, String text, ArticleLanguage language, String? relatedArticleId
});




}
/// @nodoc
class __$OnThisDayFactCopyWithImpl<$Res>
    implements _$OnThisDayFactCopyWith<$Res> {
  __$OnThisDayFactCopyWithImpl(this._self, this._then);

  final _OnThisDayFact _self;
  final $Res Function(_OnThisDayFact) _then;

/// Create a copy of OnThisDayFact
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? year = null,Object? month = null,Object? day = null,Object? text = null,Object? language = null,Object? relatedArticleId = freezed,}) {
  return _then(_OnThisDayFact(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,year: null == year ? _self.year : year // ignore: cast_nullable_to_non_nullable
as int,month: null == month ? _self.month : month // ignore: cast_nullable_to_non_nullable
as int,day: null == day ? _self.day : day // ignore: cast_nullable_to_non_nullable
as int,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,language: null == language ? _self.language : language // ignore: cast_nullable_to_non_nullable
as ArticleLanguage,relatedArticleId: freezed == relatedArticleId ? _self.relatedArticleId : relatedArticleId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
