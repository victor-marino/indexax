import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import '../models/account.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../tools/constants.dart';
import 'package:indexa_dashboard/widgets/amounts_chart.dart';
import 'package:indexa_dashboard/widgets/account_summary.dart';
import 'package:indexa_dashboard/widgets/reusable_card.dart';
import 'package:indexa_dashboard/widgets/portfolio_chart.dart';
import 'package:indexa_dashboard/widgets/portfolio_legend.dart';
import 'package:indexa_dashboard/widgets/profit_popup.dart';
import 'package:indexa_dashboard/widgets/build_account_switcher.dart';
import 'package:indexa_dashboard/models/account_dropdown_items.dart';
import 'package:indexa_dashboard/widgets/settings_button.dart';
import 'package:indexa_dashboard/models/transaction.dart';
import 'package:indexa_dashboard/widgets/transaction_tile.dart';

const int nbsp = 0x00A0;

class TransactionsScreen extends StatefulWidget {
  const TransactionsScreen({
    Key key,
    this.accountData,
    this.userAccounts,
    this.refreshData,
    this.reloadPage,
    this.currentAccountNumber,
  }) : super(key: key);
  final Account accountData;
  final List<String> userAccounts;
  final Function refreshData;
  final Function reloadPage;
  final int currentAccountNumber;

  @override
  _TransactionsScreenState createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> {
  int currentPage = 3;
  Account accountData;
  Function refreshData;
  int currentAccountNumber;
  List<DropdownMenuItem> dropdownItems = [];

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    // monitor network fetch
    accountData = await refreshData(currentAccountNumber);
    setState(() {});
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }
  
  @override
  void initState() {
    currentAccountNumber = widget.currentAccountNumber;
    accountData = widget.accountData;
    refreshData = widget.refreshData;

    dropdownItems = AccountDropdownItems(userAccounts: widget.userAccounts).dropdownItems;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SmartRefresher(
          enablePullDown: true,
          controller: _refreshController,
          onRefresh: _onRefresh,
          child: ListView.builder(
          padding: const EdgeInsets.all(20),
            itemCount: widget.accountData.transactionList.length,
            itemBuilder: (BuildContext context, int index) {
            bool firstTransactionOfMonth = false;
            bool lastTransactionOfMonth = false;
            if (index == 0) {
              firstTransactionOfMonth = true;
            } else if (widget.accountData.transactionList[index].date.month != widget.accountData.transactionList[index-1].date.month) {
              firstTransactionOfMonth = true;
            }
            if (index == (widget.accountData.transactionList.length - 1)) {
              lastTransactionOfMonth = true;
            } else if (widget.accountData.transactionList[index].date.month != widget.accountData.transactionList[index+1].date.month) {
              lastTransactionOfMonth = true;
            }
              return Container(
                //height: 50,
                child: TransactionTile(transactionData: widget.accountData.transactionList[index], firstTransactionOfMonth: firstTransactionOfMonth, lastTransactionOfMonth: lastTransactionOfMonth),
              );
            }
          ),
        ),
      ),
    );
  }
}
