import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hospital App',
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: UserTypeSelection(),
    );
  }
}

class UserTypeSelection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Seleccione el Tipo de Usuario'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.blue,
                onPrimary: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PatientInterface()),
                );
              },
              child: Text('Paciente', style: TextStyle(fontSize: 20)),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.blue,
                onPrimary: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NurseLogin()),
                );
              },
              child: Text('Enfermera', style: TextStyle(fontSize: 20)),
            ),
          ],
        ),
      ),
    );
  }
}

class PatientInterface extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Paciente - Llamar a la enfermera'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Future.delayed(Duration(seconds: 7), () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NurseInterface()),
              );
            });
          },
          style: ElevatedButton.styleFrom(
            primary: Colors.red,
            onPrimary: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
          ),
          child: Text('Llamar a la enfermera', style: TextStyle(fontSize: 20)),
        ),
      ),
    );
  }
}

class NurseLogin extends StatefulWidget {
  @override
  _NurseLoginState createState() => _NurseLoginState();
}

class _NurseLoginState extends State<NurseLogin> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  String _errorMessage = '';

  void _login() {
    if (_usernameController.text == 'enfermera_123' &&
        _passwordController.text == '1234') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => NurseInterface()),
      );
    } else {
      setState(() {
        _errorMessage = 'Credenciales inválidas. Inténtelo de nuevo.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Iniciar Sesión - Enfermera'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                labelText: 'Nombre de Usuario',
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Contraseña',
              ),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _login,
              style: ElevatedButton.styleFrom(
                primary: Colors.red,
                onPrimary: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              ),
              child: Text('Iniciar Sesión', style: TextStyle(fontSize: 20)),
            ),
            SizedBox(height: 10),
            Text(
              _errorMessage,
              style: TextStyle(color: Colors.red),
            ),
          ],
        ),
      ),
    );
  }
}

class NurseInterface extends StatelessWidget {
  final List<Map<String, dynamic>> patients = List.generate(8, (index) {
    List<String> names = [
      'Juan',
      'María',
      'José',
      'Ana',
      'Carlos',
      'Laura',
      'Pedro',
      'Rosa'
    ];
    return {
      'name': names[index],
      'condition': () {
        Random random = Random();
        List<String> conditions = ['Estable', 'Grave', 'Crítica'];
        int index = random.nextInt(3);
        return conditions[index];
      }(),
      'calling': false,
    };
  });

  String _getRandomCondition() {
    Random random = Random();
    List<String> conditions = ['Estable', 'Grave', 'Crítica'];
    int index = random.nextInt(3);
    return conditions[index];
  }

  List<String> _getRandomCalls() {
    List<String> randomCalls = [];
    Random random = Random();
    for (int i = 0; i < 3; i++) {
      int index = random.nextInt(patients.length);
      randomCalls.add(patients[index]['name']);
    }
    return randomCalls;
  }

  @override
  Widget build(BuildContext context) {
    List<String> calls = _getRandomCalls();

    return Scaffold(
      appBar: AppBar(
        title: Text('Enfermera - Información del Paciente'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Llamadas Recientes:',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            for (var call in calls)
              Padding(
                padding: EdgeInsets.symmetric(vertical: 5),
                child: Text(
                  call,
                  style: TextStyle(fontSize: 18),
                ),
              ),
            SizedBox(height: 20),
            Text(
              'Lista de Pacientes:',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: patients.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      'Paciente ${index + 1}: ${patients[index]['name']}' +
                          (patients[index]['calling'] ? ' - Llamando' : ''),
                      style: TextStyle(fontSize: 18),
                    ),
                    subtitle: Text(
                      'Condición: ${patients[index]['condition']}',
                      style: TextStyle(fontSize: 16),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
