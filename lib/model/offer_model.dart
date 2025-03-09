import 'package:flutter/material.dart';

class OfferModel {
  final int id;
  final String title;
  final String description;
  final String discount;
  final String code;
  final String validUntil;
  final String image;
  final Color backgroundColor;

  OfferModel({
    required this.id,
    required this.title,
    required this.description,
    required this.discount,
    required this.code,
    required this.validUntil,
    required this.image,
    required this.backgroundColor,
  });
}
