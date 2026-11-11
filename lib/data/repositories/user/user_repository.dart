import 'package:clean_ease/data/repositories/authentication/authentication_repository.dart';
import 'package:clean_ease/features/personalization/models/user_model.dart';
import 'package:clean_ease/utils/exceptions/firebase_exceptions.dart';
import 'package:clean_ease/utils/exceptions/format_exceptions.dart';
import 'package:clean_ease/utils/exceptions/platform_exceptions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  static const int _maxProfileImageBytes = 5 * 1024 * 1024;
  static const Map<String, String> _profileImageExtensions = {
    'image/jpeg': 'jpg',
    'image/png': 'png',
    'image/webp': 'webp',
  };

  // Save data
  Future<void> saveUserRecord(UserModel user) async {
    try {
      await _db.collection("Users").doc(user.id).set(user.toJson());
    } on FirebaseException catch (e) {
      throw AppFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const AppFormatException();
    } on PlatformException catch (e) {
      throw AppPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  // Fetch detail
  Future<UserModel> fetchUserDetails() async {
    try {
      final documentSnapshot = await _db
          .collection("Users")
          .doc(AuthenticationRepository.instance.authUser?.uid)
          .get();
      if (documentSnapshot.exists) {
        return UserModel.fromSnapshot(documentSnapshot);
      } else {
        return UserModel.empty();
      }
    } on FirebaseException catch (e) {
      throw AppFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const AppFormatException();
    } on PlatformException catch (e) {
      throw AppPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  // update user
  Future<void> updateUserDetails(UserModel updateUser) async {
    try {
      await _db
          .collection("Users")
          .doc(updateUser.id)
          .update(updateUser.toJson());
    } on FirebaseException catch (e) {
      throw AppFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const AppFormatException();
    } on PlatformException catch (e) {
      throw AppPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  // update spesific field
  Future<void> updateSingleField(Map<String, dynamic> json) async {
    try {
      await _db
          .collection("Users")
          .doc(AuthenticationRepository.instance.authUser?.uid)
          .update(json);
    } on FirebaseException catch (e) {
      throw AppFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const AppFormatException();
    } on PlatformException catch (e) {
      throw AppPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  // Remove user data
  Future<void> removeUserRecord(String userId) async {
    try {
      await _db.collection("Users").doc(userId).delete();
    } on FirebaseException catch (e) {
      throw AppFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const AppFormatException();
    } on PlatformException catch (e) {
      throw AppPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  // upload image
  Future<String> uploadImage(String path, XFile image) async {
    try {
      final bytes = await image.readAsBytes();
      if (bytes.isEmpty || bytes.length > _maxProfileImageBytes) {
        throw 'Profile image must be smaller than 5 MB.';
      }

      final contentType = _resolveImageContentType(image);
      final extension = _profileImageExtensions[contentType]!;
      final fileName = '${DateTime.now().microsecondsSinceEpoch}.$extension';
      final ref = FirebaseStorage.instance.ref(path).child(fileName);
      await ref.putData(
        bytes,
        SettableMetadata(contentType: contentType),
      );
      final url = await ref.getDownloadURL();
      return url;
    } on FirebaseException catch (e) {
      throw AppFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const AppFormatException();
    } on PlatformException catch (e) {
      throw AppPlatformException(e.code).message;
    } catch (e) {
      if (e is String) rethrow;
      throw 'Something went wrong. Please try again';
    }
  }

  String _resolveImageContentType(XFile image) {
    final mimeType = image.mimeType;
    if (mimeType != null && _profileImageExtensions.containsKey(mimeType)) {
      return mimeType;
    }

    final name = image.name.toLowerCase();
    if (name.endsWith('.png')) return 'image/png';
    if (name.endsWith('.webp')) return 'image/webp';
    if (name.endsWith('.jpg') || name.endsWith('.jpeg')) return 'image/jpeg';

    throw 'Unsupported image format. Use JPG, PNG, or WebP.';
  }
}
