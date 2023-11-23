// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PostsModelAdapter extends TypeAdapter<PostsModel> {
  @override
  final int typeId = 0;

  @override
  PostsModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PostsModel(
      businessName: fields[0] as String?,
      city: fields[1] as String?,
      country: fields[2] as String?,
      provinceId: fields[3] as String?,
      images: (fields[4] as List?)?.cast<String>(),
      industry: (fields[5] as List?)?.cast<String>(),
      description: fields[6] as String?,
      ofListingId: fields[7] as String?,
      price: fields[8] as int?,
      sellerEmail: fields[9] as String?,
      sellerName: fields[10] as String?,
      source: fields[11] as String?,
      updatedAt: fields[12] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, PostsModel obj) {
    writer
      ..writeByte(13)
      ..writeByte(0)
      ..write(obj.businessName)
      ..writeByte(1)
      ..write(obj.city)
      ..writeByte(2)
      ..write(obj.country)
      ..writeByte(3)
      ..write(obj.provinceId)
      ..writeByte(4)
      ..write(obj.images)
      ..writeByte(5)
      ..write(obj.industry)
      ..writeByte(6)
      ..write(obj.description)
      ..writeByte(7)
      ..write(obj.ofListingId)
      ..writeByte(8)
      ..write(obj.price)
      ..writeByte(9)
      ..write(obj.sellerEmail)
      ..writeByte(10)
      ..write(obj.sellerName)
      ..writeByte(11)
      ..write(obj.source)
      ..writeByte(12)
      ..write(obj.updatedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PostsModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
