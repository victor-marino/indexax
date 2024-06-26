import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:indexax/screens/settings_screen.dart';
import 'package:indexax/tools/styles.dart' as text_styles;
import 'package:indexax/widgets/settings_screen/logout_popup.dart';
import 'package:indexax/tools/private_mode_provider.dart';
import 'package:provider/provider.dart';

// Pop-up menu that dropws down when clicking the settings wheel.
// Allows the user to:
// 1. Switch between accounts
// 3. Activate private mode
// 3. Access the settings menu
// 4. Logout

class SettingsPopupMenu extends StatelessWidget {
  const SettingsPopupMenu(
      {super.key,
      required this.userAccounts,
      required this.currentAccountIndex,
      required this.currentPage,
      required this.reloadPage});

  final List<Map<String, String>> userAccounts;
  final int currentAccountIndex, currentPage;
  final Function reloadPage;

  @override
  Widget build(BuildContext context) {
    List<PopupMenuEntry> itemList = [];
    double itemHeight = 50;
    TextStyle accountsHeaderTextStyle = text_styles.robotoLighter(context, 14);
    TextStyle currentAccountNumberTextStyle =
        text_styles.robotoBoldLighter(context, 16);
    TextStyle otherAccountNumberTextStyle = text_styles.robotoBold(context, 16);
    TextStyle currentAccountTypeTextStyle =
        text_styles.robotoLighter(context, 14);
    TextStyle otherAccountTypeTextStyle = text_styles.roboto(context, 14);

    itemList.add(
      PopupMenuItem(
        textStyle: accountsHeaderTextStyle,
        enabled: false,
        height: 30,
        child: Text('header.accounts'.tr()),
      ),
    );
    for (int i = 0; i < userAccounts.length; i++) {
      String accountType;
      switch (userAccounts[i]['type']) {
        case 'mutual':
          accountType = 'header.mutual_account'.tr();
          break;
        case 'pension':
          accountType = 'header.pension_account'.tr();
          break;
        case 'epsv':
          accountType = 'header.epsv_account'.tr();
          break;
        case 'employment_plan':
          accountType = 'header.employment_plan_account'.tr();
          break;
        default:
          accountType = userAccounts[i]['type']!;
      }
      itemList.add(PopupMenuItem(
        height: itemHeight,
        value: i,
        enabled: i != currentAccountIndex,
        child: Row(
          children: [
            Container(
              width: 26,
              alignment: Alignment.centerLeft,
              child: i == currentAccountIndex
                  ? Container(
                      height: 0.8 * itemHeight,
                      width: 4,
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.blue,
                          ),
                          borderRadius: const BorderRadius.horizontal(
                              left: Radius.circular(4)),
                          color: Colors.blue))
                  : null,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(userAccounts[i]['number']!,
                    style: i == currentAccountIndex
                        ? currentAccountNumberTextStyle
                        : otherAccountNumberTextStyle),
                Text(accountType,
                    style: i == currentAccountIndex
                        ? currentAccountTypeTextStyle
                        : otherAccountTypeTextStyle),
              ],
            ),
          ],
        ),
      ));
    }
    itemList.add(const PopupMenuDivider());
    itemList.add(PopupMenuItem(
      height: itemHeight,
      value: "private_mode",
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'header.private_mode'.tr(),
            style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
          ),
          IconButton(
              icon: const Icon(Icons.visibility_off_rounded),
              color: Theme.of(context).colorScheme.onSurface,
              disabledColor:
                  context.watch<PrivateModeProvider>().privateModeEnabled
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).colorScheme.onSurfaceVariant,
              onPressed: null),
        ],
      ),
    ));
    itemList.add(PopupMenuItem(
      height: itemHeight,
      value: "settings",
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'header.settings'.tr(),
            style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
          ),
          IconButton(
              icon: const Icon(Icons.checklist),
              color: Theme.of(context).colorScheme.onSurface,
              disabledColor: Theme.of(context).colorScheme.onSurfaceVariant,
              onPressed: null),
        ],
      ),
    ));
    itemList.add(PopupMenuItem(
      height: itemHeight,
      value: "logout",
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('header.logout'.tr(),
              style: TextStyle(color: Theme.of(context).colorScheme.onSurface)),
          IconButton(
              icon: const Icon(Icons.logout),
              color: Colors.red.shade900,
              disabledColor: Colors.red.shade900,
              onPressed: null),
        ],
      ),
    ));

    return PopupMenuButton(
      color: Theme.of(context).colorScheme.background,
      position: PopupMenuPosition.under,
      tooltip: "",
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
      onSelected: (dynamic value) {
        switch (value) {
          case "private_mode":
            context.read<PrivateModeProvider>().togglePrivateMode(context);
            break;
          case "settings":
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => const SettingsScreen()));
            break;
          case "logout":
            showDialog(
                context: context,
                builder: (BuildContext context) => const LogoutPopup());
            break;
          default:
            if (value != currentAccountIndex) {
              reloadPage(value, currentPage);
            }
        }
      },
      itemBuilder: (context) {
        return itemList;
      },
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(Icons.settings, color: Colors.blue),
          Icon(Icons.arrow_drop_down_rounded, color: Colors.blue)
        ],
      ),
    );
  }
}
