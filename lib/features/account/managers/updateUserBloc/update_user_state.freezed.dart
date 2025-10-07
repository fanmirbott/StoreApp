// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'update_user_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$UpdateUserState {

 Status get status; String? get errorMessage; UserModel? get updatedUser;
/// Create a copy of UpdateUserState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UpdateUserStateCopyWith<UpdateUserState> get copyWith => _$UpdateUserStateCopyWithImpl<UpdateUserState>(this as UpdateUserState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UpdateUserState&&(identical(other.status, status) || other.status == status)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.updatedUser, updatedUser) || other.updatedUser == updatedUser));
}


@override
int get hashCode => Object.hash(runtimeType,status,errorMessage,updatedUser);

@override
String toString() {
  return 'UpdateUserState(status: $status, errorMessage: $errorMessage, updatedUser: $updatedUser)';
}


}

/// @nodoc
abstract mixin class $UpdateUserStateCopyWith<$Res>  {
  factory $UpdateUserStateCopyWith(UpdateUserState value, $Res Function(UpdateUserState) _then) = _$UpdateUserStateCopyWithImpl;
@useResult
$Res call({
 Status status, String? errorMessage, UserModel? updatedUser
});




}
/// @nodoc
class _$UpdateUserStateCopyWithImpl<$Res>
    implements $UpdateUserStateCopyWith<$Res> {
  _$UpdateUserStateCopyWithImpl(this._self, this._then);

  final UpdateUserState _self;
  final $Res Function(UpdateUserState) _then;

/// Create a copy of UpdateUserState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? errorMessage = freezed,Object? updatedUser = freezed,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as Status,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,updatedUser: freezed == updatedUser ? _self.updatedUser : updatedUser // ignore: cast_nullable_to_non_nullable
as UserModel?,
  ));
}

}


/// Adds pattern-matching-related methods to [UpdateUserState].
extension UpdateUserStatePatterns on UpdateUserState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UpdateUserState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UpdateUserState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UpdateUserState value)  $default,){
final _that = this;
switch (_that) {
case _UpdateUserState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UpdateUserState value)?  $default,){
final _that = this;
switch (_that) {
case _UpdateUserState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Status status,  String? errorMessage,  UserModel? updatedUser)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UpdateUserState() when $default != null:
return $default(_that.status,_that.errorMessage,_that.updatedUser);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Status status,  String? errorMessage,  UserModel? updatedUser)  $default,) {final _that = this;
switch (_that) {
case _UpdateUserState():
return $default(_that.status,_that.errorMessage,_that.updatedUser);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Status status,  String? errorMessage,  UserModel? updatedUser)?  $default,) {final _that = this;
switch (_that) {
case _UpdateUserState() when $default != null:
return $default(_that.status,_that.errorMessage,_that.updatedUser);case _:
  return null;

}
}

}

/// @nodoc


class _UpdateUserState implements UpdateUserState {
  const _UpdateUserState({required this.status, this.errorMessage, this.updatedUser});
  

@override final  Status status;
@override final  String? errorMessage;
@override final  UserModel? updatedUser;

/// Create a copy of UpdateUserState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UpdateUserStateCopyWith<_UpdateUserState> get copyWith => __$UpdateUserStateCopyWithImpl<_UpdateUserState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UpdateUserState&&(identical(other.status, status) || other.status == status)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.updatedUser, updatedUser) || other.updatedUser == updatedUser));
}


@override
int get hashCode => Object.hash(runtimeType,status,errorMessage,updatedUser);

@override
String toString() {
  return 'UpdateUserState(status: $status, errorMessage: $errorMessage, updatedUser: $updatedUser)';
}


}

/// @nodoc
abstract mixin class _$UpdateUserStateCopyWith<$Res> implements $UpdateUserStateCopyWith<$Res> {
  factory _$UpdateUserStateCopyWith(_UpdateUserState value, $Res Function(_UpdateUserState) _then) = __$UpdateUserStateCopyWithImpl;
@override @useResult
$Res call({
 Status status, String? errorMessage, UserModel? updatedUser
});




}
/// @nodoc
class __$UpdateUserStateCopyWithImpl<$Res>
    implements _$UpdateUserStateCopyWith<$Res> {
  __$UpdateUserStateCopyWithImpl(this._self, this._then);

  final _UpdateUserState _self;
  final $Res Function(_UpdateUserState) _then;

/// Create a copy of UpdateUserState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? errorMessage = freezed,Object? updatedUser = freezed,}) {
  return _then(_UpdateUserState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as Status,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,updatedUser: freezed == updatedUser ? _self.updatedUser : updatedUser // ignore: cast_nullable_to_non_nullable
as UserModel?,
  ));
}


}

// dart format on
