// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'card_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CardState {

 Status get status; Status get createStatus; Status get deleteStatus; String? get errorMessage; List<CardModel> get cards;
/// Create a copy of CardState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CardStateCopyWith<CardState> get copyWith => _$CardStateCopyWithImpl<CardState>(this as CardState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CardState&&(identical(other.status, status) || other.status == status)&&(identical(other.createStatus, createStatus) || other.createStatus == createStatus)&&(identical(other.deleteStatus, deleteStatus) || other.deleteStatus == deleteStatus)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&const DeepCollectionEquality().equals(other.cards, cards));
}


@override
int get hashCode => Object.hash(runtimeType,status,createStatus,deleteStatus,errorMessage,const DeepCollectionEquality().hash(cards));

@override
String toString() {
  return 'CardState(status: $status, createStatus: $createStatus, deleteStatus: $deleteStatus, errorMessage: $errorMessage, cards: $cards)';
}


}

/// @nodoc
abstract mixin class $CardStateCopyWith<$Res>  {
  factory $CardStateCopyWith(CardState value, $Res Function(CardState) _then) = _$CardStateCopyWithImpl;
@useResult
$Res call({
 Status status, Status createStatus, Status deleteStatus, String? errorMessage, List<CardModel> cards
});




}
/// @nodoc
class _$CardStateCopyWithImpl<$Res>
    implements $CardStateCopyWith<$Res> {
  _$CardStateCopyWithImpl(this._self, this._then);

  final CardState _self;
  final $Res Function(CardState) _then;

/// Create a copy of CardState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? createStatus = null,Object? deleteStatus = null,Object? errorMessage = freezed,Object? cards = null,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as Status,createStatus: null == createStatus ? _self.createStatus : createStatus // ignore: cast_nullable_to_non_nullable
as Status,deleteStatus: null == deleteStatus ? _self.deleteStatus : deleteStatus // ignore: cast_nullable_to_non_nullable
as Status,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,cards: null == cards ? _self.cards : cards // ignore: cast_nullable_to_non_nullable
as List<CardModel>,
  ));
}

}


/// Adds pattern-matching-related methods to [CardState].
extension CardStatePatterns on CardState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CardState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CardState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CardState value)  $default,){
final _that = this;
switch (_that) {
case _CardState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CardState value)?  $default,){
final _that = this;
switch (_that) {
case _CardState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Status status,  Status createStatus,  Status deleteStatus,  String? errorMessage,  List<CardModel> cards)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CardState() when $default != null:
return $default(_that.status,_that.createStatus,_that.deleteStatus,_that.errorMessage,_that.cards);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Status status,  Status createStatus,  Status deleteStatus,  String? errorMessage,  List<CardModel> cards)  $default,) {final _that = this;
switch (_that) {
case _CardState():
return $default(_that.status,_that.createStatus,_that.deleteStatus,_that.errorMessage,_that.cards);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Status status,  Status createStatus,  Status deleteStatus,  String? errorMessage,  List<CardModel> cards)?  $default,) {final _that = this;
switch (_that) {
case _CardState() when $default != null:
return $default(_that.status,_that.createStatus,_that.deleteStatus,_that.errorMessage,_that.cards);case _:
  return null;

}
}

}

/// @nodoc


class _CardState implements CardState {
  const _CardState({required this.status, required this.createStatus, required this.deleteStatus, this.errorMessage, required final  List<CardModel> cards}): _cards = cards;
  

@override final  Status status;
@override final  Status createStatus;
@override final  Status deleteStatus;
@override final  String? errorMessage;
 final  List<CardModel> _cards;
@override List<CardModel> get cards {
  if (_cards is EqualUnmodifiableListView) return _cards;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_cards);
}


/// Create a copy of CardState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CardStateCopyWith<_CardState> get copyWith => __$CardStateCopyWithImpl<_CardState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CardState&&(identical(other.status, status) || other.status == status)&&(identical(other.createStatus, createStatus) || other.createStatus == createStatus)&&(identical(other.deleteStatus, deleteStatus) || other.deleteStatus == deleteStatus)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&const DeepCollectionEquality().equals(other._cards, _cards));
}


@override
int get hashCode => Object.hash(runtimeType,status,createStatus,deleteStatus,errorMessage,const DeepCollectionEquality().hash(_cards));

@override
String toString() {
  return 'CardState(status: $status, createStatus: $createStatus, deleteStatus: $deleteStatus, errorMessage: $errorMessage, cards: $cards)';
}


}

/// @nodoc
abstract mixin class _$CardStateCopyWith<$Res> implements $CardStateCopyWith<$Res> {
  factory _$CardStateCopyWith(_CardState value, $Res Function(_CardState) _then) = __$CardStateCopyWithImpl;
@override @useResult
$Res call({
 Status status, Status createStatus, Status deleteStatus, String? errorMessage, List<CardModel> cards
});




}
/// @nodoc
class __$CardStateCopyWithImpl<$Res>
    implements _$CardStateCopyWith<$Res> {
  __$CardStateCopyWithImpl(this._self, this._then);

  final _CardState _self;
  final $Res Function(_CardState) _then;

/// Create a copy of CardState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? createStatus = null,Object? deleteStatus = null,Object? errorMessage = freezed,Object? cards = null,}) {
  return _then(_CardState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as Status,createStatus: null == createStatus ? _self.createStatus : createStatus // ignore: cast_nullable_to_non_nullable
as Status,deleteStatus: null == deleteStatus ? _self.deleteStatus : deleteStatus // ignore: cast_nullable_to_non_nullable
as Status,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,cards: null == cards ? _self._cards : cards // ignore: cast_nullable_to_non_nullable
as List<CardModel>,
  ));
}


}

// dart format on
