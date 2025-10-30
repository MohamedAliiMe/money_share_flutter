// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfileModel _$ProfileModelFromJson(Map<String, dynamic> json) => ProfileModel(
      user: json['user'] == null
          ? null
          : UserModel.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ProfileModelToJson(ProfileModel instance) =>
    <String, dynamic>{
      'user': instance.user,
    };

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      email: json['email'] as String?,
      emailVerifiedAt: json['email_verified_at'] as String?,
      phone: json['phone'] as String?,
      currencyId: (json['currency_id'] as num?)?.toInt(),
      countryId: (json['country_id'] as num?)?.toInt(),
      language: json['language'] as String?,
      groups: (json['groups'] as List<dynamic>?)
          ?.map((e) => GroupModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      country: json['country'],
      currency: json['currency'],
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'email_verified_at': instance.emailVerifiedAt,
      'phone': instance.phone,
      'currency_id': instance.currencyId,
      'country_id': instance.countryId,
      'language': instance.language,
      'groups': instance.groups,
      'country': instance.country,
      'currency': instance.currency,
    };
