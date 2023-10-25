import 'dart:io';

import 'package:chat/core/utils/failure.dart';
import 'package:chat/core/utils/type_defs.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fpdart/fpdart.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:path/path.dart' as p;

final storageServiceProvider = Provider((ref) => StorageService(FirebaseStorage.instance));

class StorageService {
  final FirebaseStorage _firebaseStorage;

  StorageService(this._firebaseStorage);

  FutureEither<String> storeFile({
    required String path,
    required String id,
    required File? file,
  }) async {
    try {
      final fileExtension = p.extension(file!.path);
      final ref = _firebaseStorage.ref().child(path).child("$id$fileExtension");
      final uploadTaskSnap = await ref.putFile(file);
      return right(await uploadTaskSnap.ref.getDownloadURL());
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
