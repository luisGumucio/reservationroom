import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:reservationroom/models/profile.dart';

class ProfileService {
  final CollectionReference profiles =
      FirebaseFirestore.instance.collection('profiles');

  Future<void> saveProfile(Profile profile) async {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['name'] = profile.name;
    data['phone'] = profile.phone;
    data['email'] = profile.email;
    data['idUser'] = profile.idUser;
    await profiles.add(data);
  }

  Future<Profile> getProfile(String uid) async {
    Profile data = Profile();
    final ref = FirebaseStorage.instance
        .ref()
        .child('profile/$uid');
    var url = await ref.getDownloadURL();

    return await profiles
        .where("idUser", isEqualTo: uid)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) async {
        data.name = doc['name'];
        data.socialInformation = doc['socialInformation'];

        data.imageUrl = url;
      });
      return data;
    });
  }
  updateProfile(String uid) async {
   await profiles.where('idUser', isEqualTo: uid).get()
   .then((QuerySnapshot query) {
           query.docs.forEach((doc) async {
             var cuartos = doc['socialInformation.cuartos'].toString();
              var total = int.parse(cuartos) + 1;
              profiles.doc(doc.id).update({'socialInformation.cuartos': total});
      });
     
   });
  }
}
