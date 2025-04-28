// ignore_for_file: use_build_context_synchronously

import 'dart:async';
// import 'dart:convert';

import 'package:flutter_on_rails/src/widget_parser/entry_widget_parser.dart';
import 'package:flutter_on_rails/src/widget_parser/utils.dart';
import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

class ListViewWidgetParser extends WidgetParser {
  @override
  Widget parse(
    Map<String, dynamic> map,
    BuildContext buildContext,
    ClickListener? listener,
  ) {
    var scrollDirection = Axis.vertical;
    if (map.containsKey("scrollDirection") &&
        "horizontal" == map["scrollDirection"]) {
      scrollDirection = Axis.horizontal;
    }

    var reverse = map.containsKey("reverse") ? map['reverse'] : false;
    var shrinkWrap = map.containsKey("shrinkWrap") ? map["shrinkWrap"] : false;
    var cacheExtent =
        map.containsKey("cacheExtent") ? map["cacheExtent"]?.toDouble() : 0.0;
    var padding =
        map.containsKey('padding')
            ? parseEdgeInsetsGeometry(map['padding'])
            : null;
    var itemExtent =
        map.containsKey("itemExtent") ? map["itemExtent"]?.toDouble() : null;
    var children = WidgetParserBuilder.buildWidgets(
      map['children'],
      buildContext,
      listener,
    );
    var pageSize = map.containsKey("pageSize") ? map["pageSize"] : 10;
    var loadMoreUrl =
        map.containsKey("loadMoreUrl") ? map["loadMoreUrl"] : null;
    var isDemo = map.containsKey("isDemo") ? map["isDemo"] : false;

    var params = ListViewParams(
      scrollDirection: scrollDirection,
      reverse: reverse,
      shrinkWrap: shrinkWrap,
      cacheExtent: cacheExtent,
      padding: padding,
      itemExtent: itemExtent,
      children: children,
      pageSize: pageSize,
      loadMoreUrl: loadMoreUrl,
      isDemo: isDemo,
    );

    return ListViewWidget(params, buildContext);
  }

  @override
  String get widgetName => "ListView";

  @override
  Type get widgetType => ListViewWidget;
}

class ListViewWidget extends StatefulWidget {
  final ListViewParams _params;
  final BuildContext _buildContext;

  const ListViewWidget(this._params, this._buildContext, {super.key});

  @override
  // ignore: library_private_types_in_public_api, no_logic_in_create_state
  _ListViewWidgetState createState() => _ListViewWidgetState(_params);
}

class _ListViewWidgetState extends State<ListViewWidget> {
  final ListViewParams _params;
  final List<Widget?> _items = [];

  final ScrollController _scrollController = ScrollController();
  bool isPerformingRequest = false;

  //If there are no more items, it should not try to load more data while scroll
  //to bottom.
  bool loadCompleted = false;

  _ListViewWidgetState(this._params) {
    if (_params.children != null) {
      _items.addAll(_params.children!);
    }
  }

  @override
  void initState() {
    super.initState();
    if (_params.loadMoreUrl == null || _params.loadMoreUrl!.isEmpty) {
      loadCompleted = true;
      return;
    }
    _scrollController.addListener(() {
      if (!loadCompleted &&
          _scrollController.position.pixels ==
              _scrollController.position.maxScrollExtent) {
        // _getMoreData();
      }
    });
  }

  // _getMoreData() async {
  //   if (!isPerformingRequest) {
  //     setState(() => isPerformingRequest = true);
  //     var jsonString =
  //         _params.isDemo! ? await fakeRequest() : await doRequest();
  //     var buildWidgets = WidgetParserBuilder.buildWidgets(
  //         jsonDecode(jsonString), widget._buildContext, null);
  //     setState(() {
  //       if (buildWidgets.isEmpty) {
  //         loadCompleted = true;
  //       }
  //       _items.addAll(buildWidgets);
  //       isPerformingRequest = false;
  //     });
  //   }
  // }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Widget _buildProgressIndicator() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Opacity(
          opacity: isPerformingRequest ? 1.0 : 0.0,
          child: const CircularProgressIndicator(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: _params.scrollDirection ?? Axis.vertical,
      reverse: _params.reverse ?? false,
      shrinkWrap: _params.shrinkWrap ?? false,
      cacheExtent: _params.cacheExtent,
      padding: _params.padding,
      itemCount: loadCompleted ? _items.length : _items.length + 1,
      itemBuilder: (context, index) {
        if (index == _items.length) {
          return _buildProgressIndicator();
        } else {
          return _items[index]!;
        }
      },
      controller: _scrollController,
    );
  }

  fakeRequest() async {
    return Future.delayed(const Duration(seconds: 2), () {
      return """
[
    {
      "type": "AssetImage",
      "name": "assets/vip.png"
    },
    {
      "type": "AssetImage",
      "name": "assets/vip.png"
    },
    {
      "type": "AssetImage",
      "name": "assets/vip.png"
    },
    {
      "type": "AssetImage",
      "name": "assets/vip.png"
    },
    {
      "type": "AssetImage",
      "name": "assets/vip.png"
    }
]          
      """;
    });
  }

  // doRequest() async {
  //   // Await the http get response, then decode the json-formatted responce.
  //   try {
  //     var response = await http.get(Uri.parse(getLoadMoreUrl(
  //         _params.loadMoreUrl, _items.length, _params.pageSize)!));
  //     if (response.statusCode == 200) {
  //       return response.body;
  //     }
  //   } on Exception catch (e) {
  //     debugPrint(e.toString());
  //   }
  //   return "";
  // }
}

class ListViewParams {
  Axis? scrollDirection;
  bool? reverse;
  bool? shrinkWrap;
  double? cacheExtent;
  EdgeInsetsGeometry? padding;
  double? itemExtent;
  List<Widget?>? children;

  /// use to data binding
  String? dataKey;

  /// use to data binding
  Widget? tempChild;

  int? pageSize;
  String? loadMoreUrl;

  //use for demo, if true, it will do the fake request.
  bool? isDemo;

  ListViewParams({
    this.scrollDirection,
    this.reverse,
    this.shrinkWrap,
    this.cacheExtent,
    this.padding,
    this.itemExtent,
    this.children,
    this.pageSize,
    this.loadMoreUrl,
    this.isDemo,
    this.tempChild,
    this.dataKey,
  }) {
    // assert(this.children != null || this.tempChild != null,
    //     "you must set one of [children] or [tempChild]");
    // if (this.tempChild != null) {
    //   assert(this.dataKey != null && this.children == null,
    //       "you must set [dataKey] and [children] not to set");
    // }
    // if (this.children != null) {
    //   assert(this.dataKey == null && this.tempChild == null,
    //       "do not set any dataKey and tempChild");
    // }
  }
}
