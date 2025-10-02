// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'card_create_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CardCreateEvent {

 String get cardNumber; String get expiryDate; String get cvv; String get holderName;
/// Create a copy of CardCreateEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CardCreateEventCopyWith<CardCreateEvent> get copyWith => _$CardCreateEventCopyWithImpl<CardCreateEvent>(this as CardCreateEvent, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CardCreateEvent&&(identical(other.cardNumber, cardNumber) || other.cardNumber == cardNumber)&&(identical(other.expiryDate, expiryDate) || other.expiryDate == expiryDate)&&(identical(other.cvv, cvv) || other.cvv == cvv)&&(identical(other.holderName, holderName) || other.holderName == holderName));
}


@override
int get hashCode => Object.hash(runtimeType,cardNumber,expiryDate,cvv,holderName);

@override
String toString() {
  return 'CardCreateEvent(cardNumber: $cardNumber, expiryDate: $expiryDate, cvv: $cvv, holderName: $holderName)';
}


}

/// @nodoc
abstract mixin class $CardCreateEventCopyWith<$Res>  {
  factory $CardCreateEventCopyWith(CardCreateEvent value, $Res Function(CardCreateEvent) _then) = _$CardCreateEventCopyWithImpl;
@useResult
$Res call({
 String cardNumber, String expiryDate, String cvv, String holderName
});




}
/// @nodoc
class _$CardCreateEventCopyWithImpl<$Res>
    implements $CardCreateEventCopyWith<$Res> {
  _$CardCreateEventCopyWithImpl(this._self, this._then);

  final CardCreateEvent _self;
  final $Res Function(CardCreateEvent) _then;

/// Create a copy of CardCreateEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? cardNumber = null,Object? expiryDate = null,Object? cvv = null,Object? holderName = null,}) {
  return _then(_self.copyWith(
cardNumber: null == cardNumber ? _self.cardNumber : cardNumber // ignore: cast_nullable_to_non_nullable
as String,expiryDate: null == expiryDate ? _self.expiryDate : expiryDate // ignore: cast_nullable_to_non_nullable
as String,cvv: null == cvv ? _self.cvv : cvv // ignore: cast_nullable_to_non_nullable
as String,holderName: null == holderName ? _self.holderName : holderName // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [CardCreateEvent].
extension CardCreateEventPatterns on CardCreateEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Create value)?  create,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Create() when create != null:
return create(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Create value)  create,}){
final _that = this;
switch (_that) {
case _Create():
return create(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Create value)?  create,}){
final _that = this;
switch (_that) {
case _Create() when create != null:
return create(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String cardNumber,  String expiryDate,  String cvv,  String holderName)?  create,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Create() when create != null:
return create(_that.cardNumber,_that.expiryDate,_that.cvv,_that.holderName);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String cardNumber,  String expiryDate,  String cvv,  String holderName)  create,}) {final _that = this;
switch (_that) {
case _Create():
return create(_that.cardNumber,_that.expiryDate,_that.cvv,_that.holderName);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String cardNumber,  String expiryDate,  String cvv,  String holderName)?  create,}) {final _that = this;
switch (_that) {
case _Create() when create != null:
return create(_that.cardNumber,_that.expiryDate,_that.cvv,_that.holderName);case _:
  return null;

}
}

}

/// @nodoc


class _Create implements CardCreateEvent {
  const _Create({required this.cardNumber, required this.expiryDate, required this.cvv, required this.holderName});
  

@override final  String cardNumber;
@override final  String expiryDate;
@override final  String cvv;
@override final  String holderName;

/// Create a copy of CardCreateEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CreateCopyWith<_Create> get copyWith => __$CreateCopyWithImpl<_Create>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Create&&(identical(other.cardNumber, cardNumber) || other.cardNumber == cardNumber)&&(identical(other.expiryDate, expiryDate) || other.expiryDate == expiryDate)&&(identical(other.cvv, cvv) || other.cvv == cvv)&&(identical(other.holderName, holderName) || other.holderName == holderName));
}


@override
int get hashCode => Object.hash(runtimeType,cardNumber,expiryDate,cvv,holderName);

@override
String toString() {
  return 'CardCreateEvent.create(cardNumber: $cardNumber, expiryDate: $expiryDate, cvv: $cvv, holderName: $holderName)';
}


}

/// @nodoc
abstract mixin class _$CreateCopyWith<$Res> implements $CardCreateEventCopyWith<$Res> {
  factory _$CreateCopyWith(_Create value, $Res Function(_Create) _then) = __$CreateCopyWithImpl;
@override @useResult
$Res call({
 String cardNumber, String expiryDate, String cvv, String holderName
});




}
/// @nodoc
class __$CreateCopyWithImpl<$Res>
    implements _$CreateCopyWith<$Res> {
  __$CreateCopyWithImpl(this._self, this._then);

  final _Create _self;
  final $Res Function(_Create) _then;

/// Create a copy of CardCreateEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? cardNumber = null,Object? expiryDate = null,Object? cvv = null,Object? holderName = null,}) {
  return _then(_Create(
cardNumber: null == cardNumber ? _self.cardNumber : cardNumber // ignore: cast_nullable_to_non_nullable
as String,expiryDate: null == expiryDate ? _self.expiryDate : expiryDate // ignore: cast_nullable_to_non_nullable
as String,cvv: null == cvv ? _self.cvv : cvv // ignore: cast_nullable_to_non_nullable
as String,holderName: null == holderName ? _self.holderName : holderName // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
