import 'package:flutter/material.dart';
import 'package:new_version/new_version.dart';

void newVersionCheck(BuildContext context) async {
  final newVersion = NewVersion(
      // androidId: "com.snapchat.android",
      );
  final VersionStatus? status = await newVersion.getVersionStatus();

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
}
