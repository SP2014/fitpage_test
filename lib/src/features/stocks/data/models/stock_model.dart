import 'package:freezed_annotation/freezed_annotation.dart';

part 'stock_model.freezed.dart';
part 'stock_model.g.dart';

// @freezed
// class StockResponse with _$StockResponse {
//   const StockResponse._();

//   const factory StockResponse({
//     required String status,
//     required List<StockModel> stocks,
//   }) = _StockResponse;

//   factory StockResponse.fromJson(Map<String, dynamic> json) =>
//       _$StockResponseFromJson(json);
// }

@freezed
class StockModel with _$StockModel {
  const StockModel._();
  const factory StockModel({
    @JsonKey(name: 'id') required int id,
    @JsonKey(name: 'name') required String name,
    @JsonKey(name: 'tag') required String tag,
    @JsonKey(name: 'color') required String color,
    @JsonKey(name: 'criteria') required List<CModel> criteria,
  }) = _StockModel;
  factory StockModel.fromJson(Map<String, dynamic> json) =>
      _$StockModelFromJson(json);
}

@freezed
class CModel with _$CModel {
  const CModel._();

  const factory CModel({
    @JsonKey(name: 'type') required String type,
    @JsonKey(name: 'text') String? text,
    @JsonKey(name: 'variable') VariableModel? variable,
  }) = _CModel;

  factory CModel.fromJson(Map<String, dynamic> json) => _$CModelFromJson(json);
}

@freezed
class VariableModel with _$VariableModel {
  const VariableModel._();

  const factory VariableModel({
    @JsonKey(name: '\$1') VModel? $1,
    @JsonKey(name: '\$2') VModel? $2,
    @JsonKey(name: '\$3') VModel? $3,
    @JsonKey(name: '\$4') VModel? $4,
  }) = _VariableModel;

  factory VariableModel.fromJson(Map<String, dynamic> json) =>
      _$VariableModelFromJson(json);
}

@freezed
class VModel with _$VModel {
  const VModel._();
  const factory VModel({
    @JsonKey(name: 'type') required String type,
    @JsonKey(name: 'values') List<double>? values,
    @JsonKey(name: 'study_type') String? studyType,
    @JsonKey(name: 'parameter_name') String? parameterName,
    @JsonKey(name: 'min_value') int? minValue,
    @JsonKey(name: 'max_value') int? maxValue,
    @JsonKey(name: 'default_value') int? defaulValue,
  }) = _VModel;

  factory VModel.fromJson(Map<String, dynamic> json) => _$VModelFromJson(json);
}
