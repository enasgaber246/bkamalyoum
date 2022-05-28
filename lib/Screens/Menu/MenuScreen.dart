import 'package:bkamalyoum/Component/MenuCard.dart';
import 'package:flutter/material.dart';

import 'News/NewsScreen.dart';
import 'PrivacyPolicy/PrivacyPolicyScreen.dart';
import 'Setting/SettingScreen.dart';

class MenuScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: [
        MenuCard('اهم الاخبار', 'assets/images/news.svg', () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) =>  NewsScreen()),
          );
        }),
        Divider(
          color: Theme.of(context).dividerColor,
          thickness: 1,
        ),
        MenuCard('اتصل بنا', 'assets/images/call_us.svg', () {}),
        Divider(
          color: Theme.of(context).dividerColor,
          thickness: 1,
        ),
        MenuCard('قيم التطبيق', 'assets/images/rate_app.svg', () {}),
        Divider(
          color: Theme.of(context).dividerColor,
          thickness: 1,
        ),
        MenuCard('شارك التطبيق', 'assets/images/share_app.svg', () {}),
        Divider(
          color: Theme.of(context).dividerColor,
          thickness: 1,
        ),
        MenuCard('الإعدادات', 'assets/images/setting.svg', () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) =>  SettingScreen()),
          );
        }),
        Divider(
          color: Theme.of(context).dividerColor,
          thickness: 1,
        ),
        MenuCard('Privacy Policy', 'assets/images/privacyandpolicy.svg', () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) =>  PrivacyPolicyScreen()),
          );

        }),
        Divider(
          color: Theme.of(context).dividerColor,
          thickness: 1,
        ),
      ],
    );
  }
}
