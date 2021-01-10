import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:indexa_dashboard/models/amounts_datapoint.dart';
import 'package:indexa_dashboard/tools/constants.dart';
import 'package:indexa_dashboard/tools/number_formatting.dart';
import 'package:indexa_dashboard/models/account.dart';

class AccountSummary extends StatelessWidget {
  const AccountSummary({
    Key key,
    @required this.accountData,
  }) : super(key: key);
  final Account accountData;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                'VALOR',
                textAlign: TextAlign.left,
                style: kCardTitleTextStyle,
              ),
            ),
            RichText(
              text: TextSpan(children: [
                TextSpan(
                  text:
                      getBalanceAsString(accountData.totalAmount).split(',')[0],
                  style: kCardPrimaryContentTextStyle,
                ),
                TextSpan(
                  text: ',' +
                      getBalanceAsString(accountData.totalAmount).split(',')[1],
                  style: kCardSecondaryContentTextStyle,
                ),
              ]),
            ),
            RichText(
              text: TextSpan(children: [
                TextSpan(
                  text: 'Aportado: ' +
                      getInvestmentAsString(accountData.investment),
                  //textAlign: TextAlign.left,
                  style: kCardSubTextStyle,
                ),
              ]),
            ),
            RichText(
              text: TextSpan(children: [
                // TextSpan(
                //   text: "Ganancia: ",
                //   style: kCardSubTextStyle,
                // ),
                TextSpan(
                  text: getPLAsString(accountData.profitLoss),
                  style: kCardSubTextStyle.copyWith(
                    color: accountData.profitLossColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ]),
            )
          ],
        ),
        Divider(),
        IntrinsicHeight(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Column(
                  //mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Align(
                      alignment: Alignment.topLeft,
                      child: Row(
                        children: [
                          Text(
                            'RENTABILIDAD ',
                            textAlign: TextAlign.left,
                            style: kCardTitleTextStyle,
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
                                text: getPLPercentAsString(accountData.timeReturn)
                                    .split(",")[0],
                                style: kCardPLTextStyle.copyWith(
                                    color: accountData.timeReturnColor),
                              ),
                              TextSpan(
                                text: "," + getPLPercentAsString(accountData.timeReturn)
                                    .split(",")[1],
                                style: kCardPLTextStyleSmaller.copyWith(
                                    color: accountData.timeReturnColor),
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
                //width: 2,
                thickness: 1,
                //color: Colors.black,
              ),
              Expanded(
                flex: 1,
                child: Column(
                  //mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Align(
                      alignment: Alignment.topLeft,
                      child: Row(
                        children: [
                          Text(
                            'RENTABILIDAD ',
                            textAlign: TextAlign.left,
                            style: kCardTitleTextStyle,
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
                                text: getPLPercentAsString(accountData.moneyReturn)
                                    .split(",")[0],
                                style: kCardPLTextStyle.copyWith(
                                    color: accountData.moneyReturnColor),
                              ),
                              TextSpan(
                                text: "," + getPLPercentAsString(accountData.moneyReturn)
                                    .split(",")[1],
                                style: kCardPLTextStyleSmaller.copyWith(
                                    color: accountData.moneyReturnColor),
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
      ],
    );
  }
}
