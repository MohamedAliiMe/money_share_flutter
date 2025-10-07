// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'groups_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$GroupsState {
  bool get isLoading => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;
  List<GroupModel>? get groups => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $GroupsStateCopyWith<GroupsState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GroupsStateCopyWith<$Res> {
  factory $GroupsStateCopyWith(
          GroupsState value, $Res Function(GroupsState) then) =
      _$GroupsStateCopyWithImpl<$Res, GroupsState>;
  @useResult
  $Res call({bool isLoading, String? errorMessage, List<GroupModel>? groups});
}

/// @nodoc
class _$GroupsStateCopyWithImpl<$Res, $Val extends GroupsState>
    implements $GroupsStateCopyWith<$Res> {
  _$GroupsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? errorMessage = freezed,
    Object? groups = freezed,
  }) {
    return _then(_value.copyWith(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      groups: freezed == groups
          ? _value.groups
          : groups // ignore: cast_nullable_to_non_nullable
              as List<GroupModel>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GroupsStateImplCopyWith<$Res>
    implements $GroupsStateCopyWith<$Res> {
  factory _$$GroupsStateImplCopyWith(
          _$GroupsStateImpl value, $Res Function(_$GroupsStateImpl) then) =
      __$$GroupsStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool isLoading, String? errorMessage, List<GroupModel>? groups});
}

/// @nodoc
class __$$GroupsStateImplCopyWithImpl<$Res>
    extends _$GroupsStateCopyWithImpl<$Res, _$GroupsStateImpl>
    implements _$$GroupsStateImplCopyWith<$Res> {
  __$$GroupsStateImplCopyWithImpl(
      _$GroupsStateImpl _value, $Res Function(_$GroupsStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? errorMessage = freezed,
    Object? groups = freezed,
  }) {
    return _then(_$GroupsStateImpl(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      groups: freezed == groups
          ? _value._groups
          : groups // ignore: cast_nullable_to_non_nullable
              as List<GroupModel>?,
    ));
  }
}

/// @nodoc

class _$GroupsStateImpl implements _GroupsState {
  const _$GroupsStateImpl(
      {this.isLoading = false,
      this.errorMessage,
      final List<GroupModel>? groups})
      : _groups = groups;

  @override
  @JsonKey()
  final bool isLoading;
  @override
  final String? errorMessage;
  final List<GroupModel>? _groups;
  @override
  List<GroupModel>? get groups {
    final value = _groups;
    if (value == null) return null;
    if (_groups is EqualUnmodifiableListView) return _groups;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'GroupsState(isLoading: $isLoading, errorMessage: $errorMessage, groups: $groups)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GroupsStateImpl &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            const DeepCollectionEquality().equals(other._groups, _groups));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isLoading, errorMessage,
      const DeepCollectionEquality().hash(_groups));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GroupsStateImplCopyWith<_$GroupsStateImpl> get copyWith =>
      __$$GroupsStateImplCopyWithImpl<_$GroupsStateImpl>(this, _$identity);
}

abstract class _GroupsState implements GroupsState {
  const factory _GroupsState(
      {final bool isLoading,
      final String? errorMessage,
      final List<GroupModel>? groups}) = _$GroupsStateImpl;

  @override
  bool get isLoading;
  @override
  String? get errorMessage;
  @override
  List<GroupModel>? get groups;
  @override
  @JsonKey(ignore: true)
  _$$GroupsStateImplCopyWith<_$GroupsStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
