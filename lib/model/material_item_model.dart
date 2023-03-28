class MaterialItemModel {
  int? key;
  String? value;
  MaterialGeneralData? materialGeneralData;
  List<MaterialPrices>? materialPrices;

  MaterialItemModel(
      {this.key, this.value, this.materialGeneralData, this.materialPrices});

  MaterialItemModel.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    value = json['value'];
    materialGeneralData = json['materialGeneralData'] != null
        ? MaterialGeneralData.fromJson(json['materialGeneralData'])
        : null;
    if (json['materialPrices'] != null) {
      materialPrices = <MaterialPrices>[];
      json['materialPrices'].forEach((v) {
        materialPrices!.add(MaterialPrices.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['key'] = key;
    data['value'] = value;
    if (materialGeneralData != null) {
      data['materialGeneralData'] = materialGeneralData!.toJson();
    }
    if (materialPrices != null) {
      data['materialPrices'] = materialPrices!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MaterialGeneralData {
  int? materialId;
  String? materialName;
  int? materialParentId;
  String? materialCode;
  String? materialPartCode;
  String? materialDescription;
  bool? materialIsTaxable;

  MaterialGeneralData(
      {this.materialId,
      this.materialName,
      this.materialParentId,
      this.materialCode,
      this.materialPartCode,
      this.materialDescription,
      this.materialIsTaxable});

  MaterialGeneralData.fromJson(Map<String, dynamic> json) {
    materialId = json['materialId'];
    materialName = json['materialName'];
    materialParentId = json['materialParentId'];
    materialCode = json['materialCode'];
    materialPartCode = json['materialPartCode'];
    materialDescription = json['materialDescription'];
    materialIsTaxable = json['materialIsTaxable'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['materialId'] = materialId;
    data['materialName'] = materialName;
    data['materialParentId'] = materialParentId;
    data['materialCode'] = materialCode;
    data['materialPartCode'] = materialPartCode;
    data['materialDescription'] = materialDescription;
    data['materialIsTaxable'] = materialIsTaxable;
    return data;
  }
}

class MaterialPrices {
  int? materialPriceId;
  int? unitId;
  String? unitName;
  int? materialCost;
  double? materialPrice;
  bool? materialUnitIsDefault;
  String? materialPriceActiveFrom;
  String? materialPriceActiveTo;

  MaterialPrices(
      {this.materialPriceId,
      this.unitId,
      this.unitName,
      this.materialCost,
      this.materialPrice,
      this.materialUnitIsDefault,
      this.materialPriceActiveFrom,
      this.materialPriceActiveTo});

  MaterialPrices.fromJson(Map<String, dynamic> json) {
    materialPriceId = json['materialPriceId'];
    unitId = json['unitId'];
    unitName = json['unitName'];
    materialCost = json['materialCost'];
    materialPrice = json['materialPrice'];
    materialUnitIsDefault = json['materialUnitIsDefault'];
    materialPriceActiveFrom = json['materialPriceActiveFrom'];
    materialPriceActiveTo = json['materialPriceActiveTo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['materialPriceId'] = materialPriceId;
    data['unitId'] = unitId;
    data['unitName'] = unitName;
    data['materialCost'] = materialCost;
    data['materialPrice'] = materialPrice;
    data['materialUnitIsDefault'] = materialUnitIsDefault;
    data['materialPriceActiveFrom'] = materialPriceActiveFrom;
    data['materialPriceActiveTo'] = materialPriceActiveTo;
    return data;
  }
}
