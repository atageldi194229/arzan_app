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

    String? storeBuildNumberAsString = await GlobalVarService()
        .getValue(GlobalVarKeys.storeAppBuildVersion.name);

    if (storeBuildNumberAsString == null) return;

    int? storeBuildNumber = int.tryParse(storeBuildNumberAsString);
    int? buildNumber = int.tryParse(buildNumberAsString);

    if (storeBuildNumber == null || buildNumber == null) return;

    if (storeBuildNumber <= buildNumber) return;

    // ignore: use_build_context_synchronously
    showDialogNewVersionAvailable(context);
  } catch (error) {
    debugPrint("Error checking new version of app");
    debugPrint(error.toString());
  }
}
