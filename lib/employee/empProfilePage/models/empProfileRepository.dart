import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:preparationapplication/employee/empProfilePage/models/empProfileModel.dart';
import 'package:preparationapplication/constants/constants.dart';
import '../../../Sqlite/sqlite_helper.dart';

class EmpProfileRepository {
  String? coorporateId; // Make it nullable
  late int employeeId;

  EmpProfileRepository() {
    _initialize();
  }

  Future<void> _initialize() async {
    await fetchDatabaseData();
  }

  Future<void> fetchDatabaseData() async {
    try {
      final dbHelper = EmployeeDatabaseHelper();
      coorporateId = await dbHelper.getCoorporateId();
      employeeId = await dbHelper.getLoggedInEmployeeId();
    } catch (e) {
      print("Error fetching data from SQLite: $e");
    }
  }

  Future<List<EmpProfileModel>> getData() async {
    if (kUseMockApi) {
      return [
        EmpProfileModel(
          empId: 1,
          empName: 'Demo Employee',
          fatherName: 'Demo Father',
          password: '******',
          empCode: 'EMP001',
          shiftCode: 'SHIFT-A',
          emailAddress: 'employee@example.com',
          dateofJoin: DateTime.now().subtract(const Duration(days: 365)),
          phoneNo: '0000000000',
          profilePic: '',
        ),
      ];
    }
    await _initialize(); // Ensure initialization is complete.
    if (coorporateId == null || coorporateId!.isEmpty || employeeId == 0) {
      throw Exception("coorporateId or employeeId not initialized");
    }

    String apiUrl =
        "http://62.171.184.216:9595/api/employee/dashboard/profile?CorporateId=$coorporateId&employeeId=$employeeId";

    final headers = {
      'Content-Type': 'application/json',
    };

    final client = http.Client();

    final response = await client.get(
      Uri.parse(apiUrl),
      headers: headers,
    );

    if (response.statusCode == 200) {
      final List<dynamic> responseData = json.decode(response.body);

      final List<EmpProfileModel> empProfileList = responseData.map((item) {
        return EmpProfileModel(
          empId: item["empId"],
          empName: item["empName"] ?? "",
          fatherName: item["fatherName"] ?? "",
          password: item["pwd"] ?? "",
          empCode: item["empCode"] ?? "",
          shiftCode: item["shiftCode"] ?? "",
          emailAddress: item["emailAddress"] ?? "",
          dateofJoin: item["dateofJoin"] != null
              ? DateTime.tryParse(item["dateofJoin"]) ?? DateTime.now()
              : DateTime.now(),
          profilePic: item["profilePic"] ?? "",
          phoneNo: item["phoneNo"] ?? "",
        );
      }).toList();

      return empProfileList;
    } else {
      throw Exception(
          "Failed to fetch data from the API. Status code: ${response.statusCode}");
    }
  }
}
