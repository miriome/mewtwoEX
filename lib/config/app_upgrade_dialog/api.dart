import 'package:dartx/dartx.dart';
import 'package:dio/dio.dart';
import 'package:mewtwo/networking/networking.dart';
import 'package:mewtwo/utils.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:pub_semver/pub_semver.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'api.g.dart';

@riverpod
Future<List<({String version, bool forceUpgrade})>> _getUpgradeInfoData(_GetUpgradeInfoDataRef ref) async {
  try {
    final res = await (await Networking.instance).get(path: "config/updateInfo");
    Map response = res.data;
    if (response['status'] == false) {
      return [];
    }
    if (response['data'] != null && response['data'] is Map) {
      final List<({String version, bool forceUpgrade})> result = [];
      final data = response['data'] as Map;
      if (data['dismissable'] != null) {
        result.add((version: (data['dismissable']['version'] as String), forceUpgrade: false));
      }
      if (data['forced'] != null) {
        result.add((version: (data['forced']['version'] as String), forceUpgrade: true));
      }
      return result;
    }
  } on DioException catch (e, s) {
    Log.instance.e(e.toString(), stackTrace: s);
  } catch (e, s) {
    Log.instance.e(e.toString(), stackTrace: s);
  }
  return [];
}

@riverpod

/// Null means no update.
/// bool means dismissable or non dismissable update
Future<bool?> needUpdate(NeedUpdateRef ref) async {
  // TODO: Need to move these logic into server.
  final upgradeInfoData = await ref.watch(_getUpgradeInfoDataProvider.future);
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  final currentVersion = Version.parse(packageInfo.version);
  final upgradeInfo =
      upgradeInfoData.where((info) => Version.parse(info.version).compareTo(currentVersion) > 0).sortedByDescending((info) => Version.parse(info.version));
  if (upgradeInfo.isEmpty) {
    return null;
  }
  final sp = await SharedPreferences.getInstance();
  final isForceUpgrade = upgradeInfo[0].forceUpgrade;
  if (isForceUpgrade) {
    return true;
  }
  if (sp.containsKey("upgrade_dismiss_timestamp")) {
    final timestamp = sp.getInt("upgrade_dismiss_timestamp")!;
    final durationSinceLastDismiss = DateTime.fromMillisecondsSinceEpoch(timestamp).difference(DateTime.now());
    if (durationSinceLastDismiss.inDays < 7) {
      return null;
    }
  }
  return false;
}
