import 'package:blogapp/core/error/exceptions.dart';
import 'package:blogapp/features/auth/data/models/user_json_model.dart';
import 'package:blogapp/features/auth/data/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:firebase_database/firebase_database.dart';

abstract interface class authRemoteDataSource{




  Future<UserModel> signUpWithEmailPassword({
    required String email,
    required String name,
    required String pass
});

  Future<UserModel> loginWithEmailPassword({
    required String email,
    
    required String pass
  });

  Future<UserModel?> getCurrentUserData();
}
class authRemoteDatasourceimpl implements authRemoteDataSource{
  //final SupabaseClient supabaseClient;
  //final FirebaseAuth firebaseAuth;

  //authRemoteDatasourceimpl(this.supabaseClient);
  //authRemoteDatasourceimpl(this.firebaseAuth);

  @override
  Future<UserModel> loginWithEmailPassword({required String email, required String pass,}) async {
    try{
      //print("testing signup");
      // final response = await supabaseClient.auth.signUp(
      //     password: pass,
      //     email: email,
      //     data: {
      //       'name':name
      //     }
      // );
      //CollectionReference users = FirebaseFirestore.instance.collection('users');


      //final response =
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: pass,

      );
        //   .then((onValue)async{
        // //DatabaseReference ref = FirebaseDatabase.instance.ref("users");
        // //print("testing firebase");
        // // await users.add({
        // //
        // //   "email":email,
        // //   "uid":onValue.user!.uid
        //
        // if(onValue.user!.uid==null){
        //   throw const ServerException("User doesn't exist!");
        // }
        //
        // final info={
        //   "id":onValue.user!.uid,
        //   "email":email,
        //
        // };
        //
        // return UserModel.fromJson(info);
        // });
        // if(onValue.user!.uid==null){
        //   throw const ServerException("No such user");
        // }

      if(FirebaseAuth.instance.currentUser!.uid==null){
        throw const ServerException("User doesn't exist!");
      }

      final info={
        "id":FirebaseAuth.instance.currentUser!.uid,
        "email":email,

      };

      return UserModel.fromJson(info);
      //return response;
      }

      //return UserModel.fromJson(response);
      //print(response.toString() + "testing response");
      // if(response.user!.id==null){
      //   throw const ServerException("No such user");
      // }
    catch(e){
      throw ServerException(e.toString());

    }
  }

  @override
  Future<UserModel> signUpWithEmailPassword({required String email, required String name, required String pass,}) async{
    try{
      //print("testing signup");
      // final response = await supabaseClient.auth.signUp(
      //     password: pass,
      //     email: email,
      //     data: {
      //       'name':name
      //     }
      // );
      CollectionReference users = FirebaseFirestore.instance.collection('users');


      final response =  await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: pass,

          ).then((onValue)async{
        //DatabaseReference ref = FirebaseDatabase.instance.ref("users");
        //print("testing firebase");
        await users.add({
          "uid":onValue.user!.uid,
          "email":email,
          "name": name,

        });



        // if(onValue.user!.uid==null){
        //   throw const ServerException("No such user");
        // }


      });
      final info={
        "id":FirebaseAuth.instance.currentUser!.uid,
        "email":email,
        "name": name
      };
      return UserModel.fromJson(info);

      //return response;


      //return UserModel.fromJson(response);

      //print(response.toString() + "testing response");
      // if(response.user!.id==null){
      //   throw const ServerException("No such user");
      // }

    }catch(e){
      throw ServerException(e.toString());
    }
  }

  @override
  Future<UserModel?> getCurrentUserData() async{
    try{
      if((FirebaseAuth.instance.currentUser!.uid)!=null){
        final userInfo =
        await FirebaseFirestore.instance.collection('users').where("uid",isEqualTo: FirebaseAuth.instance.currentUser!.uid.toString()).get();
        final userInfoRecord= userInfo.docs.map((e)=>UserJsonModel.fromSnapshot(e)).single;
        final userInfoJson = {
          "uid":userInfoRecord.id,
          "email":userInfoRecord.email,
          "name":userInfoRecord.name

        };
        print(userInfoRecord);
        return UserModel.fromJson(userInfoJson);
      }
      // else{
      //   print("test session");
      // }
      return null;
    }
    catch(e){
      throw ServerException(e.toString());
    }
    }
  
}