import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../constants/constants.dart';
import '../../../Sqlite/admin_sqliteHelper.dart';
import 'AdminDailyReportsModel.dart'; // Import your SQLite helper

class AdminReportsRepository {
  final String baseUrl;

  AdminReportsRepository(this.baseUrl);

  Future<List<AdminDailyReportsModel>> fetchDailyReports(
      List<int> employeeIds, String reportDate) async {
    if (kUseMockApi) {
      return [
        AdminDailyReportsModel(
          empId: employeeIds.isNotEmpty ? employeeIds.first : 1,
          shiftStartTime: DateTime.now().subtract(const Duration(hours: 8)),
          shiftEndTime: DateTime.now(),
          hoursWorked: 8,
          otDuration: 0,
          earlyArrival: 0,
          earlyDeparture: 0,
          lateArrival: 0,
          totalLossHrs: 0,
          status: 'Present',
          reason: null,
          shift: 'General',
          in1: DateTime.now().subtract(const Duration(hours: 8)),
          in2: null,
          out1: DateTime.now(),
          out2: null,
          remark: '',
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

        final employeeIdParams = employeeIds.map((id) => 'employeeIds=$id').join('&');
        final url = '$baseUrl/api/admin/report/getdailyreport?CorporateId=$corporateId&$employeeIdParams&ReportDate=$reportDate';

        final response = await http.get(Uri.parse(url));

        if (response.statusCode == 200) {
          final List<dynamic> data = json.decode(response.body);

          // Convert the JSON data to a list of AdminDailyReportsModel objects
          final reports = data.map((item) => AdminDailyReportsModel.fromJson(item)).toList();

          return reports;
        } else {
          // If the server did not return a 200 OK response,
          // throw an exception.
          throw Exception('Failed to load daily reports');
        }
      } else {
        print('No admin data found in the SQLite table');
        return [];
      }
    } catch (e) {
      // Handle any network or exception errors here.
      print('Exception occurred while fetching daily reports: $e');
      return [];
    }
  }
}
