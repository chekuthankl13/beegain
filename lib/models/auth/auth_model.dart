class AuthModel {
  final String status;
  final String message;
  final Data data;

  AuthModel({required this.status, required this.message, required this.data});

  factory AuthModel.fromJson(Map<String, dynamic> json) => AuthModel(
      status: json['success'].toString(),
      message: json['message'],
      data: Data.fromJson(json['data']));
}

class Data {
  final String token;
  final User user;

  Data({required this.token, required this.user});

  factory Data.fromJson(Map<String, dynamic> json) =>
      Data(token: json['token'], user: User.fromJson(json['user']));
}

class User {
  final String id;
  final String userName;
  final String employeeId;
  final Employee employee;

  User(
      {required this.id,
      required this.userName,
      required this.employeeId,
      required this.employee});

  factory User.fromJson(Map<String, dynamic> json) => User(
      id: json['id'].toString(),
      userName: json['username'],
      employeeId: json['employee_id'].toString(),
      employee: Employee.fromJson(json['employee']));
}

class Employee {
  final String id;
  final String employeeCode;
  final String franchiseId;

  Employee(
      {required this.id,
      required this.employeeCode,
      required this.franchiseId});

  factory Employee.fromJson(Map<String, dynamic> json) => Employee(
      id: json['id'].toString(),
      employeeCode: json['employee_code'],
      franchiseId: json['franchise_id'].toString());
}

// {
//   "success": true,
//   "message": "login successful",
//   "data": {
//     "user": {
//       "id": 10,
//       "username": "MOHAMED FAYIS",
//       "employee_id": 5,
//       "user_type_id": "5",
//       "employee": {
//         "id": 5,
//         "employee_name": "SERVICEADVISOR",
//         "employee_code": "SRVAD",
//         "franchise_id": 2,
//         "franchise": {
//           "id": 2,
//           "franchisee_code": "ONRD"
//         }
//       },
//       "usertype": {
//         "id": 5,
//         "name": "SERVICE ADVISOR"
//       }
//     },
//     "token": "759|YQxwpd8HKNFgq4qPbgJV0ltuF1jWtcvARohvdG8j"
//   }
// }