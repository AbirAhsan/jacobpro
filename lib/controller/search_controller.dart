import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:service/model/service_and_material_item_model.dart';

import '../services/api_service/estimate_api_service.dart';
import '../services/error_code_handle_service.dart';
import '../view/widgets/search_textfield.dart';

class SearchControl extends GetxController {
  RxList<ServiceandMaterialItemModel?> searchDataList =
      List<ServiceandMaterialItemModel?>.empty(growable: true).obs;
  GlobalKey searchTextFormGlobalKey = GlobalKey();
  final layerLink = LayerLink();
  TextEditingController? searchTextEditingCtrl;
  OverlayEntry? entry;

  Rx<bool> isSearching = false.obs;

  @override
  void onInit() {
    searchTextEditingCtrl = TextEditingController();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      searchTextFormGlobalKey;
    });

    super.onInit();
  }

  @override
  void dispose() {
    searchTextEditingCtrl!.dispose();
    super.dispose();
  }

  //<======================= Show Overlay
  void showOverlay(BuildContext context) {
    print("object");
    final overlay = Overlay.of(context);
    final renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;
    final offset = renderBox.localToGlobal(Offset.zero);
    entry = OverlayEntry(
        builder: (context) => Positioned(
              left: offset.dx,
              top: offset.dy + size.height,
              width: size.width,
              child: CompositedTransformFollower(
                  link: layerLink,
                  showWhenUnlinked: false,
                  offset: Offset(0, size.height),
                  child: buildOverlay()),
            ));

    hideOverlay();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      print("object");
      overlay.insert(entry!);
      print("object");
    });
  }

  //<==================== Hide Overlay
  Future<void> hideOverlay() async {
    if (entry != null && entry!.mounted) {
      entry?.remove();
      entry = null;
      searchDataList.clear();
    }

    update();
  }

  //<======================================================== Search topic and consultant
  Future<void> fetchItemSearchList(String? itemType) async {
    try {
      if (searchTextEditingCtrl!.text.isNotEmpty &&
          searchTextEditingCtrl?.text != null &&
          searchTextEditingCtrl?.text != "" &&
          searchTextEditingCtrl!.text.length > 2) {
        isSearching.value = true;
        print("search length is ${searchTextEditingCtrl!.text.length}");
        EstimateApiService()
            .getServiceAndMaterialItemList(
                searchStr: searchTextEditingCtrl!.text, itemType: itemType)
            .then((resp) {
          searchDataList.value = resp;
          update();
          isSearching.value = false;
        }, onError: (err) {
          isSearching.value = false;
          debugPrint(err.toString());
          update();
          ApiErrorHandleService.handleStatusCodeError(err);
        });
      } else {
        print("Clear search list");
        searchDataList.clear();
        update();
      }
    } on SocketException catch (e) {
      isSearching.value = false;
      debugPrint('error $e');
      update();
    } catch (e) {
      isSearching.value = false;
      debugPrint("$e");
      update();
    }
    update();
  }
}
