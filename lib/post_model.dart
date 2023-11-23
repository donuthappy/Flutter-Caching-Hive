// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'post_model.g.dart';

@HiveType(typeId: 0)
class PostsModel {
  @HiveField(0)
  final String? businessName;
  @HiveField(1)
  final String? city;
  @HiveField(2)
  final String? country;
  @HiveField(3)
  final String? provinceId;
  @HiveField(4)
  final List<String>? images;
  @HiveField(5)
  final List<String>? industry;
  @HiveField(6)
  final String? description;
  @HiveField(7)
  final String? ofListingId;
  @HiveField(8)
  final int? price;
  @HiveField(9)
  final String? sellerEmail;
  @HiveField(10)
  final String? sellerName;
  @HiveField(11)
  final String? source;
  @HiveField(12)
  final DateTime? updatedAt;

  PostsModel({
    this.businessName,
    this.city,
    this.country,
    this.provinceId,
    this.images,
    this.industry,
    this.description,
    this.ofListingId,
    this.price,
    this.sellerEmail,
    this.sellerName,
    this.source,
    this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'business_name': businessName,
      'city': city,
      'country': country,
      'province_id': provinceId,
      'images': images,
      'industry': industry,
      'l_description': description,
      'of_listing_id': ofListingId,
      'price': price,
      'seller_email': sellerEmail,
      'seller_name': sellerName,
      'source': source,
      'updatedAt': updatedAt,
    };
  }

  factory PostsModel.fromMap(Map<String, dynamic> map) {
    return PostsModel(
      businessName: map['business_name'],
      city: map['city'],
      country: map['country'],
      provinceId: map['province_id'],
      images: List<String>.from(map['images'].map((x) => x)),
      industry: List<String>.from(map["industry"].map((x) => x)),
      description: map['l_description'],
      ofListingId: map['of_listing_id'],
      price: map['price'],
      sellerEmail: map['seller_email'],
      sellerName: map['seller_name'],
      source: map['source'],
      updatedAt: map["updatedAt"] is Timestamp
          ? DateTime.fromMillisecondsSinceEpoch(
              (map["updatedAt"] as Timestamp).seconds * 1000)
          : DateTime.fromMillisecondsSinceEpoch(
              map["updatedAt"]['_seconds'] * 1000),
    );
  }

  String toJson() => json.encode(toMap());

  factory PostsModel.fromJson(String source) =>
      PostsModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
