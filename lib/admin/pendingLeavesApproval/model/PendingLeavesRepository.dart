import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../constants/constants.dart';
import '../../../Sqlite/admin_sqliteHelper.dart';
import 'PendingLeavesModel.dart';

class PendingLeavesRepository {

  Future<List<PendingLeavesModel>> fetchPendingLeaves() async {
    if (kUseMockApi) {
      return [
        PendingLeavesModel(
          id: 1,
          cardNo: 'EMP001',
          empName: 'Employee 1',
          deptName: 'IT',
          punchDatetime: DateTime.now().subtract(const Duration(hours: 1)),
          location: 'Office',
          latitude: 24.7136,
          longitude: 46.6753,
          imageData: null,
          imeiNo: '000000000000000',
          temp1: null,
          temp2: null,
          attendanceType: 'IN',
          remark1: '',
          imagepath: '',
        ),
      ];
    }
    try {
      // Retrieve corporate_id from SQLite table
      final adminDbHelper = AdminDatabaseHelper();
      final adminData = await adminDbHelper.getAdmins();

      if (adminData.isNotEmpty) {
        final String? corporateId = adminData.first['corporate_id'];

        if (corporateId == null) {
          print('Corporate ID is null in SQLite table');
          return [];
        }

        final String apiUrl = 'http://62.171.184.216:9595/api/admin/location/GetUnApproved?CorporateId=$corporateId';

        final response = await http.get(Uri.parse(apiUrl));
        if (response.statusCode == 200) {
          final List<dynamic> jsonList = json.decode(response.body);
          print('Received JSON Data: $jsonList');
          List<PendingLeavesModel> pendingLeavesList = jsonList
              .map((data) => PendingLeavesModel.fromJson(data))
              .toList();
          return pendingLeavesList;
        } else {
          throw Exception('Failed to load pending leaves data');
        }
      } else {
        print('No admin data found in the SQLite table');
        return [];
      }
    } catch (e) {
      // Handle any errors that might occur during the process
      print('Error: $e');
      return [];
    }
  }
}
