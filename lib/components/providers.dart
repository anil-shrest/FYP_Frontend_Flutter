import 'package:flutter/material.dart';

class Providers extends ChangeNotifier {
  // To get and set idex value
  int _indexValue;
  int get indexValue => _indexValue;

  // Index
  indexValues(int value) {
    _indexValue = value;
    notifyListeners();
  }

  // To get and set mobile number of the user
  String _mobileNumber;
  String get mobileNumber => _mobileNumber;

  // Mobile
  setMobileNumber(String value) {
    _mobileNumber = value;
    notifyListeners();
  }

  // to get staff status
  bool _staffStatus;
  bool get staffStatus => _staffStatus;

  setStaffStatus(bool value) {
    _staffStatus = value;
    notifyListeners();
  }

  // to get amount to be paid for booking appointment
  int _bookingAmount;
  int get bookingAmount => _bookingAmount;

  setBookingAmount(int value) {
    _bookingAmount = value;
    notifyListeners();
  }

  //  to get staff id for sending fcm notification
  int _staffId;
  int get staffId => _staffId;

  setStaffId(int value) {
    _staffId = value;
    notifyListeners();
  }
}
