import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Sign Up Form",
      home: Scaffold(
        appBar: AppBar(title: const Text('Sign Up')),
        body: const MyCustomForm(),
      ),
    );
  }
}

// Create a Form widget using flutter_form_builder
class MyCustomForm extends StatefulWidget {
  const MyCustomForm({super.key});

  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

class MyCustomFormState extends State<MyCustomForm> {
  // Use a GlobalKey to uniquely identify the FormBuilder and access its state
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: FormBuilder(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Name field
              FormBuilderTextField(
                name: 'name',
                decoration: const InputDecoration(labelText: 'Full Name'),
                validator: FormBuilderValidators.required(
                  errorText: 'Name is required',
                ),
              ),
              const SizedBox(height: 16),

              // Email field with format validation
              FormBuilderTextField(
                name: 'email',
                decoration: const InputDecoration(labelText: 'Email'),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(
                    errorText: 'Email is required',
                  ),
                  FormBuilderValidators.email(
                    errorText: 'Please enter a valid email',
                  ),
                ]),
              ),
              const SizedBox(height: 16),

              // Date of Birth field
              FormBuilderDateTimePicker(
                name: 'dob',
                inputType: InputType.date,
                decoration: const InputDecoration(labelText: 'Date of Birth'),
                validator: FormBuilderValidators.required(
                  errorText: 'Date of Birth is required',
                ),
              ),
              const SizedBox(height: 16),

              // Password field with complexity validation
              FormBuilderTextField(
                name: 'password',
                obscureText: true,
                decoration: const InputDecoration(labelText: 'Password'),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(
                    errorText: 'Password is required',
                  ),
                  FormBuilderValidators.minLength(
                    6,
                    errorText: 'Password must be at least 6 characters long',
                  ),
                  FormBuilderValidators.match(
                    RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{6,}$'),
                    errorText: 'Password must contain letters and numbers',
                  ),
                ]),
              ),
              const SizedBox(height: 24),

              // Submit Button
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.saveAndValidate() ?? false) {
                    // Show success message or navigate
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Signup successful!'),
                        backgroundColor: Colors.green,
                      ),
                    );
                  } else {
                    // Show error if validation fails
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Please fix the errors above'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Confirmation Page Widget
class ConfirmationPage extends StatelessWidget {
  const ConfirmationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Welcome')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Signup Successful!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Return to previous screen
              },
              child: const Text('Go Back'),
            ),
          ],
        ),
      ),
    );
  }
}
