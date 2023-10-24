import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

import '../../handlers/secure_handler.dart';
import '../../res/enum.dart';
import 'base_viewmodel.dart';

class AccountViewModel extends BaseViewModel {
  AccountViewModel() {
    getToken();
  }

  String _token = "";



 

//   bool _showPassword = false;

  setToken(String token) async {
    _token = token;

    StorageHandler.saveUserToken(_token);
    setViewState(ViewState.success);
  }

  getToken() async {
    _token = await StorageHandler.getUserToken() ?? '';
    setViewState(ViewState.success);
  }


   String get token => _token;
}