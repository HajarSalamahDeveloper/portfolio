import 'package:equatable/equatable.dart';

/// Profile model representing the portfolio owner's information
class ProfileModel extends Equatable {
  final String fullName;
  final String title;
  final String location;
  final String email;
  final String phone;
  final String githubUrl;
  final String profileSummary;

  const ProfileModel({
    required this.fullName,
    required this.title,
    required this.location,
    required this.email,
    required this.phone,
    required this.githubUrl,
    required this.profileSummary,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      fullName: json['fullName'] as String,
      title: json['title'] as String,
      location: json['location'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
      githubUrl: json['githubUrl'] as String,
      profileSummary: json['profileSummary'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'title': title,
      'location': location,
      'email': email,
      'phone': phone,
      'githubUrl': githubUrl,
      'profileSummary': profileSummary,
    };
  }

  @override
  List<Object?> get props => [
    fullName,
    title,
    location,
    email,
    phone,
    githubUrl,
    profileSummary,
  ];
}
