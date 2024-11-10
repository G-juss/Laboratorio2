import 'package:json_annotation/json_annotation.dart';

part 'drink.g.dart';

@JsonSerializable()
class Drink {
  final String idDrink;
  final String strDrink;
  final String strDrinkThumb;

  Drink({required this.idDrink, required this.strDrink, required this.strDrinkThumb});

  factory Drink.fromJson(Map<String, dynamic> json) => _$DrinkFromJson(json);
  Map<String, dynamic> toJson() => _$DrinkToJson(this);
}
