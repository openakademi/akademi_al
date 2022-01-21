
import 'package:hive/hive.dart';

const box_name = "organization";
const selected_organization_key = "selected_organization";

class OrganizationHiveRepository {
  Box _box;

  Future<void> saveSelectedOrganization(String organizationId, String userId, String organizationName) async {
    await _openBox();
    await _box.put(userId, organizationId);
    if(organizationName != null) {
      await _box.put("organization_name", organizationName);
    }
    await _box.close();

  }

  Future<String> getSelectedOrganization(String userId) async {
    await _openBox();
    final organizationId = await _box.get(userId);
    return organizationId;
  }

  Future<String> getSelectedOrganizationName() async {
    await _openBox();
    final organization = await _box.get("organization_name");
    return organization;
  }

  Future<void> _openBox() async {
    if (!Hive.isBoxOpen(box_name)) {
      _box = await Hive.openBox(box_name);
    }
  }

  void dispose() async {
    await _box.close();
  }
}