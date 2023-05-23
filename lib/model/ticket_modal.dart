// To parse this JSON data, do
//
//     final ticketsModa = ticketsModaFromJson(jsonString);

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'dart:convert';

TicketsModal ticketsModalFromJson(String str) => TicketsModal.fromJson(json.decode(str));

String ticketsModalToJson(TicketsModal data) => json.encode(data.toJson());

class TicketsModal {
  DocumentReference eventDetails;
  DocumentReference participantsDetails;
  String referenceNumber;
  String ticketType;
  Timestamp creationTime;
  Timestamp modificationTime;

  TicketsModal({
    required this.eventDetails,
    required this.participantsDetails,
    required this.referenceNumber,
    required this.ticketType,
    required this.creationTime,
    required this.modificationTime,
  });

  factory TicketsModal.fromJson(Map<String, dynamic> json) => TicketsModal(
    eventDetails: json["EventDetails"],
    participantsDetails: json["ParticipantsDetails"],
    referenceNumber: json["ReferenceNumber"],
    ticketType: json["TicketType"],
    creationTime: json["CreationTime"],
    modificationTime: json["ModificationTime"],
  );

  Map<String, dynamic> toJson() => {
    "EventDetails": eventDetails,
    "ParticipantsDetails": participantsDetails,
    "ReferenceNumber": referenceNumber,
    "TicketType": ticketType,
    "CreationTime": creationTime,
    "ModificationTime": modificationTime,
  };
}
