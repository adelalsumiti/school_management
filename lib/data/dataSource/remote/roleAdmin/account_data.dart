import 'package:school_management/core/class/curd.dart';
import 'package:school_management/linkapi.dart';

class AccountsData {
  Crud crud;
  AccountsData(this.crud);

  // getDataAccounts
  getDataAccounts(
    String selectedCategoryy,
  ) async {
    var response = await crud.getData(
      "${AppLink.getAccounts}?category=$selectedCategoryy",
    );
    print('=============== Account ID: $selectedCategoryy');
    print(
        '=============== AccountsData selectedCategoryy : $response ===========');
    return response.fold((l) => l, (r) => r);
  }
  //

// updateAccount
  updateAccount(int? accountId, String action) async {
    var response = await crud.postAddEditDelete(AppLink.updateAccountStatus, {
      'accountId': accountId.toString(),
      'action': action, // "accept" أو "delete" أو "block"
    });
    print('=============== updateAccount  ID: $accountId =======');
    print('=============== updateAccount  : $response ===========');

    return response.fold((l) => l, (r) => r);
  }
}
