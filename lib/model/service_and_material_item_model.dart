class ServiceandMaterialItemModel {
  int? itemId;
  String? itemName;
  bool? itemIsTaxable;
  int? itemQty;
  String? itemUnitPrice;
  String? itemDescription;
  String? itemCost;
  String? itemType;
  ServiceandMaterialItemModel(
      {this.itemId,
      this.itemName,
      this.itemIsTaxable,
      this.itemQty,
      this.itemUnitPrice,
      this.itemDescription,
      this.itemCost,
      this.itemType});

  ServiceandMaterialItemModel.fromJson(Map<String, dynamic> json) {
    itemId = json['itemId'];
    itemName = json['itemName'];
    itemIsTaxable = json['itemIsTaxable'];
    itemQty = json['itemQty'];
    itemUnitPrice = json['itemUnitPrice'].toString();
    itemDescription = json['itemDescription'];
    itemCost = json['itemCost'].toString();
    itemType = json['itemType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['itemId'] = itemId;
    data['itemName'] = itemName;
    data['itemIsTaxable'] = itemIsTaxable;
    data['itemQty'] = itemQty;
    data['itemUnitPrice'] = itemUnitPrice;
    data['itemDescription'] = itemDescription;
    data['itemCost'] = itemCost;
    data['itemType'] = itemType;
    return data;
  }
}
