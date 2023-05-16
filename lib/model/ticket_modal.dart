// To parse this JSON data, do
//
//     final ticketModal = ticketModalFromJson(jsonString);

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

TicketModal ticketModalFromJson(String str) => TicketModal.fromJson(json.decode(str));

String ticketModalToJson(TicketModal data) => json.encode(data.toJson());

class TicketModal {
  String? email;
  String? mobile;
  String? qrCode;
  String? reference;
  DocumentReference? ticketForEvent;
  String? details;
  String? eventImage;
  String? ticketType;
  String? eventName;
  String? ticketHolderName;

  TicketModal({
    this.email,
    this.mobile,
    this.qrCode,
    this.reference,
    this.ticketForEvent,
    this.details,
    this.eventImage,
    this.ticketType,
    this.eventName,
    this.ticketHolderName,
  });

  factory TicketModal.fromJson(Map<String, dynamic> json) => TicketModal(
    email: json["Email"],
    mobile: json["Mobile"],
    qrCode: json["QrCode"],
    reference: json["Reference"],
    ticketForEvent: json["TicketForEvent"],
    details: json["Details"],
    eventImage: json["EventImage"],
    ticketType: json["TicketType"],
    eventName: json["EventName"],
    ticketHolderName: json["TicketHolderName"],
  );

  Map<String, dynamic> toJson() => {
    "Email": email,
    "Mobile": mobile,
    "QrCode": qrCode,
    "Reference": reference,
    "TicketForEvent": ticketForEvent,
    "Details": details,
    "EventImage": eventImage,
    "TicketType": ticketType,
    "EventName": eventName,
    "TicketHolderName": ticketHolderName,
  };
}
