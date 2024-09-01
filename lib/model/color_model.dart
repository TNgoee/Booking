// category_model.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Colormodel {
  final CollectionReference _colorCollection =
      FirebaseFirestore.instance.collection('Color');

  // Method to update a category
  Future<void> updateColor(String id, String newName) async {
    try {
      await _colorCollection.doc(id).update({
        'name': newName,
      });
      print('Category updated successfully');
    } catch (e) {
      print('Error updating category: $e');
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
          content: const Text('Are you sure you want to delete this category?'),
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
                deleteColor(id); // Call the delete method
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
          ],
        );
      },
    );
  }

  // Method to delete a category
  Future<void> deleteColor(String id) async {
    try {
      await _colorCollection.doc(id).delete();
      print('Category deleted successfully');
    } catch (e) {
      print('Error deleting category: $e');
    }
  }
}
