// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:indexax/tools/constants.dart';
import 'package:indexax/tools/number_formatting.dart';
import 'package:indexax/models/account.dart';

// Collapsed version of the account summary.
// This is the default view in portrait mode, as well as landscape mode in smaller screens.

class CollapsedAccountSummary extends StatelessWidget {
  const CollapsedAccountSummary({
    Key? key,
    required this.accountData,
  }) : super(key: key);
  final Account? accountData;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
              Text(
                'account_summary.value'.tr(),
                textAlign: TextAlign.left,
                style: Theme.of(context).textTheme.labelLarge,
              ),
              RichText(
                text: TextSpan(children: [
                  TextSpan(
                    text: getInvestmentAsString(accountData!.investment) + " ",
                    style: kCardSubTextStyle,
                  ),
                  TextSpan(
                    text: getPLAsString(accountData!.profitLoss),
                    style: kCardSubTextStyle.copyWith(
                      color: accountData!.profitLossColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ]),
              ),
            ],),
            RichText(
              text: TextSpan(children: [
                TextSpan(
                  text:
                      getWholeBalanceAsString(accountData!.totalAmount),
                  style: kCardPrimaryContentTextStyle.copyWith(color: Theme.of(context).colorScheme.onSurface),
                ),
                TextSpan(
                  text: getDecimalSeparator() +
                      getFractionalBalanceAsString(accountData!.totalAmount),
                  style: kCardSecondaryContentTextStyle.copyWith(color: Theme.of(context).colorScheme.onSurface),
                ),
              ]),
            ),
          ],
        ),
        Divider(
          height: 15,
        ),
        Container(
          height: 55,
          child: Padding(
            padding: const EdgeInsets.only(top: 7),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Align(
                        alignment: Alignment.topLeft,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'account_summary.return'.tr() + ' ',
                              textAlign: TextAlign.left,
                              style: Theme.of(context).textTheme.labelLarge,
                            ),
                            Icon(
                              Icons.access_time,
                              color: Colors.grey,
                              size: 15.0,
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Row(
                              children: <Widget>[
                            RichText(
                              text: TextSpan(children: [
                                TextSpan(
                                  text: getWholePLPercentAsString(accountData!.timeReturn),
                                  style: kCardPLTextStyle.copyWith(
                                      color: accountData!.timeReturnColor),
                                ),
                                TextSpan(
                                  text: getDecimalSeparator() + getFractionalPLPercentAsString(accountData!.timeReturn),
                                  style: kCardPLTextStyleSmaller.copyWith(
                                      color: accountData!.timeReturnColor),
                                ),
                              ]),
                            ),
                          ]),
                        ],
                      ),
                    ],
                  ),
                ),
                VerticalDivider(
                  indent: 0,
                  thickness: 1,
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Align(
                        alignment: Alignment.topLeft,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'account_summary.return'.tr() + ' ',
                              textAlign: TextAlign.left,
                              style: Theme.of(context).textTheme.labelLarge
                            ),
                            Icon(
                              Icons.euro_symbol,
                              color: Colors.grey,
                              size: 15.0,
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Row(children: <Widget>[
                            RichText(
                              text: TextSpan(children: [
                                TextSpan(
                                  text: getWholePLPercentAsString(accountData!.moneyReturn),
                                  style: kCardPLTextStyle.copyWith(
                                      color: accountData!.moneyReturnColor),
                                ),
                                TextSpan(
                                  text: getDecimalSeparator() + getFractionalPLPercentAsString(accountData!.moneyReturn),
                                  style: kCardPLTextStyleSmaller.copyWith(
                                      color: accountData!.moneyReturnColor),
                                ),
                              ]),
                            ),
                          ]),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Icon(Icons.keyboard_arrow_down_rounded, color: Colors.blue),
          ],
        ),
      ],
    );
  }
}
