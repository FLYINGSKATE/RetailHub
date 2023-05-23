// To parse this JSON data, do
//
//     final participantsModal = participantsModalFromJson(jsonString);

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'dart:convert';

ParticipantsModal participantsModalFromJson(String str) => ParticipantsModal.fromJson(json.decode(str));

String participantsModalToJson(ParticipantsModal data) => json.encode(data.toJson());

class ParticipantsModal {
  String name;
  String email;
  String phoneNumber;
  Timestamp creationTime;
  Timestamp modificationTime;

  ParticipantsModal({
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.creationTime,
    required this.modificationTime,
  });

  factory ParticipantsModal.fromJson(Map<String, dynamic> json) => ParticipantsModal(
    name: json["Name"],
    email: json["Email"],
    phoneNumber: json["PhoneNumber"],
    creationTime: json["CreationTime"],
    modificationTime: json["ModificationTime"],
  );

  Map<String, dynamic> toJson() => {
    "Name": name,
    "Email": email,
    "PhoneNumber": phoneNumber,
    "CreationTime": creationTime,
    "ModificationTime": modificationTime,
  };
}
