import 'package:json_annotation/json_annotation.dart';
part 'models.g.dart';

@JsonSerializable()
class CreditCard {
  late final String id;
  final String name;
  final String imageURL;
  final List<String> features;

  CreditCard(
      {this.id = '',
      this.name = '',
      this.imageURL = '',
      this.features = const []});

  factory CreditCard.fromJson(Map<String, dynamic> json) =>
      _$CreditCardFromJson(json);
  Map<String, dynamic> toJson() => _$CreditCardToJson(this);
}

@JsonSerializable()
class UfoUserInfo {
  String uid;
  List<String> cardnames;

  UfoUserInfo({this.uid = '', this.cardnames = const []});
  factory UfoUserInfo.fromJson(Map<String, dynamic> json) =>
      _$UfoUserInfoFromJson(json);
  Map<String, dynamic> toJson() => _$UfoUserInfoToJson(this);
}
