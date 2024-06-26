import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:indexax/tools/number_formatting.dart';
import 'package:indexax/tools/private_mode_provider.dart';
import 'package:indexax/tools/styles.dart' as text_styles;
import 'package:provider/provider.dart';

// Text showing the minimum amount required for Indexa to make new fund purchases

class MinimumTransferCard extends StatelessWidget {
  const MinimumTransferCard({
    super.key,
    required this.additionalCashNeededToTrade,
  });

  final double additionalCashNeededToTrade;

  @override
  Widget build(BuildContext context) {
    TextStyle itemNameText = text_styles.robotoLighter(context, 15);
    TextStyle itemValueText = text_styles.robotoBoldLighter(context, 15);

    return RichText(
      text: TextSpan(children: [
        TextSpan(
            text:
                '${'minimum_transfer_card.minimum_transfer_to_invest'.tr()}: ',
            style: itemNameText),
        TextSpan(
            text: getInvestmentAsString(additionalCashNeededToTrade,
                maskValue:
                    context.watch<PrivateModeProvider>().privateModeEnabled),
            style: itemValueText),
      ]),
    );
  }
}
