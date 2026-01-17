import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../constants/constants.dart';
import '../../../Sqlite/admin_sqliteHelper.dart';
import 'companyModel.dart';

class CompanyRepository {
  final String baseUrl = 'http://62.171.184.216:9595/api/Admin/Company';

  Future<List<Company>> getAllActiveCompanies() async {
    if (kUseMockApi) {
      return [
        Company(
          companyId: 1,
          companyName: 'Company',
          description: '',
          address: '',
          phoneNo: '',
          emailId: '',
          vatNo: '',
          pfNo: '',
          tanNo: '',
          regNo: '',
          esiNo: '',
          panNo: '',
          pf: 0,
          fpf: 0,
          ppf: 0,
          esi: 0,
          addition1: '',
          addition2: '',
          addition3: '',
          addition4: '',
          addition5: '',
          addition6: '',
          addition7: '',
          addition8: '',
          addition9: '',
          addition10: '',
          ded1: '',
          ded2: '',
          ded3: '',
          ded4: '',
          ded5: '',
          fded1: '',
          fded2: '',
          fded3: '',
          fded4: '',
          fded5: '',
          active: true,
          onDate: DateTime.now(),
          byUser: 0,
          mstEmployees: const [],
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

        final Uri uri = Uri.parse('$baseUrl/GetAllActive?CorporateId=$corporateId');

        final response = await http.get(uri);

        if (response.statusCode == 200) {
          final List<dynamic> data = json.decode(response.body);
          final List<Company> companies =
          data.map((item) => Company.fromJson(item)).toList();
          return companies;
        } else {
          print('HTTP Status Code: ${response.statusCode}');
          throw Exception('Failed to load companies');
        }
      } else {
        print('No admin data found in the SQLite table');
        return [];
      }
    } catch (e) {
      // Handle any network or exception errors here.
      print('Exception occurred while fetching companies: $e');
      return [];
    }
  }
}
