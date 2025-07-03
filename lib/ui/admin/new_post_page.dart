import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class MovieArticleUploadPage extends StatefulWidget {
  const MovieArticleUploadPage({super.key});

  @override
  State<MovieArticleUploadPage> createState() => _MovieArticleUploadPageState();
}

class _MovieArticleUploadPageState extends State<MovieArticleUploadPage> {
  File? _image1;
  File? _image2;
  final TextEditingController _article1Controller = TextEditingController();
  final TextEditingController _article2Controller = TextEditingController();

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage(int index) async {
    final picked = await _picker.pickImage(source: ImageSource.gallery);

    if (picked != null) {
      setState(() {
        if (index == 1) {
          _image1 = File(picked.path);
        } else {
          _image2 = File(picked.path);
        }
      });
    }
  }

  void _submit() {
    final article1 = _article1Controller.text.trim();
    final article2 = _article2Controller.text.trim();

    if (_image1 == null || _image2 == null || article1.isEmpty || article2.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please complete all fields.")),
      );
      return;
    }

    // Submit logic goes here (API, DB, etc.)
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Article Submitted Successfully!")),
    );
  }

  Widget _buildImageBox({required int index, File? image}) {
    return GestureDetector(
      onTap: () => _pickImage(index),
      child: Container(
        width: double.infinity,
        height: 180,
        margin: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade400),
          borderRadius: BorderRadius.circular(12),
          color: Colors.grey.shade100,
        ),
        child: image == null
            ? const Center(
                child: Icon(Icons.image, size: 50, color: Colors.grey),
              )
            : ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.file(image, fit: BoxFit.cover, width: double.infinity),
              ),
      ),
    );
  }

  Widget _buildTextArea(TextEditingController controller) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        controller: controller,
        maxLines: 5,
        decoration: const InputDecoration(
          hintText: 'Enter article content...',
          border: InputBorder.none,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload Movie Article'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildImageBox(index: 1, image: _image1),
            _buildTextArea(_article1Controller),
            _buildImageBox(index: 2, image: _image2),
            _buildTextArea(_article2Controller),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submit,
              style: ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(50)),
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
