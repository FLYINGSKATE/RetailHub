import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:retailhub/model/events_modal.dart';
import 'package:retailhub/model/participants_modal.dart';
import 'package:retailhub/model/ticket_modal.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';
import '../../../app/app.locator.dart';
import '../../../constants/API.dart';
import '../../../services/api_service.dart';
import '../../../services/navigation_service.dart';
import 'package:share_plus/share_plus.dart';

import '../../enums/enums.dart';

class SingleTicketsViewModel extends BaseViewModel {
  bool _isLoading = false;
  String? email;

  CollectionReference ticketsCollectionReference = FirebaseFirestore.instance.collection('/Tickets');
  CollectionReference eventsCollectionReference = FirebaseFirestore.instance.collection('/Events');
  CollectionReference usersCollectionReference = FirebaseFirestore.instance.collection('/Users');

  var privacyData;

  TicketsModal? _ticket;
  ParticipantsModal? _participant;
  EventsModal? _event;

  bool get isLoading => _isLoading;
  TicketsModal? get ticket => _ticket;
  EventsModal? get event => _event;
  ParticipantsModal? get participant => _participant;

  initModel(BuildContext context,String emailId,String referenceNumber) async {
    //SharedPreferences prefs = await SharedPreferences.getInstance();
    // email = prefs.getString(UserDetails.email.toString()) ?? '';
    getSingleTicket(emailId,referenceNumber);
    notifyListeners();
  }



  showProgressBar(value) async {
    _isLoading = value;
    notifyListeners();
  }

  getSingleTicket(String emailId,String referenceNumber) async {
    showProgressBar(true);
    await ticketsCollectionReference.where('ReferenceNumber', isEqualTo: referenceNumber).get().then((QuerySnapshot querySnapshot) async {
      print("Tickets");
      print(querySnapshot.docs.first.data());
      print(querySnapshot.docs.length);

      for(int i=0;i<querySnapshot.docs.length;i++){
        print(querySnapshot.docs[i].id);
        print(querySnapshot.docs[i].data());
        _ticket = TicketsModal.fromJson(querySnapshot.docs[i].data() as Map<String, dynamic>) as TicketsModal;
        await querySnapshot.docs[i]["EventDetails"].get().then((eventSnapshot) {
          print(eventSnapshot);
          print(eventSnapshot.data());
          _event = EventsModal.fromJson(eventSnapshot.data() as Map<String, dynamic>) as EventsModal;
        });
        await querySnapshot.docs[i]["ParticipantsDetails"].get().then((participantSnapshot) {
          print(participantSnapshot);
          print(participantSnapshot.data());
          _participant = ParticipantsModal.fromJson(participantSnapshot.data() as Map<String, dynamic>) as ParticipantsModal;
        });

      }
    }).onError((error, stackTrace) {
      print("Firebase Error");
      print(error);
    });
    print("Lengths");
    print(_ticket);
    print(_event);
    print(_participant);
    print("Lengths");
    showProgressBar(false);
    notifyListeners();

  }

}
