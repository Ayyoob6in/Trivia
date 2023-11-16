class Users {
  final int? usrId;
  final String usrName;
   String? usremail;
  final String usrPassword;
  String? usrConfirmPassword;

  Users({
    this.usrId,
    required this.usrName,
    this.usremail,
    required this.usrPassword,
    this.usrConfirmPassword,
  });

  factory Users.fromMap(Map<String, dynamic> json) => Users(
        usrId: json["usrId"],
        usrName: json["usrName"],
        usremail: json["usremail"],
        usrPassword: json["usrPassword"],
        usrConfirmPassword: json["usrConfirmPassword"]
      );

  Map<String, dynamic> toMap() => {
        "usrId": usrId,
        "usrName": usrName,
        "usremail": usremail,
        "usrPassword": usrPassword,
        "usrConfirmPassword":usrConfirmPassword,
      };
}