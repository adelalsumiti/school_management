// import 'package:fatorty/core/class/crud.dart';

// import 'package:flutter/material.dart';
import 'package:school_management/core/class/curd.dart';
import 'package:school_management/linkapi.dart';

class LoginData {
  Crud crud;
  LoginData(this.crud);

// Login
  login(String emailController, String passwordController) async {
    var response = await crud.postDataLogin(AppLink.login, {
      'email': emailController,
      'password': passwordController,
    });
    print('=============== LoginData Login : $response ===========');
    return response.fold((l) => l, (r) => r);
  }
}
