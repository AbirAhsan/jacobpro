import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class SharedDataManageService {
  final sharedBox = GetStorage();

//<======================================== Token Functionality
  Future<void> setToken(String token) async {
    sharedBox.write('token', token);
  }

  Future<String?> getToken() async {
    String? token = sharedBox.read('token') ?? "";

    return token;
  }

//<======================================== User ID Functionality
  Future<void> setUserID(String userID) async {
    sharedBox.write('userID', userID);
  }

  Future<String?> getUserID() async {
    String? userID = sharedBox.read('userID') ?? "";

    return userID;
  }

//<======================================== User Verification Status Functionality
  Future<void> setUserVerification(String verificationStatus) async {
    sharedBox.write('verificationStatus', verificationStatus);
  }

  Future<String?> getUserVerification() async {
    String? verificationStatus = sharedBox.read('verificationStatus') ?? "";

    return verificationStatus;
  }

  //<======================================== Menu Token Functionality
  Future<void> setMenuToken(String menuToken) async {
    sharedBox.write('menuToken', menuToken);
  }

  Future<String?> getMenuToken() async {
    String? menuToken = sharedBox.read('menuToken') ?? "";

    return menuToken;
  }

  Future<void> clearTokenUserID() async {
    sharedBox.remove('token');
    sharedBox.remove('userID');
    sharedBox.remove('verificationStatus');

    debugPrint("Token and UserID removed");
  }
}
