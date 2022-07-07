// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreditCard _$CreditCardFromJson(Map<String, dynamic> json) => CreditCard(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      imageURL: json['imageURL'] as String? ?? '',
      features: (json['features'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$CreditCardToJson(CreditCard instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'imageURL': instance.imageURL,
      'features': instance.features,
    };

UfoUserInfo _$UfoUserInfoFromJson(Map<String, dynamic> json) => UfoUserInfo(
      uid: json['uid'] as String? ?? '',
      cardnames: (json['cardnames'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$UfoUserInfoToJson(UfoUserInfo instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'cardnames': instance.cardnames,
    };
