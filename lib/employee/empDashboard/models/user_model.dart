class Employee {
  final int? empId;
  final String? empName;
  final String? fatherName;
  final String? empCode;
  final String? pwd;
  final String? cardNo;
  final int? companyId;
  final int? deptId;
  final int? desigId;
  final int? branchId;
  final int? otimePoliceId;
  final DateTime? dateofJoin;
  final String? reginDate;
  final int? superiourName;
  final int? shiftId;
  final String? shiftType;
  final String? shiftPatternId;
  final bool? isAutoShift;
  final String? autoShifts;
  final String? firstOffDay;
  final String? secondOffDayType;
  final String? secondOffDay;
  final int? halfDayShiftId;
  final String? secondWeekOffDays;
  final int? shiftRemaindays;
  final int? cdays;
  final DateTime? shiftStartDate;
  final String? shiftCode;
  final String? halfDayShiftCode;
  final String? imagePath;
  final bool? active;
  final DateTime? onDate;
  final int? byUser;
  final String? emailAddress;
  final String? bsalary;
  final dynamic leaveActive;
  final dynamic laveBalance;
  final String? phoneNo;
  final String? profilePic;
  final int? corpPolicyid;
  final DateTime? dateofBirth;
  final int? gpsactive;
  final String? cardno1;
  final dynamic validitystart;
  final dynamic validityend;
  final dynamic weekTimeZone;
  final dynamic weekTimeZone2;
  final dynamic weekTimeZone3;
  final dynamic weekTimeZone4;
  final dynamic eaddress;
  final String? deviceToken;
  final int? type;
  final dynamic adminnotification;
  final dynamic empDeviceToken;
  final dynamic adminDeviceToken;
  final dynamic activeFlag;
  final dynamic weekTimeZone5;
  final dynamic verifyno;
  final dynamic bankName;
  final dynamic bankAcNumber;
  final dynamic bankIfscCode;
  final String? tourAmt;
  final int? minuts;
  final dynamic branchAccess;
  final int? activeGeo;
  final String? branchNames;
  final String? companyNames;
  final String? deptNames;
  final String? desigNames;
  final dynamic branch;
  final dynamic company;
  final dynamic dept;
  final dynamic desig;
  final dynamic otimePolice;
  final dynamic mstSalaryDetail;

  Employee({
    this.empId,
    this.empName,
    this.fatherName,
    this.empCode,
    this.pwd,
    this.cardNo,
    this.companyId,
    this.deptId,
    this.desigId,
    this.branchId,
    this.otimePoliceId,
    this.dateofJoin,
    this.reginDate,
    this.superiourName,
    this.shiftId,
    this.shiftType,
    this.shiftPatternId,
    this.isAutoShift,
    this.autoShifts,
    this.firstOffDay,
    this.secondOffDayType,
    this.secondOffDay,
    this.halfDayShiftId,
    this.secondWeekOffDays,
    this.shiftRemaindays,
    this.cdays,
    this.shiftStartDate,
    this.shiftCode,
    this.halfDayShiftCode,
    this.imagePath,
    this.active,
    this.onDate,
    this.byUser,
    this.emailAddress,
    this.bsalary,
    this.leaveActive,
    this.laveBalance,
    this.phoneNo,
    this.profilePic,
    this.corpPolicyid,
    this.dateofBirth,
    this.gpsactive,
    this.cardno1,
    this.validitystart,
    this.validityend,
    this.weekTimeZone,
    this.weekTimeZone2,
    this.weekTimeZone3,
    this.weekTimeZone4,
    this.eaddress,
    this.deviceToken,
    this.type,
    this.adminnotification,
    this.empDeviceToken,
    this.adminDeviceToken,
    this.activeFlag,
    this.weekTimeZone5,
    this.verifyno,
    this.bankName,
    this.bankAcNumber,
    this.bankIfscCode,
    this.tourAmt,
    this.minuts,
    this.branchAccess,
    this.activeGeo,
    this.branchNames,
    this.companyNames,
    this.deptNames,
    this.desigNames,
    this.branch,
    this.company,
    this.dept,
    this.desig,
    this.otimePolice,
    this.mstSalaryDetail,
  });

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      empId: json['empId'],
      empName: json['empName'],
      fatherName: json['fatherName'],
      empCode: json['empCode'],
      pwd: json['pwd'],
      cardNo: json['cardNo'],
      companyId: json['companyId'],
      deptId: json['deptId'],
      desigId: json['desigId'],
      branchId: json['branchId'],
      otimePoliceId: json['otimePoliceId'],
      dateofJoin: json['dateofJoin'] != null
          ? DateTime.tryParse(json['dateofJoin'].toString())
          : null,
      reginDate: json['reginDate'],
      superiourName: json['superiourName'],
      shiftId: json['shiftId'],
      shiftType: json['shiftType'],
      shiftPatternId: json['shiftPatternId'],
      isAutoShift: json['isAutoShift'],
      autoShifts: json['autoShifts'],
      firstOffDay: json['firstOffDay'],
      secondOffDayType: json['secondOffDayType'],
      secondOffDay: json['secondOffDay'],
      halfDayShiftId: json['halfDayShiftId'],
      secondWeekOffDays: json['secondWeekOffDays'],
      shiftRemaindays: json['shiftRemaindays'],
      cdays: json['cdays'],
      shiftStartDate: json['shiftStartDate'] != null
          ? DateTime.tryParse(json['shiftStartDate'].toString())
          : null,
      shiftCode: json['shiftCode'],
      halfDayShiftCode: json['halfDayShiftCode'],
      imagePath: json['imagePath'],
      active: json['active'],
      onDate: json['onDate'] != null
          ? DateTime.tryParse(json['onDate'].toString())
          : null,
      byUser: json['byUser'],
      emailAddress: json['emailAddress'],
      bsalary: json['bsalary'],
      leaveActive: json['leaveActive'],
      laveBalance: json['laveBalance'],
      phoneNo: json['phoneNo'],
      profilePic: json['profilePic'],
      corpPolicyid: json['corpPolicyid'],
      dateofBirth: json['dateofBirth'] != null
          ? DateTime.tryParse(json['dateofBirth'].toString())
          : null,
      gpsactive: json['gpsactive'],
      cardno1: json['cardno1'],
      validitystart: json['validitystart'],
      validityend: json['validityend'],
      weekTimeZone: json['weekTimeZone'],
      weekTimeZone2: json['weekTimeZone2'],
      weekTimeZone3: json['weekTimeZone3'],
      weekTimeZone4: json['weekTimeZone4'],
      eaddress: json['eaddress'],
      deviceToken: json['deviceToken'],
      type: json['type'],
      adminnotification: json['adminnotification'],
      empDeviceToken: json['empDeviceToken'],
      adminDeviceToken: json['adminDeviceToken'],
      activeFlag: json['activeFlag'],
      weekTimeZone5: json['weekTimeZone5'],
      verifyno: json['verifyno'],
      bankName: json['bankName'],
      bankAcNumber: json['bankAcNumber'],
      bankIfscCode: json['bankIfscCode'],
      tourAmt: json['tourAmt'],
      minuts: json['minuts'],
      branchAccess: json['branchAccess'],
      activeGeo: json['activeGeo'],
      branchNames: json['branchNames'],
      companyNames: json['companyNames'],
      deptNames: json['deptNames'],
      desigNames: json['desigNames'],
      branch: json['branch'],
      company: json['company'],
      dept: json['dept'],
      desig: json['desig'],
      otimePolice: json['otimePolice'],
      mstSalaryDetail: json['mstSalaryDetail'],
    );
  }
}