class ServiceandMaterialItemModel {
  int? itemId;
  String? itemName;
  bool? itemIsTaxable;
  int? itemQty;
  String? itemUnitPrice;
  String? itemDescription;
  double? itemCost;
  String? itemType;
  ServiceandMaterialItemModel(
      {this.itemId = 0,
      this.itemName,
      this.itemIsTaxable = true,
      this.itemQty = 0,
      this.itemUnitPrice,
      this.itemDescription,
      this.itemCost,
      this.itemType});

  ServiceandMaterialItemModel.fromJson(Map<String, dynamic> json) {
    itemId = json['itemId'] ?? 0;
    itemName = json['itemName'];
    itemIsTaxable = json['itemIsTaxable'] ?? true;
    itemQty = json['itemQty'] ?? 0;
    itemUnitPrice = json['itemUnitPrice'].toString();
    itemDescription = json['itemDescription'];
    itemCost = double.tryParse("${json['itemCost'] ?? 0.0}");
    itemType = json['itemType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['itemId'] = itemId ?? 0;
    data['itemName'] = itemName;
    data['itemIsTaxable'] = itemIsTaxable;
    data['itemQty'] = itemQty ?? 0;
    data['itemUnitPrice'] = itemUnitPrice;
    data['itemDescription'] = itemDescription;
    data['itemCost'] = itemCost;
    data['itemType'] = itemType;
    return data;
  }
}
