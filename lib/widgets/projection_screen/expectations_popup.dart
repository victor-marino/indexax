import 'package:flutter/material.dart';
import 'package:indexax/tools/styles.dart' as text_styles;
import 'package:easy_localization/easy_localization.dart';

// Informational pop-up explaining how expectations are calculated

class ExpectationsPopUp extends StatelessWidget {
  const ExpectationsPopUp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    TextStyle descriptionTextStyle = text_styles.roboto(context, 16);

    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'expectations_popup.expectations'.tr(),
            style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
          ),
        ],
      ),
      content: SingleChildScrollView(
        child: Text(
          'expectations_popup.expectations_explanation'.tr(),
          style: descriptionTextStyle.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant),
        ),
      ),
      contentPadding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
      actions: [
        TextButton(
          child: const Text('OK'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
