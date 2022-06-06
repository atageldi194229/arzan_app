import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:tm/core/api/services/global_var_service.dart';
import 'package:tm/ui/helper/arzan_show_dialogs.dart';

void newVersionCheck(BuildContext context) async {
  try {
    // custom new version checker

    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    // String appName = packageInfo.appName;
    // String packageName = packageInfo.packageName;
    // String version = packageInfo.version;
    String buildNumberAsString = packageInfo.buildNumber;

    var globalVar = await GlobalVarService()
        .getValue(GlobalVarKeys.storeAppBuildVersion.name);

    if (globalVar == null) return;
    if (globalVar.value == null) return;

    String storeBuildNumberAsString = globalVar.value ?? "0";

    int? storeBuildNumber = int.tryParse(storeBuildNumberAsString);
    int? buildNumber = int.tryParse(buildNumberAsString);

    if (storeBuildNumber == null || buildNumber == null) return;

    if (storeBuildNumber <= buildNumber) return;

    // ignore: use_build_context_synchronously
    showDialogNewVersionAvailable(context, notes: globalVar.note);
  } catch (error) {
    debugPrint("Error checking new version of app");
    debugPrint(error.toString());
  }
}
