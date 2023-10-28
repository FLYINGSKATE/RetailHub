// To parse this JSON data, do
//
//     final eventsModal = eventsModalFromJson(jsonString);

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'dart:convert';

EventsModal eventsModalFromJson(String str) => EventsModal.fromJson(json.decode(str));

String eventsModalToJson(EventsModal data) => json.encode(data.toJson());

class EventsModal {
  String name;
  String datedOn;
  String image;
  String description;
  String location;
  String numberOfAllowedPeople;
  Timestamp creationTime;
  Timestamp modificationTime;

  EventsModal({
    required this.name,
    required this.datedOn,
    required this.image,
    required this.description,
    required this.location,
    required this.numberOfAllowedPeople,
    required this.creationTime,
    required this.modificationTime,
  });

  factory EventsModal.fromJson(Map<String, dynamic> json) => EventsModal(
    name: json["Name"],
    datedOn: json["DatedOn"],
    image: json["Image"],
    description: json["Description"],
    location: json["Location"],
    numberOfAllowedPeople: json["NumberOfAllowedPeople"],
    creationTime: json["CreationTime"],
    modificationTime: json["ModificationTime"],
  );

  Map<String, dynamic> toJson() => {
    "Name": name,
    "DatedOn": datedOn,
    "Image": image,
    "Description": description,
    "Location": location,
    "NumberOfAllowedPeople": numberOfAllowedPeople,
    "CreationTime": creationTime,
    "ModificationTime": modificationTime,
  };
}
