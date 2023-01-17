import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:indexax/models/account.dart';
import 'package:indexax/tools/number_formatting.dart';
import 'package:indexax/tools/text_styles.dart';

// Expanded version of the account summary.
// Shown when the user clicks the expansion arrow in smaller screens (e.g.: phones).

class ExpandedAccountSummary extends StatelessWidget {
  const ExpandedAccountSummary({
    Key? key,
    required this.accountData,
  }) : super(key: key);
  final Account accountData;

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
                      text: getInvestmentAsString(accountData.investment) + " ",
                      style: roboto15,
                    ),
                    TextSpan(
                      text: getPLAsString(accountData.profitLoss),
                      style: roboto15.copyWith(
                        color: accountData.profitLossColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ]),
                ),
              ],
            ),
            RichText(
              text: TextSpan(children: [
                TextSpan(
                  text: getWholeBalanceAsString(accountData.totalAmount),
                  style: ubuntu40Bold.copyWith(
                      color: Theme.of(context).colorScheme.onSurface),
                ),
                TextSpan(
                  text: getDecimalSeparator() +
                      getFractionalBalanceAsString(accountData.totalAmount),
                  style: roboto20Bold.copyWith(
                      color: Theme.of(context).colorScheme.onSurface),
                ),
              ]),
            ),
          ],
        ),
        Divider(
          height: 15,
        ),
        Container(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 7),
            child: IntrinsicHeight(
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
                            Row(children: <Widget>[
                              RichText(
                                text: TextSpan(children: [
                                  TextSpan(
                                    text: getWholePLPercentAsString(
                                        accountData.timeReturn),
                                    style: ubuntu25Bold.copyWith(
                                        color: accountData.timeReturnColor),
                                  ),
                                  TextSpan(
                                    text: getDecimalSeparator() +
                                        getFractionalPLPercentAsString(
                                            accountData.timeReturn),
                                    style: ubuntu20Bold.copyWith(
                                        color: accountData.timeReturnColor),
                                  ),
                                ]),
                              ),
                            ]),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            RichText(
                              text: TextSpan(children: [
                                TextSpan(
                                  text: "(" +
                                      getPLPercentAsString(
                                          accountData.timeReturnAnnual) +
                                      " " +
                                      'account_summary.annual'.tr() +
                                      ")",
                                  style: roboto14Bold.copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurfaceVariant),
                                ),
                              ]),
                            ),
                          ],
                        )
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
                                style: Theme.of(context).textTheme.labelLarge,
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
                                    text: getWholePLPercentAsString(
                                        accountData.moneyReturn),
                                    style: ubuntu25Bold.copyWith(
                                        color: accountData.moneyReturnColor),
                                  ),
                                  TextSpan(
                                    text: getDecimalSeparator() +
                                        getFractionalPLPercentAsString(
                                            accountData.moneyReturn),
                                    style: ubuntu20Bold.copyWith(
                                        color: accountData.moneyReturnColor),
                                  ),
                                ]),
                              ),
                            ]),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            RichText(
                              text: TextSpan(children: [
                                TextSpan(
                                  text: "(" +
                                      getPLPercentAsString(
                                          accountData.moneyReturnAnnual) +
                                      " " +
                                      'account_summary.annual'.tr() +
                                      ")",
                                  style: roboto14Bold.copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurfaceVariant),
                                ),
                              ]),
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        Divider(
          height: 15,
        ),
        Container(
          child: Padding(
            padding: const EdgeInsets.only(top: 7),
            child: IntrinsicHeight(
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
                              Text('account_summary.volatility'.tr(),
                                  textAlign: TextAlign.left,
                                  style:
                                      Theme.of(context).textTheme.labelLarge),
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
                                    text: getPercentAsString(
                                        accountData.volatility),
                                    style: ubuntu20Bold.copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSurface),
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
                                'account_summary.sharpe'.tr(),
                                textAlign: TextAlign.left,
                                style: Theme.of(context).textTheme.labelLarge,
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
                                    text: getNumberAsStringWithTwoDecimals(
                                        accountData.sharpe),
                                    style: ubuntu20Bold.copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSurface),
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
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Icon(Icons.keyboard_arrow_up_rounded, color: Colors.blue),
          ],
        ),
      ],
    );
  }
}
