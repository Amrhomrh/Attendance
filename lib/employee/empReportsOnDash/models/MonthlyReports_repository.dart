import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:preparationapplication/Sqlite/sqlite_helper.dart'; // Adjust the import path based on your project structure
import 'package:preparationapplication/constants/constants.dart';
import 'empMonthlyReportsModel.dart';

class MonthlyReportsRepository {
  final String baseUrl =
      'http://62.171.184.216:9595/api/employee/report/getmonthlyreport';

  Future<Map<String, dynamic>> getEmployeeData() async {
    try {
      final dbHelper = EmployeeDatabaseHelper.instance;
      final firstEmployee = await dbHelper.getFirstEmployee();

      if (firstEmployee != null) {
        final String corporateId = firstEmployee['corporate_id'] as String;
        final int employeeId = firstEmployee['id'] as int;
        return {'corporateId': corporateId, 'employeeId': employeeId};
      } else {
        // Handle the case where no employee data is found
        // Set default values or throw an exception as needed
        print("No employee data found in the database.");
        throw Exception("Employee data not found in the database");
      }
    } catch (e) {
      // Handle any database error
      print("Error fetching data from the database: $e");
      throw Exception("Failed to fetch employee data from the database");
    }
  }

  Future<List<MonthlyReportsModel>> getMonthlyReports({
    required int month,
    required int year,
  }) async {
    if (kUseMockApi) {
      return [
        MonthlyReportsModel(
          shiftStartTime: '09:00',
          shiftEndTime: '17:00',
          hoursWorked: 8,
          status: 'Present',
          otDuration: 0,
          earlyArrival: 0,
          earlyDeparture: 0,
          lateArrival: 0,
          totalLossHours: 0,
          reason: '',
          shift: 'SHIFT-A',
          in1: '09:02',
          in2: null,
          out1: null,
          out2: '17:00',
          remark: 'Demo',
        ),
      ];
    }
    try {
      final employeeData = await getEmployeeData();
      final String corporateId = employeeData['corporateId'] as String;
      final int employeeId = employeeData['employeeId'] as int;

      final Uri uri = Uri.parse(
          '$baseUrl?CorporateId=$corporateId&employeeId=$employeeId&Month=$month&year=$year');

      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);

        List<MonthlyReportsModel> reports =
        data.map((item) => MonthlyReportsModel.fromJson(item)).toList();
        print(response.body);
        return reports;
      } else {
        throw Exception(
            'Failed to load monthly reports. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Failed to load monthly reports: $e');
    }
  }



}
