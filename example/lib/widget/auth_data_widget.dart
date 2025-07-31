import 'package:flutter/material.dart';
import 'package:vkid_flutter_sdk/library_vkid.dart';

class AuthDataWidget extends StatefulWidget {
  final AuthData authData;
  final OAuth oAuth;
  const AuthDataWidget(
      {required this.oAuth, required this.authData, super.key});

  @override
  State<AuthDataWidget> createState() => _AuthDataWidgetState();
}

class _AuthDataWidgetState extends State<AuthDataWidget> {
  @override
  Widget build(BuildContext context) {
    return Text(_authDataText());
  }

  String _authDataText() {
    final authData = widget.authData;
    return """
OAuth: ${widget.oAuth.name}\n
Token: ${authData.token}\n
ID token: ${authData.idToken}\n
User ID: ${authData.userID}\n
Expire time: ${authData.expireTime}\n
First name: ${authData.userData.firstName}\n
Last name: ${authData.userData.lastName}\n
Phone: ${authData.userData.phone}\n
Avatar: ${authData.userData.avatarUrl}\n
Email: ${authData.userData.email}\n
Scopes: ${authData.scopes.join(", ")}\n
            """;
  }
}
