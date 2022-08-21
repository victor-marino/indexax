import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:indexax/models/account.dart';
import 'package:indexax/screens/overview_screen.dart';
import 'package:indexax/screens/portfolio_screen.dart';
import 'package:indexax/screens/evolution_screen.dart';
import 'package:indexax/screens/projection_screen.dart';
import 'package:indexax/screens/transactions_screen.dart';
import 'settings_screen.dart';
import '../services/indexa_data.dart';
import 'package:provider/provider.dart';
import '../tools/bottom_navigation_bar_provider.dart';
import '../widgets/bottom_navigation_bar.dart';
import '../widgets/page_header.dart';
import '../widgets/settings_popup_menu.dart';
import '../widgets/current_account_indicator.dart';
import 'login_screen.dart';
import 'package:indexax/tools/theme_provider.dart';

class RootScreen extends StatefulWidget {
  RootScreen({
    required this.token,
    required this.accountNumber,
    required this.pageNumber,
    this.previousUserAccounts,
  });

  final String token;
  final int accountNumber;
  final int pageNumber;
  final List<Map<String, String>>? previousUserAccounts;

  @override
  _RootScreenState createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  PageController? _pageController;

  List<Map<String, String>>? userAccounts = [];
  Account? currentAccount;
  Future<Account>? accountData;

  // List<DropdownMenuItem> dropdownItems =
  //     AccountDropdownItems(userAccounts: [""]).dropdownItems;

  bool reloading = false;

  Future<Future<Account>?> loadData(int accountNumber) async {
    try {
      userAccounts = await getUserAccounts(widget.token);
      setState(() {
        accountData = getAccountData(
            context, widget.token, accountNumber, currentAccount);
      });
      return accountData;
    } on Exception catch (e) {
      print(e.toString());
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) =>
                  LoginScreen(errorMessage: e.toString())),
          (Route<dynamic> route) => false);
    }
    return null;
  }

  Future<void>? refreshData(int accountNumber) {
    accountData =
        getAccountData(context, widget.token, accountNumber, currentAccount);
    return accountData;
  }

  void reloadData() async {
    setState(() {
      reloading = true;
    });
    await loadData(widget.pageNumber);
    Provider.of<BottomNavigationBarProvider>(context, listen: false)
        .currentIndex = widget.pageNumber;
  }

  void reloadPage(int accountNumber, int pageNumber) async {
    pageNumber = _pageController!.page!.toInt();
    print(pageNumber);
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => RootScreen(
                token: widget.token,
                accountNumber: accountNumber,
                pageNumber: pageNumber,
                previousUserAccounts: userAccounts)));
  }

  void loadSettingsScreen() {
    Navigator.push(context,
        MaterialPageRoute(builder: (BuildContext context) => SettingsScreen()));
  }

  Future<List<Map<String, String>>> getUserAccounts(String token) async {
    IndexaData indexaData = IndexaData(token: token);
    var userAccounts = await indexaData.getUserAccounts();
    // dropdownItems =
    //     AccountDropdownItems(userAccounts: userAccounts).dropdownItems;
    return userAccounts;
  }

  static Future<Account> getAccountData(BuildContext context, String token,
      int accountNumber, Account? currentAccount) async {
    //Account currentAccount;
    IndexaData indexaData = IndexaData(token: token);
    try {
      var userAccounts = await indexaData.getUserAccounts();
      var currentAccountInfo = await indexaData
          .getAccountInfo(userAccounts[accountNumber]['number']);
      var currentAccountPerformanceData = await indexaData
          .getAccountPerformanceData(userAccounts[accountNumber]['number']);
      var currentAccountPortfolioData = await indexaData
          .getAccountPortfolioData(userAccounts[accountNumber]['number']);
      var currentAccountInstrumentTransactionData =
          await indexaData.getAccountInstrumentTransactionData(
              userAccounts[accountNumber]['number']);
      var currentAccountCashTransactionData = await indexaData
          .getAccountCashTransactionData(userAccounts[accountNumber]['number']);
      var currentAccountPendingTransactionData =
          await indexaData.getAccountPendingTransactionData(
              userAccounts[accountNumber]['number']);
      currentAccount = Account(
          accountInfo: currentAccountInfo,
          accountPerformanceData: currentAccountPerformanceData,
          accountPortfolioData: currentAccountPortfolioData,
          accountInstrumentTransactionData:
              currentAccountInstrumentTransactionData,
          accountCashTransactionData: currentAccountCashTransactionData,
          accountPendingTransactionData: currentAccountPendingTransactionData);

      //print(currentAccount);

      return currentAccount;
    } on Exception catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.toString()),
      ));
      print("Couldn't fetch account data");
      print(e);
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) =>
                  LoginScreen(errorMessage: e.toString())),
          (Route<dynamic> route) => false);
      throw (e);
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.previousUserAccounts != null) {
      userAccounts = widget.previousUserAccounts;
      // dropdownItems =
      //     AccountDropdownItems(userAccounts: widget.previousUserAccounts)
      //         .dropdownItems;
    }
    loadData(widget.accountNumber);
    _pageController =
        PageController(initialPage: widget.pageNumber, viewportFraction: 1);
  }

  @override
  void dispose() {
    _pageController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool landscapeOrientation = false;
    double availableWidth = MediaQuery.of(context).size.width;
    double availableHeight = MediaQuery.of(context).size.height;
    double topPadding = 0;

    if (availableHeight <= availableWidth) {
      landscapeOrientation = true;
    }

    if (landscapeOrientation && Platform.isIOS) {
      topPadding = 10;
    }

    return FutureBuilder<Account>(
      future: accountData,
      builder: (BuildContext context, AsyncSnapshot<Account> snapshot) {
        Widget child;
        if (snapshot.connectionState == ConnectionState.done) {
          reloading = false;
        }
        if (snapshot.hasData) {
          // print(userAccounts.toString());
          // bool landscapeOrientation = false;
          // double availableWidth = MediaQuery.of(context).size.width;
          // double availableHeight = MediaQuery.of(context).size.height;

          // if (availableHeight <= availableWidth) {
          //   landscapeOrientation = true;
          // }
          child = Scaffold(
            appBar: AppBar(
              titleSpacing: 20,
              backgroundColor: Theme.of(context).colorScheme.surface,
              foregroundColor: Theme.of(context).colorScheme.onSurface,
              // backgroundColor: Theme.of(context).colorScheme.background,
              // foregroundColor: Theme.of(context).colorScheme.onBackground,
              elevation: 0,
              toolbarHeight: landscapeOrientation ? 40 + topPadding : 100,
              centerTitle: false,
              title: Padding(
                padding: EdgeInsets.only(top: topPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    PageHeader(
                      accountNumber: snapshot.data!.accountNumber,
                      accountType: snapshot.data!.type,
                    ),
                    if (!landscapeOrientation) ...[
                      CurrentAccountIndicator(
                          accountNumber: snapshot.data!.accountNumber,
                          accountType: snapshot.data!.type)
                    ],
                  ],
                ),
              ),
              actions: <Widget>[
                if (landscapeOrientation) ...[
                  Padding(
                    padding: EdgeInsets.only(top: topPadding),
                    child: CurrentAccountIndicator(
                        accountNumber: snapshot.data!.accountNumber,
                        accountType: snapshot.data!.type),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: topPadding),
                    child: SizedBox(width: 10),
                  ),
                ],
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(right: 15),
                  child: SettingsPopupMenu(
                      userAccounts: userAccounts,
                      currentAccountNumber: widget.accountNumber,
                      currentPage: widget.pageNumber,
                      reloadPage: reloadPage),
                ),
                //SizedBox(width: 10)
              ],
            ),
            body: PageView(
              controller: _pageController,
              children: <Widget>[
                OverviewScreen(
                    accountData: snapshot.data,
                    userAccounts: userAccounts,
                    landscapeOrientation: landscapeOrientation,
                    availableWidth: availableWidth,
                    refreshData: refreshData,
                    reloadPage: reloadPage,
                    currentAccountNumber: widget.accountNumber),
                PortfolioScreen(
                    accountData: snapshot.data,
                    userAccounts: userAccounts,
                    landscapeOrientation: landscapeOrientation,
                    availableWidth: availableWidth,
                    refreshData: refreshData,
                    reloadPage: reloadPage,
                    currentAccountNumber: widget.accountNumber),
                EvolutionScreen(
                    accountData: snapshot.data,
                    userAccounts: userAccounts,
                    refreshData: refreshData,
                    reloadPage: reloadPage,
                    landscapeOrientation: landscapeOrientation,
                    availableWidth: availableWidth,
                    currentAccountNumber: widget.accountNumber),
                TransactionsScreen(
                    accountData: snapshot.data,
                    userAccounts: userAccounts,
                    landscapeOrientation: landscapeOrientation,
                    availableWidth: availableWidth,
                    refreshData: refreshData,
                    reloadPage: reloadPage,
                    currentAccountNumber: widget.accountNumber),
                ProjectionScreen(
                    accountData: snapshot.data,
                    userAccounts: userAccounts,
                    landscapeOrientation: landscapeOrientation,
                    availableWidth: availableWidth,
                    refreshData: refreshData,
                    reloadPage: reloadPage,
                    currentAccountNumber: widget.accountNumber),
              ],
              onPageChanged: (page) {
                Provider.of<BottomNavigationBarProvider>(context, listen: false)
                    .currentIndex = page;
              },
            ),
            bottomNavigationBar: MyBottomNavigationBar(onTapped: _onTappedBar),
          );
        } else if (snapshot.hasError) {
          print(snapshot.error);

          if (reloading) {
            child = Center(child: CircularProgressIndicator());
          } else {
            child = Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.error_outline),
                  Text(snapshot.error.toString()),
                  MaterialButton(
                    child: Text(
                      'retry'.tr(),
                    ),
                    color: Colors.blue,
                    textColor: Colors.white,
                    onPressed: reloadData,
                  )
                ],
              ),
            );
          }
        } else {
          child = Center(child: CircularProgressIndicator());
        }
        return child;
      },
    );
  }

  void _onTappedBar(int value) {
    _pageController!.animateToPage(value,
        duration: Duration(milliseconds: 500), curve: Curves.ease);
  }
}
