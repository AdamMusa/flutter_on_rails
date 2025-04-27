import 'package:flutterx/imports/exports.dart';
import 'package:minimal_mvn/minimal_mvn.dart';

final MMManager<AppNotifier> appstatemanager = MMManager(
  AppNotifier.new,
  autodispose: true,
);
