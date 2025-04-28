import 'package:flutter_on_rails/src/imports/exports.dart';
import 'package:minimal_mvn/minimal_mvn.dart';

final MMManager<AppNotifier> appstatemanager = MMManager(
  AppNotifier.new,
  autodispose: true,
);
