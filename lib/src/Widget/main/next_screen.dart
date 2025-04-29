// ignore_for_file: must_be_immutable, use_build_context_synchronously

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_on_rails/src/helpers/responds_to.dart';
import 'package:flutter_on_rails/src/minimal/manager/manager.dart';
import 'package:flutter_on_rails/src/services/run_js.dart';
import 'package:logging/logging.dart';

// Add at the top of the file, outside any class
final _logger = Logger('NextScreen');

class NextPage extends StatelessWidget {
  NextPage({super.key, required this.url});
  final provider = appstatemanager.notifier;
  final String url;
  String userAgent =
      "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36";
  InAppWebViewController? _controller;
  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: provider,
      builder: (context, _) {
        return SafeArea(
          bottom: false,
          child: Scaffold(
            appBar:
                provider.state.navapi["action"] != "replace"
                    ? AppBar(
                      backgroundColor: setBackgroundColor(provider),
                      title: Text(
                        setTitle(provider),
                        style: TextStyle(color: setLeadingColor(provider)),
                      ),
                      leading: IconButton(
                        color: setLeadingColor(provider),
                        icon: const Icon(Icons.arrow_back),
                        onPressed: () async {
                          provider.setNavigable(false);
                          provider.state.controller!.goBack();
                          Navigator.of(context).pop();
                        },
                      ),
                      actions:
                          provider.state.form.isEmpty
                              ? null
                              : [
                                setActionWidgetForForm(
                                  provider.state.nextScreenController!,
                                  provider,
                                  provider.state.form,
                                ),
                              ],
                    )
                    : null,
            body: InAppWebView(
              initialUrlRequest: URLRequest(url: WebUri(url)),
              onWebViewCreated: (InAppWebViewController controller) async {
                provider.setNextScreenController(controller);
                controller.addJavaScriptHandler(
                  handlerName: "inputFocus",
                  callback: (args) async {
                    final actionJson = args[0];
                    _logger.info(
                      "Received from JS: ${json.decode(actionJson.toString())}",
                    );
                  },
                );
              },
              onLoadStart: (controller, url) async {
                // Set appropriate user agent for the URL
              },
              onLoadStop: (controller, url) async {
                await RunJs().handleForm(
                  provider.state.nextScreenController!,
                  provider,
                );
              },
              shouldOverrideUrlLoading: (controller, navigationAction) async {
                return NavigationActionPolicy.ALLOW;
              },
            ),
          ),
        );
      },
    );
  }
}
