// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'categories_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CategoriesState {

 Status get status; String? get errorMessage; List<CategoriesModel> get categories;
/// Create a copy of CategoriesState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CategoriesStateCopyWith<CategoriesState> get copyWith => _$CategoriesStateCopyWithImpl<CategoriesState>(this as CategoriesState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CategoriesState&&(identical(other.status, status) || other.status == status)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&const DeepCollectionEquality().equals(other.categories, categories));
}


@override
int get hashCode => Object.hash(runtimeType,status,errorMessage,const DeepCollectionEquality().hash(categories));

@override
String toString() {
  return 'CategoriesState(status: $status, errorMessage: $errorMessage, categories: $categories)';
}


}

/// @nodoc
abstract mixin class $CategoriesStateCopyWith<$Res>  {
  factory $CategoriesStateCopyWith(CategoriesState value, $Res Function(CategoriesState) _then) = _$CategoriesStateCopyWithImpl;
@useResult
$Res call({
 Status status, String? errorMessage, List<CategoriesModel> categories
});




}
/// @nodoc
class _$CategoriesStateCopyWithImpl<$Res>
    implements $CategoriesStateCopyWith<$Res> {
  _$CategoriesStateCopyWithImpl(this._self, this._then);

  final CategoriesState _self;
  final $Res Function(CategoriesState) _then;

/// Create a copy of CategoriesState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? errorMessage = freezed,Object? categories = null,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as Status,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,categories: null == categories ? _self.categories : categories // ignore: cast_nullable_to_non_nullable
as List<CategoriesModel>,
  ));
}

}


/// Adds pattern-matching-related methods to [CategoriesState].
extension CategoriesStatePatterns on CategoriesState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CategoriesState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CategoriesState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CategoriesState value)  $default,){
final _that = this;
switch (_that) {
case _CategoriesState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CategoriesState value)?  $default,){
final _that = this;
switch (_that) {
case _CategoriesState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Status status,  String? errorMessage,  List<CategoriesModel> categories)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CategoriesState() when $default != null:
return $default(_that.status,_that.errorMessage,_that.categories);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Status status,  String? errorMessage,  List<CategoriesModel> categories)  $default,) {final _that = this;
switch (_that) {
case _CategoriesState():
return $default(_that.status,_that.errorMessage,_that.categories);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Status status,  String? errorMessage,  List<CategoriesModel> categories)?  $default,) {final _that = this;
switch (_that) {
case _CategoriesState() when $default != null:
return $default(_that.status,_that.errorMessage,_that.categories);case _:
  return null;

}
}

}

/// @nodoc


class _CategoriesState implements CategoriesState {
  const _CategoriesState({required this.status, this.errorMessage, required final  List<CategoriesModel> categories}): _categories = categories;
  

@override final  Status status;
@override final  String? errorMessage;
 final  List<CategoriesModel> _categories;
@override List<CategoriesModel> get categories {
  if (_categories is EqualUnmodifiableListView) return _categories;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_categories);
}


/// Create a copy of CategoriesState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CategoriesStateCopyWith<_CategoriesState> get copyWith => __$CategoriesStateCopyWithImpl<_CategoriesState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CategoriesState&&(identical(other.status, status) || other.status == status)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&const DeepCollectionEquality().equals(other._categories, _categories));
}


@override
int get hashCode => Object.hash(runtimeType,status,errorMessage,const DeepCollectionEquality().hash(_categories));

@override
String toString() {
  return 'CategoriesState(status: $status, errorMessage: $errorMessage, categories: $categories)';
}


}

/// @nodoc
abstract mixin class _$CategoriesStateCopyWith<$Res> implements $CategoriesStateCopyWith<$Res> {
  factory _$CategoriesStateCopyWith(_CategoriesState value, $Res Function(_CategoriesState) _then) = __$CategoriesStateCopyWithImpl;
@override @useResult
$Res call({
 Status status, String? errorMessage, List<CategoriesModel> categories
});




}
/// @nodoc
class __$CategoriesStateCopyWithImpl<$Res>
    implements _$CategoriesStateCopyWith<$Res> {
  __$CategoriesStateCopyWithImpl(this._self, this._then);

  final _CategoriesState _self;
  final $Res Function(_CategoriesState) _then;

/// Create a copy of CategoriesState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? errorMessage = freezed,Object? categories = null,}) {
  return _then(_CategoriesState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as Status,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,categories: null == categories ? _self._categories : categories // ignore: cast_nullable_to_non_nullable
as List<CategoriesModel>,
  ));
}


}

// dart format on
