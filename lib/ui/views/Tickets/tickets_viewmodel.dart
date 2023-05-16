import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:retailhub/model/ticket_modal.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';
import '../../../app/app.locator.dart';
import '../../../constants/API.dart';
import '../../../services/api_service.dart';
import '../../../services/navigation_service.dart';
import 'package:share_plus/share_plus.dart';

import '../../enums/enums.dart';

class TicketsViewModel extends BaseViewModel {
  bool _isLoading = false;
  String? email;

  var privacyData;

  List<TicketModal> _tickets = [];

  bool get isLoading => _isLoading;
  List<TicketModal> get tickets => _tickets;

  initModel(BuildContext context) async {
    //SharedPreferences prefs = await SharedPreferences.getInstance();
   // email = prefs.getString(UserDetails.email.toString()) ?? '';
    getTickets();
    notifyListeners();
  }

 

  showProgressBar(value) async {
    _isLoading = value;
    notifyListeners();
  }

  getTickets() async {
    showProgressBar(true);
    await FirebaseFirestore.instance
        .collection('/Tickets').get()
        .then((QuerySnapshot querySnapshot) {
      print(" Tickets");
      print(querySnapshot.docs.first.data());
      querySnapshot.docs.forEach((doc) {
        print(doc.id);
        print(doc.data());
        _tickets.add(TicketModal.fromJson(doc.data() as Map<String, dynamic>) as TicketModal);
      });
    }).onError((error, stackTrace) {
      print("Firebase Error");
      print(error);
    });
    notifyListeners();

  }

}
