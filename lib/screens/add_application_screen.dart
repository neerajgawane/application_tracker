import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import '../services/auth_service.dart';
import '../models/application.dart';

class AddApplicationScreen extends StatefulWidget {
  @override
  _AddApplicationScreenState createState() => _AddApplicationScreenState();
}

class _AddApplicationScreenState extends State<AddApplicationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _universityController = TextEditingController();
  final _programController = TextEditingController();
  String _status = 'Pending';
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
  void dispose() {
    _universityController.dispose();
    _programController.dispose();
    super.dispose();
  }

  Future<void> _submitApplication() async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() => _isLoading = true);
      
      try {
        final user = context.read<AuthService>().user;
        if (user == null) throw Exception('User not logged in');

        final application = {
          'userId': user.uid,
          'university': _universityController.text,
          'program': _programController.text,
          'status': _status,
          'progress': _getProgressForStatus(_status),
          'submissionDate': DateTime.now().toIso8601String(),
        };

        await FirebaseFirestore.instance
            .collection('applications')
            .add(application);

        Navigator.pop(context, true);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error adding application: $e')),
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
        title: Text('Add New Application'),
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
                onPressed: _isLoading ? null : _submitApplication,
                child: _isLoading
                    ? CircularProgressIndicator(color: Colors.white)
                    : Text('Submit Application'),
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