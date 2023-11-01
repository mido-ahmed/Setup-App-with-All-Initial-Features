import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'mars_photo.g.dart';

@JsonSerializable(createToJson: false)
@HiveType(typeId: 0)
class MarsPhoto {
  @HiveField(0)
  final int? id;
  @HiveField(1)
  final int? sol;
  @HiveField(2)
  final Camera? camera;
  @HiveField(3)
  @JsonKey(name: "img_src")
  final String? imgSrc;
  @HiveField(4)
  @JsonKey(name: "earth_date", fromJson: _fromDate)
  final DateTime? earthDate;

  MarsPhoto({
    required this.id,
    required this.sol,
    required this.camera,
    required this.imgSrc,
    required this.earthDate,
  });

  static DateTime _fromDate(String earthDate) {
    return DateTime.parse(earthDate);
  }

  factory MarsPhoto.fromJson(Map<String, dynamic> json) =>
      _$MarsPhotoFromJson(json);
}

@JsonSerializable(createToJson: false)
@HiveType(typeId: 1)
class Camera {
  @HiveField(0)
  final int? id;
  @HiveField(1)
  final String? name;
  @HiveField(2)
  final String? fullName;

  Camera({
    required this.id,
    required this.name,
    required this.fullName,
  });

  factory Camera.fromJson(Map<String, dynamic> json) => _$CameraFromJson(json);
}
