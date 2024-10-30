import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

typedef JsonMap = Map<String, dynamic>;

/// Firestoreから取得したドキュメントモデル。
///
/// [exists]がtrueの場合は[data]は必ず存在する。
/// ```dart
/// if (document.exists) {
///   assert(document.data != null);
/// }
/// ```
class Document<T> {
  Document({
    required this.reference,
    required this.exists,
    required this.data,
    required this.metadata,
  });

  String get id => reference.id;

  final DocumentReference<JsonMap> reference;
  final bool exists;
  final T? data;
  final SnapshotMetadata metadata;
}

typedef SnapType = Map<String, dynamic>;

class FirebaseFirestoreHelper {
  FirebaseFirestoreHelper._();

  static FirebaseFirestoreHelper get instance => _instance;
  static final _instance = FirebaseFirestoreHelper._();

  static final _db = FirebaseFirestore.instance;

  CollectionReference<JsonMap> colRef(String path) => _db.collection(path);

  DocumentReference<JsonMap> documentReference({
    required String documentPath,
  }) {
    return _db.doc(documentPath);
  }

  Future<Document<T>> get<T extends Object>({
    required String documentPath,
    required T Function(Map<String, dynamic> json) decode,
    GetOptions? getOptions,
  }) async {
    final snapshot = await _db
        .doc(documentPath)
        .withConverter(
          fromFirestore: (snapshot, options) {
            return decode(snapshot.data()!);
          },
          toFirestore: (_, __) => {},
        )
        .get(getOptions);

    return Document(
      reference: documentReference(documentPath: documentPath),
      exists: snapshot.exists,
      data: snapshot.data(),
      metadata: snapshot.metadata,
    );
  }

  Stream<Document<T>> notifyDocumentUpdates<T extends Object>({
    required String documentPath,
    required T Function(Map<String, dynamic> json) decode,
    bool includeMetadataChanges = false,
  }) {
    return _db
        .doc(documentPath)
        .withConverter(
          fromFirestore: (snapshot, options) {
            return decode(snapshot.data()!);
          },
          toFirestore: (_, __) => {},
        )
        .snapshots(includeMetadataChanges: includeMetadataChanges)
        .asyncMap(
          (snapshot) => Document(
            reference: documentReference(documentPath: documentPath),
            exists: snapshot.exists,
            data: snapshot.data(),
            metadata: snapshot.metadata,
          ),
        );
  }

  Stream<List<Document<T>>> notifyCollectionUpdates<T extends Object>({
    required String collectionPath,
    required T Function(Map<String, dynamic> json) decode,
    Query<T> Function(CollectionReference<T> reference)? queryBuilder,
    bool includeMetadataChanges = false,
  }) {
    final reference = _db.collection(collectionPath).withConverter(
          fromFirestore: (snapshot, options) => decode(snapshot.data()!),
          toFirestore: (_, __) => {},
        );

    final query = queryBuilder?.call(reference) ?? reference;

    return query
        .snapshots(includeMetadataChanges: includeMetadataChanges)
        .asyncMap(
          (querySnapshot) => querySnapshot.docs
              .map(
                (snapshot) => Document(
                  reference: documentReference(
                    documentPath: snapshot.reference.path,
                  ),
                  exists: snapshot.exists,
                  data: snapshot.data(),
                  metadata: snapshot.metadata,
                ),
              )
              .toList(),
        );
  }

  Future<List<Document<T>>> list<T extends Object>({
    required String collectionPath,
    required T Function(Map<String, dynamic> json) decode,
    Query<T> Function(CollectionReference<T> reference)? queryBuilder,
    GetOptions? getOptions,
  }) async {
    final reference = _db.collection(collectionPath).withConverter(
          fromFirestore: (snapshot, options) => decode(snapshot.data()!),
          toFirestore: (_, __) => {},
        );

    final query = queryBuilder?.call(reference) ?? reference;

    final snapshot = await query.get(getOptions);

    return snapshot.docs
        .map(
          (e) => Document(
            reference: documentReference(documentPath: e.reference.path),
            exists: e.exists,
            data: e.data(),
            metadata: e.metadata,
          ),
        )
        .toList();
  }

  PaginationBuilder<T> paginationBuilder<T>({
    required String collectionPath,
    required T Function(Map<String, dynamic> json) decode,
    Query<JsonMap> Function(CollectionReference<JsonMap> reference)?
        queryBuilder,
  }) {
    return PaginationBuilder<T>(
      collectionPath: collectionPath,
      decode: decode,
      queryBuilder: queryBuilder,
    );
  }

  Future<List<Document<T>>> collectionGroup<T extends Object>({
    required String collectionPath,
    required T Function(Map<String, dynamic> json) decode,
    Query<T> Function(Query<T> query)? queryBuilder,
    GetOptions? getOptions,
  }) async {
    final reference = _db.collectionGroup(collectionPath).withConverter(
          fromFirestore: (snapshot, options) => decode(snapshot.data()!),
          toFirestore: (_, __) => {},
        );

    final query = queryBuilder?.call(reference) ?? reference;

    final snapshot = await query.get(getOptions);

    return snapshot.docs
        .map(
          (e) => Document(
            reference: documentReference(documentPath: e.reference.path),
            exists: e.exists,
            data: e.data(),
            metadata: e.metadata,
          ),
        )
        .toList();
  }

  Future<void> set({
    required String documentPath,
    required Map<String, dynamic> data,
    SetOptions? setOptions,
  }) async {
    await _db.doc(documentPath).set(data, setOptions);
  }

  Future<void> update({
    required String documentPath,
    required Map<String, dynamic> data,
  }) async {
    await _db.doc(documentPath).update(data);
  }

  Future<void> add({
    required String collectionPath,
    required Map<String, dynamic> data,
  }) async {
    await _db.collection(collectionPath).add(data);
  }

  Future<void> transaction<T>({
    required Future<T> Function(Transaction transaction) transactionHandler,
    Duration timeout = const Duration(seconds: 30),
    int maxAttempts = 5,
  }) async {
    await _db.runTransaction<T>(
      transactionHandler,
      timeout: timeout,
      maxAttempts: maxAttempts,
    );
  }

  Future<void> batch({
    /// writeBatch.commit();を必ず呼ぶこと
    required FutureOr<void> Function(WriteBatch writeBatch) batchHandler,
  }) async {
    final writeBatch = _db.batch();
    await batchHandler(writeBatch);
  }

  Future<int> count<T extends Object>({
    required String collectionPath,
    required T Function(Map<String, dynamic> json) decode,
    Query<T> Function(CollectionReference<T> reference)? queryBuilder,
  }) async {
    final reference = _db.collection(collectionPath).withConverter(
          fromFirestore: (snapshot, options) => decode(snapshot.data()!),
          toFirestore: (_, __) => {},
        );

    final query = queryBuilder?.call(reference) ?? reference;

    final snapshot = await query.count().get();

    return snapshot.count ?? 0;
  }

  Future<void> delete({
    required String documentPath,
  }) async {
    await _db.doc(documentPath).delete();
  }
}

class PaginationBuilder<T> {
  PaginationBuilder({
    required String collectionPath,
    required T Function(JsonMap json) decode,
    Query<JsonMap> Function(CollectionReference<JsonMap> reference)?
        queryBuilder,
  })  : _collectionPath = collectionPath,
        _decode = decode,
        _queryBuilder = queryBuilder;

  final String _collectionPath;
  final T Function(Map<String, dynamic> json) _decode;
  final Query<JsonMap> Function(CollectionReference<JsonMap> reference)?
      _queryBuilder;

  static final _db = FirebaseFirestore.instance;

  final _helper = FirebaseFirestoreHelper.instance;

  QueryDocumentSnapshot<JsonMap>? _lastDocument;

  Future<List<Document<T>>> get({GetOptions? getOptions}) async {
    final reference = _db.collection(_collectionPath);

    final query = _queryBuilder?.call(reference) ?? reference;

    final snapshot = await query.get(getOptions);

    _lastDocument = snapshot.docs.isEmpty ? null : snapshot.docs.last;

    return snapshot.docs
        .map(
          (e) => Document(
            reference: _helper.documentReference(
              documentPath: e.reference.path,
            ),
            exists: e.exists,
            data: _decode(e.data()),
            metadata: e.metadata,
          ),
        )
        .toList();
  }

  Future<List<Document<T>>> getMore({GetOptions? getOptions}) async {
    if (_lastDocument == null) {
      return get();
    }

    final reference = _db.collection(_collectionPath);

    final query = _queryBuilder?.call(reference) ?? reference;

    final snapshot =
        await query.startAfter([_lastDocument!.data()]).get(getOptions);

    if (snapshot.docs.isNotEmpty) {
      _lastDocument = snapshot.docs.last;
    }

    return snapshot.docs
        .map(
          (e) => Document(
            reference: _helper.documentReference(
              documentPath: e.reference.path,
            ),
            exists: e.exists,
            data: _decode(e.data()),
            metadata: e.metadata,
          ),
        )
        .toList();
  }

  // _lastDocumentよりも前のドキュメントを取得
}
