import 'package:flutter_on_rails/src/imports/exports.dart';
import '../assets/grouped_icons.dart';

buildBottomNavigationBar(
  BuildContext context,
  AppNotifier provider,
  String url,
) {
  return (provider.state.links.length > 1)
      ? NavigationBar(
        // backgroundColor: hexToColor("#4285F4"),
        destinations: [
          for (var item in provider.state.links)
            NavigationDestination(
              tooltip: item['tooltip'],
              selectedIcon:
                  groupedIcons['selectedIcon'] == null
                      ? null
                      : Icon(groupedIcons['selectedIcon']),
              icon: Icon(
                groupedIcons[item['icon']!.toLowerCase()] ??
                    groupedIcons['info'],
              ),
              label: item['label']!.toUpperCase(),
            ),
        ],
        selectedIndex:
            provider
                .state
                .index, // Set the current index for the BottomNavigationBar
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
      )
      : null;
}
