// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

/// A proxy of the catalog of items the user can buy.
///
/// In a real app, this might be backed by a backend and cached on device.
/// In this sample app, the catalog is procedurally generated and infinite.
///
/// For simplicity, the catalog is expected to be immutable (no products are
/// expected to be added, removed or changed during the execution of the app).
class CatalogModel {
  List<String> notes = [
  ];

  /// Get item by [id].
  ///
  /// In this sample, the catalog is infinite, looping over [notes].
  Note getById(int id) => Note(id, notes[id % notes.length]);

  /// Get item by its position in the catalog.
  Note getByPosition(int position) {
    // In this simplified case, an item's position in the catalog
    // is also its id.
    return getById(position);
  }
}

@immutable
class Note {
  final int id;
  final String text;

  Note(this.id, this.text);

  @override
  int get hashCode => id;

  @override
  bool operator ==(Object other) => other is Note && other.id == id;
}
