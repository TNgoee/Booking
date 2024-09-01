// category_model.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Size {
  final CollectionReference _sizeCollection =
      FirebaseFirestore.instance.collection('Size');

  // Method to update a category
  Future<void> updateSize(String id, String newName) async {
    try {
      await _sizeCollection.doc(id).update({
        'size': newName,
      });
      print('Size updated successfully');
    } catch (e) {
      print('Error updating size: $e');
    }
  }

  // Method to show a confirmation dialog before deleting
  Future<void> showDeleteConfirmationDialog(
      BuildContext context, String id) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Deletion'),
          content: const Text('Are you sure you want to delete this size?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
            TextButton(
              child: const Text('Delete'),
              onPressed: () {
                deleteSize(id); // Call the delete method
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
          ],
        );
      },
    );
  }

  // Method to delete a category
  Future<void> deleteSize(String id) async {
    try {
      await _sizeCollection.doc(id).delete();
      print('Size deleted successfully');
    } catch (e) {
      print('Error deleting size: $e');
    }
  }
}
