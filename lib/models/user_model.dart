// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:equatable/equatable.dart';

// class User extends Equatable {
//   final String uid;
//   final String phoneNumber;
//   final String? name;
//   final String? email;
//   final String? city;

//   const User({
//     required this.uid,
//     required this.phoneNumber,
//     this.name,
//     this.email,
//     this.city,
//   });

//   @override
//   List<Object?> get props => [
//         uid,
//         phoneNumber,
//         name,
//         email,
//         city,
//       ];

//   static User fromSnapshot(DocumentSnapshot snap) {
//     User user = User(
//       uid: snap.id,
//       name: snap['name'],
//       phoneNumber: snap['phoneNumber'],
//       email: snap['email'],
//       city: snap['city'],
//     );
//     return user;
//   }

//   Map<String, dynamic> toMap() {
//     return {
//       'uid': uid,
//       'name': name,
//       'phoneNumber': phoneNumber,
//       'email': email,
//       'city': city,
//     };
//   }

//   User copyWith({
//     String? uid,
//     String? name,
//     String? phoneNumber,
//     String? email,
//     String? city,
//   }) {
//     return User(
//       uid: uid ?? this.uid,
//       name: name ?? this.name,
//       phoneNumber: phoneNumber ?? this.phoneNumber,
//       email: email ?? this.email,
//       city: city ?? this.city,
//     );
//   }
// }
