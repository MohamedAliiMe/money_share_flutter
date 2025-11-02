import 'package:json_annotation/json_annotation.dart';
import 'category_model.dart';

part 'category_list_model.g.dart';

@JsonSerializable()
class CategoryListModel {
  final List<CategoryModel>? categories;

  CategoryListModel({this.categories});

  factory CategoryListModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryListModelFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryListModelToJson(this);
}
