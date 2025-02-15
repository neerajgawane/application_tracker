import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/application.dart';

class EditApplicationScreen extends StatefulWidget {
  final Application application;
  final String documentId;

  EditApplicationScreen({
    required this.application,
    required this.documentId,
  });

  @override
  _EditApplicationScreenState createState() => _EditApplicationScreenState();
}

class _EditApplicationScreenState extends State<EditApplicationScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _universityController;
  late TextEditingController _programController;
  late String _status;
  bool _isLoading = false;

  final List<String> _statusOptions = [
    'Pending',
    'Under Review',
    'Documents Required',
    'Interview Scheduled',
    'Accepted',
    'Rejected'
  ];

  @override
  void initState() {
    super.initState();
    _universityController = TextEditingController(text: widget.application.university);
    _programController = TextEditingController(text: widget.application.program);
    _status = widget.application.status;
  }

  @override
  void dispose() {
    _universityController.dispose();
    _programController.dispose();
    super.dispose();
  }

  Future<void> _updateApplication() async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() => _isLoading = true);
      
      try {
        await FirebaseFirestore.instance
            .collection('applications')
            .doc(widget.documentId)
            .update({
          'university': _universityController.text,
          'program': _programController.text,
          'status': _status,
          'progress': _getProgressForStatus(_status),
        });

        Navigator.pop(context, true);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error updating application: $e')),
        );
      } finally {
        if (mounted) setState(() => _isLoading = false);
      }
    }
  }

  double _getProgressForStatus(String status) {
    switch (status) {
      case 'Pending': return 0.2;
      case 'Under Review': return 0.4;
      case 'Documents Required': return 0.6;
      case 'Interview Scheduled': return 0.8;
      case 'Accepted': return 1.0;
      case 'Rejected': return 1.0;
      default: return 0.0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Application'),
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () async {
              final confirm = await showDialog<bool>(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('Delete Application'),
                  content: Text('Are you sure you want to delete this application?'),
                  actions: [
                    TextButton(
                      child: Text('Cancel'),
                      onPressed: () => Navigator.pop(context, false),
                    ),
                    TextButton(
                      child: Text('Delete'),
                      onPressed: () => Navigator.pop(context, true),
                    ),
                  ],
                ),
              );

              if (confirm == true) {
                await FirebaseFirestore.instance
                    .collection('applications')
                    .doc(widget.documentId)
                    .delete();
                Navigator.pop(context, true);
              }
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _universityController,
                decoration: InputDecoration(
                  labelText: 'University Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Please enter university name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _programController,
                decoration: InputDecoration(
                  labelText: 'Program Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Please enter program name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _status,
                decoration: InputDecoration(
                  labelText: 'Application Status',
                  border: OutlineInputBorder(),
                ),
                items: _statusOptions.map((String status) {
                  return DropdownMenuItem(
                    value: status,
                    child: Text(status),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    setState(() => _status = newValue);
                  }
                },
              ),
              SizedBox(height: 24),
              ElevatedButton(
                onPressed: _isLoading ? null : _updateApplication,
                child: _isLoading
                    ? CircularProgressIndicator(color: Colors.white)
                    : Text('Update Application'),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}