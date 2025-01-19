import 'package:school_management/core/class/curd.dart';
import 'package:school_management/linkapi.dart';

class SignUpData {
  Crud crud;
  SignUpData(this.crud);

// SignUp
  signUp(
      String emailController,
      String passwordController,
      String nameController,
      String phoneNumberController,
      String addressConteroller,
      String role) async {
    var response = await crud.postDataSignUp(AppLink.createUser, {
      "name": nameController,
      "email": emailController,
      "password": passwordController,
      "phone_number": phoneNumberController,
      "address": addressConteroller,
      "role": role,
    });
    print('=============== SignUpData Login : $response ===========');
    return response.fold((l) => l, (r) => r);
  }
}
