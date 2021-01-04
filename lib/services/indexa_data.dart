import '../services/networking.dart';
const indexaURL = 'https://api.indexacapital.com';

class IndexaData {
  final String token;

  IndexaData({this.token});

  Future<dynamic> getUserAccounts() async {
    String url = '$indexaURL/users/me';
    List<String> userAccounts = List<String>();
    NetworkHelper networkHelper = NetworkHelper(url, token);
    try {
      var userData = await networkHelper.getData();
      if (userData != null) {
        for (var account in userData['accounts']) {
          userAccounts.add(account['account_number'].toString());
        }
        userAccounts.add("TestAccount");
        return userAccounts;
      }
    } on Exception catch (e) {
      print(e);
      return null;
    }
  }

  Future<dynamic> getAccountPerformanceData(accountNumber) async {
    String url = '$indexaURL/accounts/FHGNB6LM/performance';
    //String url = '$indexaURL/accounts/$accountNumber/performance';
    NetworkHelper networkHelper = NetworkHelper(url, token);
    try {
      var accountPerformanceData = await networkHelper.getData();
      //print('performanceData: ' + accountPerformanceData.toString());
      if (accountPerformanceData != null && accountNumber != "TestAccount") {
        //print(accountPerformanceData);
        return accountPerformanceData;
      } else if (accountPerformanceData != null && accountNumber == "TestAccount") {
        accountPerformanceData['return']['total_amount'] = 9999.99;
        accountPerformanceData['return']['investment'] = 1000.00;
        return accountPerformanceData;
      }
    } on Exception catch (e) {
      print(e);
      return null;
    }
  }

  Future<dynamic> getAccountPortfolioData(accountNumber) async {
    String url = '$indexaURL/accounts/FHGNB6LM/portfolio';
    //String url = '$indexaURL/accounts/$accountNumber/portfolio';
    NetworkHelper networkHelper = NetworkHelper(url, token);
    try {
      var accountPortfolioData = await networkHelper.getData();
      //print('portfolioData: ' + accountPortfolioData.toString());
      if (accountPortfolioData != null) {
        return accountPortfolioData;
      }
    } on Exception catch (e) {
      print(e);
      return null;
    }
  }
}