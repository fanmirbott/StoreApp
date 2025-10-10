// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cart_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CartEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CartEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CartEvent()';
}


}

/// @nodoc
class $CartEventCopyWith<$Res>  {
$CartEventCopyWith(CartEvent _, $Res Function(CartEvent) __);
}


/// Adds pattern-matching-related methods to [CartEvent].
extension CartEventPatterns on CartEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( CartLoading value)?  cartLoading,TResult Function( CartItemAdded value)?  cartItemAdded,TResult Function( CartItemDeleted value)?  cartItemDeleted,required TResult orElse(),}){
final _that = this;
switch (_that) {
case CartLoading() when cartLoading != null:
return cartLoading(_that);case CartItemAdded() when cartItemAdded != null:
return cartItemAdded(_that);case CartItemDeleted() when cartItemDeleted != null:
return cartItemDeleted(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( CartLoading value)  cartLoading,required TResult Function( CartItemAdded value)  cartItemAdded,required TResult Function( CartItemDeleted value)  cartItemDeleted,}){
final _that = this;
switch (_that) {
case CartLoading():
return cartLoading(_that);case CartItemAdded():
return cartItemAdded(_that);case CartItemDeleted():
return cartItemDeleted(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( CartLoading value)?  cartLoading,TResult? Function( CartItemAdded value)?  cartItemAdded,TResult? Function( CartItemDeleted value)?  cartItemDeleted,}){
final _that = this;
switch (_that) {
case CartLoading() when cartLoading != null:
return cartLoading(_that);case CartItemAdded() when cartItemAdded != null:
return cartItemAdded(_that);case CartItemDeleted() when cartItemDeleted != null:
return cartItemDeleted(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  cartLoading,TResult Function( int productId,  int sizeId)?  cartItemAdded,TResult Function( int productId)?  cartItemDeleted,required TResult orElse(),}) {final _that = this;
switch (_that) {
case CartLoading() when cartLoading != null:
return cartLoading();case CartItemAdded() when cartItemAdded != null:
return cartItemAdded(_that.productId,_that.sizeId);case CartItemDeleted() when cartItemDeleted != null:
return cartItemDeleted(_that.productId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  cartLoading,required TResult Function( int productId,  int sizeId)  cartItemAdded,required TResult Function( int productId)  cartItemDeleted,}) {final _that = this;
switch (_that) {
case CartLoading():
return cartLoading();case CartItemAdded():
return cartItemAdded(_that.productId,_that.sizeId);case CartItemDeleted():
return cartItemDeleted(_that.productId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  cartLoading,TResult? Function( int productId,  int sizeId)?  cartItemAdded,TResult? Function( int productId)?  cartItemDeleted,}) {final _that = this;
switch (_that) {
case CartLoading() when cartLoading != null:
return cartLoading();case CartItemAdded() when cartItemAdded != null:
return cartItemAdded(_that.productId,_that.sizeId);case CartItemDeleted() when cartItemDeleted != null:
return cartItemDeleted(_that.productId);case _:
  return null;

}
}

}

/// @nodoc


class CartLoading implements CartEvent {
  const CartLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CartLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CartEvent.cartLoading()';
}


}




/// @nodoc


class CartItemAdded implements CartEvent {
  const CartItemAdded({required this.productId, required this.sizeId});
  

 final  int productId;
 final  int sizeId;

/// Create a copy of CartEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CartItemAddedCopyWith<CartItemAdded> get copyWith => _$CartItemAddedCopyWithImpl<CartItemAdded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CartItemAdded&&(identical(other.productId, productId) || other.productId == productId)&&(identical(other.sizeId, sizeId) || other.sizeId == sizeId));
}


@override
int get hashCode => Object.hash(runtimeType,productId,sizeId);

@override
String toString() {
  return 'CartEvent.cartItemAdded(productId: $productId, sizeId: $sizeId)';
}


}

/// @nodoc
abstract mixin class $CartItemAddedCopyWith<$Res> implements $CartEventCopyWith<$Res> {
  factory $CartItemAddedCopyWith(CartItemAdded value, $Res Function(CartItemAdded) _then) = _$CartItemAddedCopyWithImpl;
@useResult
$Res call({
 int productId, int sizeId
});




}
/// @nodoc
class _$CartItemAddedCopyWithImpl<$Res>
    implements $CartItemAddedCopyWith<$Res> {
  _$CartItemAddedCopyWithImpl(this._self, this._then);

  final CartItemAdded _self;
  final $Res Function(CartItemAdded) _then;

/// Create a copy of CartEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? productId = null,Object? sizeId = null,}) {
  return _then(CartItemAdded(
productId: null == productId ? _self.productId : productId // ignore: cast_nullable_to_non_nullable
as int,sizeId: null == sizeId ? _self.sizeId : sizeId // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class CartItemDeleted implements CartEvent {
  const CartItemDeleted({required this.productId});
  

 final  int productId;

/// Create a copy of CartEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CartItemDeletedCopyWith<CartItemDeleted> get copyWith => _$CartItemDeletedCopyWithImpl<CartItemDeleted>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CartItemDeleted&&(identical(other.productId, productId) || other.productId == productId));
}


@override
int get hashCode => Object.hash(runtimeType,productId);

@override
String toString() {
  return 'CartEvent.cartItemDeleted(productId: $productId)';
}


}

/// @nodoc
abstract mixin class $CartItemDeletedCopyWith<$Res> implements $CartEventCopyWith<$Res> {
  factory $CartItemDeletedCopyWith(CartItemDeleted value, $Res Function(CartItemDeleted) _then) = _$CartItemDeletedCopyWithImpl;
@useResult
$Res call({
 int productId
});




}
/// @nodoc
class _$CartItemDeletedCopyWithImpl<$Res>
    implements $CartItemDeletedCopyWith<$Res> {
  _$CartItemDeletedCopyWithImpl(this._self, this._then);

  final CartItemDeleted _self;
  final $Res Function(CartItemDeleted) _then;

/// Create a copy of CartEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? productId = null,}) {
  return _then(CartItemDeleted(
productId: null == productId ? _self.productId : productId // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc
mixin _$CartState {

 Status get status; String? get errorMessage; CartResponseModel? get cart; CartItemModel? get lastAddedItem;
/// Create a copy of CartState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CartStateCopyWith<CartState> get copyWith => _$CartStateCopyWithImpl<CartState>(this as CartState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CartState&&(identical(other.status, status) || other.status == status)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.cart, cart) || other.cart == cart)&&(identical(other.lastAddedItem, lastAddedItem) || other.lastAddedItem == lastAddedItem));
}


@override
int get hashCode => Object.hash(runtimeType,status,errorMessage,cart,lastAddedItem);

@override
String toString() {
  return 'CartState(status: $status, errorMessage: $errorMessage, cart: $cart, lastAddedItem: $lastAddedItem)';
}


}

/// @nodoc
abstract mixin class $CartStateCopyWith<$Res>  {
  factory $CartStateCopyWith(CartState value, $Res Function(CartState) _then) = _$CartStateCopyWithImpl;
@useResult
$Res call({
 Status status, String? errorMessage, CartResponseModel? cart, CartItemModel? lastAddedItem
});




}
/// @nodoc
class _$CartStateCopyWithImpl<$Res>
    implements $CartStateCopyWith<$Res> {
  _$CartStateCopyWithImpl(this._self, this._then);

  final CartState _self;
  final $Res Function(CartState) _then;

/// Create a copy of CartState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? errorMessage = freezed,Object? cart = freezed,Object? lastAddedItem = freezed,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as Status,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,cart: freezed == cart ? _self.cart : cart // ignore: cast_nullable_to_non_nullable
as CartResponseModel?,lastAddedItem: freezed == lastAddedItem ? _self.lastAddedItem : lastAddedItem // ignore: cast_nullable_to_non_nullable
as CartItemModel?,
  ));
}

}


/// Adds pattern-matching-related methods to [CartState].
extension CartStatePatterns on CartState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CartState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CartState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CartState value)  $default,){
final _that = this;
switch (_that) {
case _CartState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CartState value)?  $default,){
final _that = this;
switch (_that) {
case _CartState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Status status,  String? errorMessage,  CartResponseModel? cart,  CartItemModel? lastAddedItem)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CartState() when $default != null:
return $default(_that.status,_that.errorMessage,_that.cart,_that.lastAddedItem);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Status status,  String? errorMessage,  CartResponseModel? cart,  CartItemModel? lastAddedItem)  $default,) {final _that = this;
switch (_that) {
case _CartState():
return $default(_that.status,_that.errorMessage,_that.cart,_that.lastAddedItem);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Status status,  String? errorMessage,  CartResponseModel? cart,  CartItemModel? lastAddedItem)?  $default,) {final _that = this;
switch (_that) {
case _CartState() when $default != null:
return $default(_that.status,_that.errorMessage,_that.cart,_that.lastAddedItem);case _:
  return null;

}
}

}

/// @nodoc


class _CartState implements CartState {
  const _CartState({required this.status, this.errorMessage, this.cart, this.lastAddedItem});
  

@override final  Status status;
@override final  String? errorMessage;
@override final  CartResponseModel? cart;
@override final  CartItemModel? lastAddedItem;

/// Create a copy of CartState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CartStateCopyWith<_CartState> get copyWith => __$CartStateCopyWithImpl<_CartState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CartState&&(identical(other.status, status) || other.status == status)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.cart, cart) || other.cart == cart)&&(identical(other.lastAddedItem, lastAddedItem) || other.lastAddedItem == lastAddedItem));
}


@override
int get hashCode => Object.hash(runtimeType,status,errorMessage,cart,lastAddedItem);

@override
String toString() {
  return 'CartState(status: $status, errorMessage: $errorMessage, cart: $cart, lastAddedItem: $lastAddedItem)';
}


}

/// @nodoc
abstract mixin class _$CartStateCopyWith<$Res> implements $CartStateCopyWith<$Res> {
  factory _$CartStateCopyWith(_CartState value, $Res Function(_CartState) _then) = __$CartStateCopyWithImpl;
@override @useResult
$Res call({
 Status status, String? errorMessage, CartResponseModel? cart, CartItemModel? lastAddedItem
});




}
/// @nodoc
class __$CartStateCopyWithImpl<$Res>
    implements _$CartStateCopyWith<$Res> {
  __$CartStateCopyWithImpl(this._self, this._then);

  final _CartState _self;
  final $Res Function(_CartState) _then;

/// Create a copy of CartState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? errorMessage = freezed,Object? cart = freezed,Object? lastAddedItem = freezed,}) {
  return _then(_CartState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as Status,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,cart: freezed == cart ? _self.cart : cart // ignore: cast_nullable_to_non_nullable
as CartResponseModel?,lastAddedItem: freezed == lastAddedItem ? _self.lastAddedItem : lastAddedItem // ignore: cast_nullable_to_non_nullable
as CartItemModel?,
  ));
}


}

// dart format on
