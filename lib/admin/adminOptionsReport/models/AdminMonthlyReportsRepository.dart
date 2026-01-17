import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../constants/constants.dart';
import '../../../Sqlite/admin_sqliteHelper.dart';
import 'AdminMonthlyReportModel.dart';


class AdminMonthlyReportsRepository {
  final String baseUrl = 'http://62.171.184.216:9595/api/admin/report/getmonthlyreport';

  Future<List<AdminMonthlyReportsModel>> fetchMonthlyReports(
      List<int> employeeIds, int selectedMonth, int selectedYear) async {
    if (kUseMockApi) {
      return [
        AdminMonthlyReportsModel(
          empId: employeeIds.isNotEmpty ? employeeIds.first : 1,
          shiftStartTime: DateTime(selectedYear, selectedMonth, 1, 9, 0),
          shiftEndTime: DateTime(selectedYear, selectedMonth, 1, 17, 0),
          hoursWorked: 160,
          otDuration: 0,
          earlyArrival: 0,
          earlyDeparture: 0,
          lateArrival: 0,
          totalLossHrs: 0,
          status: 'Present',
          reason: '',
          shift: 'General',
          in1: null,
          in2: null,
          out1: null,
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

        final employeeIdsQuery = employeeIds.map((id) => 'employeeIds=$id').join('&');
        final fullUrl = '$baseUrl?CorporateId=$corporateId&Month=$selectedMonth&Year=$selectedYear&$employeeIdsQuery';

        final response = await http.get(Uri.parse(fullUrl));

        if (response.statusCode == 200) {
          final List<dynamic> jsonList = json.decode(response.body);
          final List<AdminMonthlyReportsModel> reportsList = jsonList
              .map((json) => AdminMonthlyReportsModel.fromJson(json))
              .toList();
          return reportsList;
        } else {
          throw Exception(
              'Failed to fetch monthly reports. Status code: ${response.statusCode}');
        }
      } else {
        print('No admin data found in the SQLite table');
        return [];
      }
    } catch (e) {
      // Handle any network or exception errors here.
      print('Exception occurred while fetching monthly reports: $e');
      return [];
    }
  }

}
