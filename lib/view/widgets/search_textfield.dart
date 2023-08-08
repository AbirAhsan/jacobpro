import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;

import '../../controller/estimate_controller.dart';
import '../../controller/search_controller.dart';
import '../../model/service_and_material_item_model.dart';
import '../../services/debouncher_service.dart';
import '../variables/text_style.dart';
import 'custom_text_field.dart';

class ItemSearchTextField extends StatefulWidget {
  final String? itemType;
  const ItemSearchTextField({super.key, this.itemType});

  @override
  State<ItemSearchTextField> createState() => _ItemSearchTextFieldState();
}

class _ItemSearchTextFieldState extends State<ItemSearchTextField> {
  final SearchControl searchCtrl = Get.put(SearchControl());
  FocusNode? searchfocusNode;
  final _debouncer = Debouncer(milliseconds: 1000);
  @override
  void initState() {
    searchfocusNode = FocusNode();
    searchfocusNode!.addListener(() {
      if (searchfocusNode!.hasFocus) {
        debugPrint("focused");
        searchCtrl.showOverlay(context);
      } else {
        debugPrint("unfocused");
        searchCtrl.hideOverlay();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    searchfocusNode!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SearchControl>(
        init: SearchControl(),
        builder: (searchCtrl) {
          return GetBuilder<EstimatedController>(
              init: EstimatedController(),
              builder: (estimatedCtrl) {
                return CustomTextField(
                  controller: searchCtrl.searchTextEditingCtrl,

                  focusNode: searchfocusNode,

                  // readOnly: true,
                  labelText: "Item Name",
                  hintStyle: CustomTextStyle.smallRegularStyleWhite,
                  // suffixIcon: InkWell(
                  //   onTap: () {
                  //     searchCtrl.searchTextEditingCtrl!.clear();

                  //     searchCtrl.hideOverlay();
                  //     searchfocusNode!.unfocus();
                  //   },
                  //   child: const Icon(
                  //     Icons.clear,
                  //     color: CustomColors.grey,
                  //     size: 20,
                  //   ),
                  // ),
                  onChanged: (string) {
                    _debouncer.run(() {
                      debugPrint(string);
                      estimatedCtrl.serviceAndMaterialItemDetailsForm!
                          .itemType = widget.itemType;
                      estimatedCtrl
                          .serviceAndMaterialItemDetailsForm!.itemName = string;
                      print("Perform on search");
                      searchCtrl.fetchItemSearchList(widget.itemType);

                      //perform search here
                    });
                  },
                );
              });
        });
  }
}

Widget buildOverlay() => GetBuilder<SearchControl>(
    init: SearchControl(),
    builder: (searchCtrl) {
      return Visibility(
        visible: searchCtrl.searchDataList.isNotEmpty,
        child: Material(
          elevation: 8,
          child: SizedBox(
            height: Get.height / 3,
            child: ListView.builder(
              padding: const EdgeInsets.all(15.0),
              shrinkWrap: true,
              physics: const ScrollPhysics(),
              itemCount: searchCtrl.searchDataList.length,
              itemBuilder: (buidContext, index) {
                ServiceandMaterialItemModel? searchData =
                    searchCtrl.searchDataList[index];
                return Card(
                  child: GetBuilder<EstimatedController>(
                      init: EstimatedController(),
                      builder: (estimatedCtrl) {
                        return ListTile(
                          // search type 1 for topic , 2 for consultant

                          title: Text(
                            searchData!.itemName ?? "",
                            style: CustomTextStyle.normalBoldStyleBlack,
                          ),
                          subtitle: Text(searchData.itemDescription ?? ""),

                          onTap: () async {
                            await searchCtrl.hideOverlay();
                            searchCtrl.searchTextEditingCtrl!.text =
                                searchData.itemName!;
                            searchCtrl.searchDataList.clear();
                            estimatedCtrl.addDataToServiceAndMaterialItemModel(
                                searchData);
                            // if (searchData.type == 2) {
                            //   PageNavigationService.generalNavigation(
                            //     "/ConsultantProfileScreen",
                            //     arguments: searchData.id,
                            //   );
                            // } else if (searchData.type == 1) {
                            //   if (searchData.topicMarker == "_country_") {
                            //     PageNavigationService.generalNavigation(
                            //         "/CountryDetailsScreen",
                            //         arguments: searchData.id);
                            //   } else if (searchData.topicMarker ==
                            //       "_event_") {
                            //     PageNavigationService.generalNavigation(
                            //         "/EventDetailsScreen",
                            //         arguments: searchData.id);
                            //   }
                            // }
                          },
                        );
                      }),
                );
              },
            ),
          ),
        ),
      );
    });
