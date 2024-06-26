import 'package:flutter/foundation.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:indexax/models/account.dart';
import 'package:indexax/tools/profit_loss_chart_provider.dart';
import 'package:indexax/tools/snackbar.dart' as snackbar;
import 'package:indexax/tools/styles.dart' as text_styles;
import 'package:indexax/widgets/evolution_screen/evolution_chart_zoom_chips.dart';
import 'package:indexax/widgets/evolution_screen/profit_loss_chart.dart';
import 'package:indexax/widgets/evolution_screen/profit_loss_series_type_toggle.dart';
import 'package:indexax/widgets/evolution_screen/profit_loss_year_switcher.dart';
import 'package:indexax/widgets/reusable_card.dart';
import 'package:indexax/widgets/evolution_screen/evolution_chart.dart';
import 'package:provider/provider.dart';
import 'package:indexax/tools/evolution_chart_provider.dart';
import 'package:indexax/widgets/evolution_screen/evolution_series_type_toggle.dart';
import 'package:indexax/widgets/evolution_screen/evolution_chart_date_selector.dart';

class EvolutionScreen extends StatefulWidget {
  const EvolutionScreen({
    super.key,
    required this.accountData,
    required this.userAccounts,
    required this.refreshData,
    required this.currentAccountIndex,
    required this.landscapeOrientation,
    required this.availableWidth,
  });
  final Account accountData;
  final List<Map<String, String>> userAccounts;
  final Function refreshData;
  final int currentAccountIndex;
  final bool landscapeOrientation;
  final double availableWidth;

  @override
  EvolutionScreenState createState() => EvolutionScreenState();
}

class EvolutionScreenState extends State<EvolutionScreen>
    with AutomaticKeepAliveClientMixin<EvolutionScreen> {
  // The Mixin keeps state of the page instead of reloading it every time
  // It requires this 'wantKeepAlive', as well as the 'super' in the build method down below
  @override
  bool get wantKeepAlive => true;

  Future<void> _onRefresh() async {
    // Monitor network fetch
    try {
      await widget.refreshData(accountIndex: widget.currentAccountIndex);
    } on Exception catch (e) {
      if (kDebugMode) {
        print("Couldn't refresh data");
        print(e);
      }
      if (mounted) snackbar.showInSnackBar(context, e.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    // Set the initial dates of the series in the Evolution Chart Provider
    context.read<EvolutionChartProvider>()
      ..firstDate = widget.accountData.amountsSeries.first.date
      ..lastDate = widget.accountData.amountsSeries.last.date
      ..startDate = widget.accountData.amountsSeries.first.date
      ..endDate = widget.accountData.amountsSeries.last.date;

    // Show the current year by default in the profit loss chart
    context.read<ProfitLossChartProvider>().selectedYear =
        widget.accountData.profitLossSeries.monthlySeries.keys.toList().last;
  }

  @override
  Widget build(BuildContext context) {
    // This super call is required for the Mixin that keeps the page state
    super.build(context);

    TextStyle cardHeaderTextStyle = text_styles.robotoLighter(context, 15);

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SizedBox(
            width: widget.landscapeOrientation && widget.availableWidth > 1000
                ? widget.availableWidth * 0.7
                : null,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: _onRefresh,
                    child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
                        child: Column(
                          children: <Widget>[
                            ReusableCard(
                              paddingBottom:
                                  widget.landscapeOrientation ? 16 : 8,
                              childWidget: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'evolution_screen.evolution'.tr(),
                                          textAlign: TextAlign.left,
                                          style: cardHeaderTextStyle,
                                        ),
                                        showEvolutionSeriesDateSelector(
                                            context),
                                      ]),
                                  const SizedBox(height: 10),
                                  showEvolutionSeriesTypeToggle(context),
                                  EvolutionChart(
                                      amountsSeries:
                                          widget.accountData.amountsSeries,
                                      returnsSeries:
                                          widget.accountData.returnsSeries),
                                  SizedBox(
                                    width: double.infinity,
                                    child: Wrap(
                                      direction: Axis.horizontal,
                                      alignment: widget.availableWidth < 500 ||
                                              widget.landscapeOrientation ==
                                                  false
                                          ? WrapAlignment.center
                                          : WrapAlignment.end,
                                      spacing: 5,
                                      children: evolutionChartZoomChips(
                                          context: context),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            ReusableCard(
                              childWidget: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('evolution_screen.returns'.tr(),
                                          textAlign: TextAlign.left,
                                          style: cardHeaderTextStyle),
                                      ProfitLossYearSwitcher(
                                          yearList: widget
                                              .accountData
                                              .profitLossSeries
                                              .monthlySeries
                                              .keys
                                              .toList()),
                                    ],
                                  ),
                                  const SizedBox(height: 15),
                                  showProfitLossSeriesTypeToggle(context),
                                  SizedBox(
                                    height: 150,
                                    child: ProfitLossChart(
                                        profitLossSeries: widget
                                            .accountData.profitLossSeries),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
