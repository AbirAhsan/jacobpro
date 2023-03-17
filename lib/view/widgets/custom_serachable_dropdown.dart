// import 'package:dropdown_search/dropdown_search.dart';
// import 'package:flutter/material.dart';

// class CustomSearchableDropDown extends StatelessWidget {
//   final String? labelText;
//   final String? hintText;
//   const CustomSearchableDropDown({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return DropdownSearch<dynamic>(
//       popupProps: PopupProps.menu(
//         showSelectedItems: true,
//         // disabledItemFn: (String s) {},
//         // disabledItemFn: (String s) => s.startsWith('I'),
//       ),
//       items:List<dynamic> items ["Brazil", "Italia (Disabled)", "Tunisia", 'Canada'],
//       dropdownDecoratorProps: DropDownDecoratorProps(
//         dropdownSearchDecoration: InputDecoration(
//           labelText: labelText,
//           hintText: hintText,
//         ),
//       ),
//       onChanged: print,
//       selectedItem: "Brazil",
//     );
//   }
// }
