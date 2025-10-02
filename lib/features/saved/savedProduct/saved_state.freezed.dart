// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'saved_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SavedProductsState {

 Status get status; String? get errorMessage; List<SavedProductModel> get savedProducts;
/// Create a copy of SavedProductsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SavedProductsStateCopyWith<SavedProductsState> get copyWith => _$SavedProductsStateCopyWithImpl<SavedProductsState>(this as SavedProductsState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SavedProductsState&&(identical(other.status, status) || other.status == status)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&const DeepCollectionEquality().equals(other.savedProducts, savedProducts));
}


@override
int get hashCode => Object.hash(runtimeType,status,errorMessage,const DeepCollectionEquality().hash(savedProducts));

@override
String toString() {
  return 'SavedProductsState(status: $status, errorMessage: $errorMessage, savedProducts: $savedProducts)';
}


}

/// @nodoc
abstract mixin class $SavedProductsStateCopyWith<$Res>  {
  factory $SavedProductsStateCopyWith(SavedProductsState value, $Res Function(SavedProductsState) _then) = _$SavedProductsStateCopyWithImpl;
@useResult
$Res call({
 Status status, String? errorMessage, List<SavedProductModel> savedProducts
});




}
/// @nodoc
class _$SavedProductsStateCopyWithImpl<$Res>
    implements $SavedProductsStateCopyWith<$Res> {
  _$SavedProductsStateCopyWithImpl(this._self, this._then);

  final SavedProductsState _self;
  final $Res Function(SavedProductsState) _then;

/// Create a copy of SavedProductsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? errorMessage = freezed,Object? savedProducts = null,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as Status,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,savedProducts: null == savedProducts ? _self.savedProducts : savedProducts // ignore: cast_nullable_to_non_nullable
as List<SavedProductModel>,
  ));
}

}


/// Adds pattern-matching-related methods to [SavedProductsState].
extension SavedProductsStatePatterns on SavedProductsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SavedProductsState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SavedProductsState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SavedProductsState value)  $default,){
final _that = this;
switch (_that) {
case _SavedProductsState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SavedProductsState value)?  $default,){
final _that = this;
switch (_that) {
case _SavedProductsState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Status status,  String? errorMessage,  List<SavedProductModel> savedProducts)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SavedProductsState() when $default != null:
return $default(_that.status,_that.errorMessage,_that.savedProducts);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Status status,  String? errorMessage,  List<SavedProductModel> savedProducts)  $default,) {final _that = this;
switch (_that) {
case _SavedProductsState():
return $default(_that.status,_that.errorMessage,_that.savedProducts);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Status status,  String? errorMessage,  List<SavedProductModel> savedProducts)?  $default,) {final _that = this;
switch (_that) {
case _SavedProductsState() when $default != null:
return $default(_that.status,_that.errorMessage,_that.savedProducts);case _:
  return null;

}
}

}

/// @nodoc


class _SavedProductsState implements SavedProductsState {
  const _SavedProductsState({required this.status, this.errorMessage, required final  List<SavedProductModel> savedProducts}): _savedProducts = savedProducts;
  

@override final  Status status;
@override final  String? errorMessage;
 final  List<SavedProductModel> _savedProducts;
@override List<SavedProductModel> get savedProducts {
  if (_savedProducts is EqualUnmodifiableListView) return _savedProducts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_savedProducts);
}


/// Create a copy of SavedProductsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SavedProductsStateCopyWith<_SavedProductsState> get copyWith => __$SavedProductsStateCopyWithImpl<_SavedProductsState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SavedProductsState&&(identical(other.status, status) || other.status == status)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&const DeepCollectionEquality().equals(other._savedProducts, _savedProducts));
}


@override
int get hashCode => Object.hash(runtimeType,status,errorMessage,const DeepCollectionEquality().hash(_savedProducts));

@override
String toString() {
  return 'SavedProductsState(status: $status, errorMessage: $errorMessage, savedProducts: $savedProducts)';
}


}

/// @nodoc
abstract mixin class _$SavedProductsStateCopyWith<$Res> implements $SavedProductsStateCopyWith<$Res> {
  factory _$SavedProductsStateCopyWith(_SavedProductsState value, $Res Function(_SavedProductsState) _then) = __$SavedProductsStateCopyWithImpl;
@override @useResult
$Res call({
 Status status, String? errorMessage, List<SavedProductModel> savedProducts
});




}
/// @nodoc
class __$SavedProductsStateCopyWithImpl<$Res>
    implements _$SavedProductsStateCopyWith<$Res> {
  __$SavedProductsStateCopyWithImpl(this._self, this._then);

  final _SavedProductsState _self;
  final $Res Function(_SavedProductsState) _then;

/// Create a copy of SavedProductsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? errorMessage = freezed,Object? savedProducts = null,}) {
  return _then(_SavedProductsState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as Status,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,savedProducts: null == savedProducts ? _self._savedProducts : savedProducts // ignore: cast_nullable_to_non_nullable
as List<SavedProductModel>,
  ));
}


}

// dart format on
