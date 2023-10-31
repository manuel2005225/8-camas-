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
        primarySwatch: Colors.indigo,
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
                primary: const Color.fromRGBO(0, 219, 143, 86),
                onPrimary: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PatientLogin('1A')),
                );
              },
              child: Text('Paciente', style: TextStyle(fontSize: 20)),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: const Color.fromRGBO(0, 219, 143, 86),
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

class PatientLogin extends StatefulWidget {
  final String patientId;

  PatientLogin(this.patientId);

  @override
  _PatientLoginState createState() => _PatientLoginState();
}

class _PatientLoginState extends State<PatientLogin> {
  TextEditingController _passwordController = TextEditingController();
  String _errorMessage = '';

  void _login() {
    String expectedPassword = 'paciente_${widget.patientId}';
    if (_passwordController.text == expectedPassword) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => PatientInterface(widget.patientId)),
      );
    } else {
      setState(() {
        _errorMessage = 'Contraseña incorrecta. Inténtelo de nuevo.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Iniciar Sesión - Paciente ${widget.patientId}'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
                primary: Colors.blue,
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

class PatientInterface extends StatelessWidget {
  final String patientId;

  PatientInterface(this.patientId);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Paciente $patientId - Llamar a la enfermera'),
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

class NurseInterface extends StatefulWidget {
  @override
  _NurseInterfaceState createState() => _NurseInterfaceState();
}

class _NurseInterfaceState extends State<NurseInterface> {
  final List<Map<String, dynamic>> patients = List.generate(8, (index) {
    List<String> names = [
      'Juan',
      'Maria',
      'Carlos',
      'Laura',
      'Pedro',
      'Ana',
      'Sofia',
      'Diego'
    ];
    return {
      'name': names[index],
      'condition': () {
        List<String> conditions = ['Estable', 'Grave', 'Crítico'];
        return conditions[Random().nextInt(conditions.length)];
      }(),
      'calling': index == 0,
    };
  });

  List<String> calls = [];

  String _getRandomCondition() {
    List<String> conditions = ['Estable', 'Grave', 'Crítico'];
    return conditions[Random().nextInt(conditions.length)];
  }

  List<String> _getRandomCalls() {
    List<String> randomCalls = [];
    randomCalls
        .add(patients[0]['name']); // El primer paciente siempre está llamando
    Random random = Random();
    int numAdditionalCalls = random.nextInt(6) +
        1; // Número aleatorio de llamadas adicionales entre 1 y 6
    Set<int> indices = Set();
    while (indices.length < numAdditionalCalls) {
      int index = random.nextInt(patients.length);
      if (index != 0 && !indices.contains(index)) {
        indices.add(index);
        patients[index]['calling'] = true; // Marcar al paciente como "llamando"
        randomCalls.add(patients[index]
            ['name']); // Agregar a la lista de llamadas pendientes
      }
    }
    return randomCalls;
  }

  @override
  Widget build(BuildContext context) {
    calls = _getRandomCalls();

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
