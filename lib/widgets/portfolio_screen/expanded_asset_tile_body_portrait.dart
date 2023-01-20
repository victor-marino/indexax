import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:indexax/models/portfolio_datapoint.dart';
import 'package:indexax/tools/number_formatting.dart';
import 'package:indexax/tools/styles.dart' as text_styles;

// Body of the expanded view of each asset tile for portrait orientation

class ExpandedAssetTileBodyPortrait extends StatelessWidget {
  const ExpandedAssetTileBodyPortrait({
    Key? key,
    required this.assetData,
  }) : super(key: key);

  final PortfolioDataPoint assetData;

  @override
  Widget build(BuildContext context) {
    String instrumentType;
    TextStyle headerSubtitleTextStyle = text_styles.robotoLighter(context, 14);
    TextStyle detailNameTextStyle = text_styles.robotoBold(context, 15);
    TextStyle detailValueTextStyle = text_styles.robotoLighter(context, 15);

    if (assetData.instrumentType == InstrumentType.equity) {
      instrumentType = "asset_details.instrument_type_equity".tr();
    } else if (assetData.instrumentType == InstrumentType.fixed) {
      instrumentType = "asset_details.instrument_type_fixed".tr();
    } else if (assetData.instrumentType == InstrumentType.cash) {
      instrumentType = "asset_details.instrument_type_cash".tr();
    } else {
      instrumentType = "asset_details.instrument_type_other".tr();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Divider(),
        Text(assetData.instrumentCompany!, style: headerSubtitleTextStyle),
        const Divider(),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                  text: '${assetData.instrumentCodeType!}: ',
                  style: detailNameTextStyle),
              TextSpan(
                  text: assetData.instrumentCode, style: detailValueTextStyle),
            ],
          ),
        ),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                  text: '${'asset_details.asset_class'.tr()}: ',
                  style: detailNameTextStyle),
              TextSpan(text: instrumentType, style: detailValueTextStyle),
            ],
          ),
        ),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                  text: '${'asset_details.titles'.tr()}: ',
                  style: detailNameTextStyle),
              TextSpan(
                  text: getNumberAsStringWithMaxDecimals(assetData.titles),
                  style: detailValueTextStyle),
            ],
          ),
        ),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                  text: '${'asset_details.cost'.tr()}: ',
                  style: detailNameTextStyle),
              TextSpan(
                  text: getInvestmentAsString(assetData.cost!),
                  style: detailValueTextStyle),
            ],
          ),
        ),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                  text: '${'asset_details.current_value'.tr()}: ',
                  style: detailNameTextStyle),
              TextSpan(
                  text: getInvestmentAsString(assetData.amount),
                  style: detailValueTextStyle),
            ],
          ),
        ),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                  text: '${'asset_details.profit_loss'.tr()}: ',
                  style: detailNameTextStyle),
              TextSpan(
                  text: getPLAsString(assetData.profitLoss!),
                  style: detailValueTextStyle),
            ],
          ),
        ),
        if (assetData.instrumentDescription !=
            'asset_details.description_not_available'.tr()) ...[
          const Divider(),
          Text('${'asset_details.description'.tr()}: ',
              style: detailNameTextStyle),
          Text(
            assetData.instrumentDescription!,
            style: detailValueTextStyle,
          ),
        ],
      ],
    );
  }
}
