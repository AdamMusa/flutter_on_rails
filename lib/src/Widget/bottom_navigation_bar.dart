import 'package:flutter_on_rails/src/imports/exports.dart';
import '../assets/grouped_icons.dart';
import 'dart:io' show Platform;
import 'package:flutter/cupertino.dart';

buildBottomNavigationBar(
  BuildContext context,
  AppNotifier provider,
  String url,
) {
  if (provider.state.links.length <= 1) return null;

  final isIOS = Platform.isIOS;

  if (isIOS) {
    return CupertinoTabBar(
      items: [
        for (var item in provider.state.links)
          BottomNavigationBarItem(
            icon: Icon(
              groupedIcons[item['icon']!.toLowerCase()] ?? groupedIcons['info'],
            ),
            activeIcon:
                groupedIcons['selectedIcon'] == null
                    ? null
                    : Icon(groupedIcons['selectedIcon']),
            label: item['label']!.toUpperCase(),
          ),
      ],
      currentIndex: provider.state.index,
      onTap: (selectedIndex) {
        provider.setIndex(selectedIndex);
        url = provider.state.links[provider.state.index]['url'];
        // Load the corresponding URL in the WebView
        if (provider.state.controller != null) {
          if (provider.state.index == 0) {
            provider.state.controller?.loadUrl(
              urlRequest: URLRequest(url: WebUri(url.toString())),
            );
          } else {
            provider.state.controller?.loadUrl(
              urlRequest: URLRequest(
                url: WebUri(
                  provider.state.links[selectedIndex]['url'].toString(),
                ),
              ),
            );
          }
        }
      },
      activeColor: CupertinoColors.activeBlue,
      inactiveColor: CupertinoColors.inactiveGray,
      backgroundColor: CupertinoColors.systemBackground,
      border: const Border(
        top: BorderSide(color: CupertinoColors.separator, width: 0.0),
      ),
    );
  } else {
    return NavigationBar(
      destinations: [
        for (var item in provider.state.links)
          NavigationDestination(
            tooltip: item['tooltip'],
            selectedIcon:
                groupedIcons['selectedIcon'] == null
                    ? null
                    : Icon(groupedIcons['selectedIcon']),
            icon: Icon(
              groupedIcons[item['icon']!.toLowerCase()] ?? groupedIcons['info'],
            ),
            label: item['label']!.toUpperCase(),
          ),
      ],
      selectedIndex: provider.state.index,
      onDestinationSelected: (selectedIndex) {
        provider.setIndex(selectedIndex);
        url = provider.state.links[provider.state.index]['url'];
        // Load the corresponding URL in the WebView
        if (provider.state.controller != null) {
          if (provider.state.index == 0) {
            provider.state.controller?.loadUrl(
              urlRequest: URLRequest(url: WebUri(url.toString())),
            );
          } else {
            provider.state.controller?.loadUrl(
              urlRequest: URLRequest(
                url: WebUri(
                  provider.state.links[selectedIndex]['url'].toString(),
                ),
              ),
            );
          }
        }
      },
      backgroundColor: Theme.of(context).navigationBarTheme.backgroundColor,
      elevation: 8.0,
      height: 80.0,
      labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
    );
  }
}
