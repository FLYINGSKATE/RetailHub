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

class TicketsViewModel extends BaseViewModel {
  bool _isLoading = false;
  String? email;

  CollectionReference ticketsCollectionReference = FirebaseFirestore.instance.collection('/Tickets');
  CollectionReference eventsCollectionReference = FirebaseFirestore.instance.collection('/Events');
  CollectionReference usersCollectionReference = FirebaseFirestore.instance.collection('/Users');

  var privacyData;

  List<TicketsModal> _tickets = [];
  List<ParticipantsModal> _participants = [];
  List<EventsModal> _events = [];

  bool get isLoading => _isLoading;
  List<TicketsModal> get tickets => _tickets;
  List<EventsModal> get events => _events;
  List<ParticipantsModal> get participants => _participants;
  SharedPreferences? prefs;
  initModel(BuildContext context) async {
    //SharedPreferences prefs = await SharedPreferences.getInstance();
   // email = prefs.getString(UserDetails.email.toString()) ?? '';
    prefs = await SharedPreferences.getInstance();
    getTickets();
    notifyListeners();
  }

 

  showProgressBar(value) async {
    _isLoading = value;
    notifyListeners();
  }

  getTickets() async {
    showProgressBar(true);

    //Fetch Email Id From Shared Preferences
    String? emailId = prefs?.getString(UserDetails.email.toString());
    print("User Collection Fec "+(emailId??""));

    //Get Reference of the Participants From Email Id
    DocumentReference? participantReference ;
    await usersCollectionReference.where('Email',isEqualTo: emailId).get().then((value) {
      if(value.docs.length==0){
        ///The User email have no tickets
        showProgressBar(false);
        notifyListeners();
        return;
      }
      participantReference = value.docs.first.reference;
    });

    await ticketsCollectionReference.where('ParticipantsDetails', isEqualTo: participantReference).get().then((QuerySnapshot querySnapshot) async {
      print("Tickets");
      print(querySnapshot.docs.first.data());
      print(querySnapshot.docs.length);

      for(int i=0;i<querySnapshot.docs.length;i++){
        print(querySnapshot.docs[i].id);
        print(querySnapshot.docs[i].data());
        _tickets.add(TicketsModal.fromJson(querySnapshot.docs[i].data() as Map<String, dynamic>) as TicketsModal);
        await querySnapshot.docs[i]["EventDetails"].get().then((eventSnapshot) {
          print(eventSnapshot);
          print(eventSnapshot.data());
          _events.add(EventsModal.fromJson(eventSnapshot.data() as Map<String, dynamic>) as EventsModal);
        });
        await querySnapshot.docs[i]["ParticipantsDetails"].get().then((participantSnapshot) {
          print(participantSnapshot);
          print(participantSnapshot.data());
          _participants.add(ParticipantsModal.fromJson(participantSnapshot.data() as Map<String, dynamic>) as ParticipantsModal);
        });

      }
    }).onError((error, stackTrace) {
      print("Firebase Error");
      print(error);
    });
    print("Lengths");
    print(_tickets.length);
    print(_events.length);
    print(_participants.length);
    print("Lengths");
    showProgressBar(false);
    notifyListeners();

  }

}
