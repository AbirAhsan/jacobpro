import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:service/view/variables/text_style.dart';
import 'package:service/view/widgets/custom_text_field.dart';

class CupertinoDateTimePicker extends StatelessWidget {
  final String? labelText;
  final TextEditingController? controller;
  final DateTime? minimumDate;
  final int minimumYear;
  final DateTime? maximumDate;
  final int? maximumYear;
  const CupertinoDateTimePicker(
      {super.key,
      this.minimumDate,
      this.minimumYear = 1,
      this.maximumDate,
      this.maximumYear,
      this.controller,
      this.labelText});

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return CustomTextField(
        labelText: labelText,
        controller: controller,
        prefixIcon: const Icon(Icons.calendar_month),
        readOnly: true,
        onTap: () async {
          await showCupertinoModalPopup(
            context: context,
            builder: (BuildContext context) => Container(
              height: 300,
              color: CupertinoColors.white,
              child: Column(
                children: [
                  SizedBox(
                    height: 200,
                    child: CupertinoTheme(
                      data: const CupertinoThemeData(
                          textTheme: CupertinoTextThemeData(
                              dateTimePickerTextStyle:
                                  CustomTextStyle.mediumBoldStyleBlack)),
                      child: CupertinoDatePicker(
                        mode: CupertinoDatePickerMode.date,
                        minimumDate: minimumDate,
                        minimumYear: minimumYear,
                        maximumDate: maximumDate,
                        maximumYear: maximumYear,
                        initialDateTime: controller!.text.isEmpty
                            ? DateTime.now()
                            : DateFormat('dd-MM-yyyy', "en")
                                .parse(controller!.text),
                        onDateTimeChanged: (DateTime date) {
                          controller!.text =
                              DateFormat("dd-MM-yyyy", "en").format(date);
                          print(controller!.text);
                        },
                      ),
                    ),
                  ),
                  CupertinoButton(
                    child: Text('Done'),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),
          );
        },
      );
    });
  }
}
