import 'package:flutter_riverpod/legacy.dart';

class UserProfile {
  final String name;
  final String phone;
  final String email;
  final String gender;
  final String dob;
  final String address1;
  final String address2;
  final String city;
  final String state;
  final String pincode;
  final String aadharNumber;

  UserProfile({
    required this.name,
    required this.phone,
    required this.email,
    required this.gender,
    required this.dob,
    required this.address1,
    required this.address2,
    required this.city,
    required this.state,
    required this.pincode,
    required this.aadharNumber,
  });
}

class UserProfileNotifier extends StateNotifier<UserProfile?> {
  UserProfileNotifier() : super(null);

  void saveProfile(UserProfile profile) {
    state = profile;
  }

  void logout() {
    state = null;
  }
}

final userProfileProvider =
    StateNotifierProvider<UserProfileNotifier, UserProfile?>(
        (ref) => UserProfileNotifier());
