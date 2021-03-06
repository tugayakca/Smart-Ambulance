import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smart_ambulance/model/ambulanceInfo.dart';
import 'package:smart_ambulance/model/patientInfo.dart';
import 'package:smart_ambulance/model/users.dart';
import 'package:smart_ambulance/services/FirebaseApi.dart';
import 'package:smart_ambulance/model/hospitalsInfo.dart';

class CRUDState {
  FirebaseApi _firebaseApi = new FirebaseApi('users');
  FirebaseApi _firebaseApi2 = new FirebaseApi('hospitalsInfo');
  FirebaseApi _firebaseApi3 = new FirebaseApi('ambulanceInfo');
  FirebaseApi _firebaseApi4 = new FirebaseApi('patientInfo');

  List<AmbulanceInfo> ambulances;
  List<User> users;
  List<HospitalsInfo> hospitals;
  List<Patient> patientList;

  Future<List<User>> fetchUsers() async {
    var result = await _firebaseApi.getDataCollection();
    users = result.documents
        .map((doc) => User.fromMap(doc.data, doc.documentID))
        .toList();
    return users;
  }

  Future<List<HospitalsInfo>> fetchHospitals() async {
    var result = await _firebaseApi2.getDataCollection();
    hospitals =
        result.documents.map((doc) => HospitalsInfo.fromMap(doc.data)).toList();
    return hospitals;
  }

    Future fetchEmergency() async {
    var result = await _firebaseApi4.getDataCollection();
    patientList =
        result.documents.map((doc) => Patient.fromMap(doc.data)).toList();
    return patientList;
  }

  Stream<QuerySnapshot> fetchProductsAsStream() {
    return _firebaseApi.streamDataCollection();
  }

  Future<User> getProductById(String id) async {
    var doc = await _firebaseApi.getDocumentById(id);
    return User.fromMap(doc.data, doc.documentID);
  }

  Future removeProduct(String id) async {
    await _firebaseApi.removeDocument(id);
    return;
  }

  Future updateProduct(User data, String id) async {
    await _firebaseApi.updateDocument(data.toMap(), id);
    return;
  }

  Future addProduct(User data, String uid) async {
    var result = await _firebaseApi.addDocument(data.toMap(), uid);
    return result;
  }

  Future addHospital(HospitalsInfo data, String id) async {
    var result = await _firebaseApi2.addDocument2(data.toMap(), id);
    return result;
  }

  Future addAmbulance(AmbulanceInfo data, String id) async {
    var result = await _firebaseApi3.addDocument2(data.toMap(), id);
    return result;
  }

  Future<QuerySnapshot> showUsersOnline() {
    var result = Firestore.instance.collection('users').getDocuments();
    return result;
  }


}
