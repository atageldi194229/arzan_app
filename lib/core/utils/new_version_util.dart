import 'package:flutter/material.dart';
import 'package:new_version/new_version.dart';

void newVersionCheck(BuildContext context) async {
  /*
    TODO: remove new_version package then use Firebase Remote Config
    https://stackoverflow.com/questions/58057555/flutter-how-to-check-is-the-app-has-a-new-version
  */
  try {
    final newVersion = NewVersion(
        // androidId: "com.snapchat.android",
        );
    final status = await newVersion.getVersionStatus();

    if (status != null) {
      debugPrint("Current local version ${status.localVersion}");
      debugPrint(
          "Can update to the new version: ${status.canUpdate == true ? 'true' : 'false'}");

      if (!status.canUpdate) return;

      newVersion.showUpdateDialog(
        context: context,
        versionStatus: status,
        dialogTitle: "UPDATE!!!",
        dismissButtonText: "Skip",
        dialogText: "Please update the app from "
            "${status.localVersion} to ${status.storeVersion}",
        updateButtonText: "Update",
        // allowDismissal: false,
      );
    }

    // newVersion.showAlertIfNecessary(context: context);
  } catch (error) {
    debugPrint("Error checking new version of app");
    debugPrint(error.toString());
  }
}
