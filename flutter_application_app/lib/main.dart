import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hospital App',
      theme: ThemeData(
        primarySwatch: Colors.yellow,
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
                  MaterialPageRoute(builder: (context) => NurseInterface()),
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

class NurseInterface extends StatefulWidget {
  @override
  _NurseInterfaceState createState() => _NurseInterfaceState();
}

class _NurseInterfaceState extends State<NurseInterface> {
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

  late List<String> calls;
  late List<String> patientInfo;

  @override
  void initState() {
    super.initState();
    calls = [];
    patientInfo = [];
  }

  String getRandomPatient() {
    Random random = Random();
    int index = random.nextInt(patients.length);
    return patients[index]['name'];
  }

  String _getRandomCondition() {
    Random random = Random();
    List<String> conditions = ['Estable', 'Grave', 'Crítica'];
    int index = random.nextInt(3);
    return conditions[index];
  }

  void handleCall() {
    String callingPatient = getRandomPatient();
    for (var patient in patients) {
      if (patient['name'] == callingPatient) {
        patient['calling'] = true;
        calls.insert(0, patient['name']);
        patientInfo.insert(
            0,
            "Detalles del paciente: " +
                patient['name'] +
                ' - ' +
                patient['condition']);
      }
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Enfermera - Información del Paciente'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ElevatedButton(
              onPressed: handleCall,
              style: ElevatedButton.styleFrom(
                primary: Colors.red,
                onPrimary: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              ),
              child: Text('Atender Llamada', style: TextStyle(fontSize: 20)),
            ),
            SizedBox(height: 20),
            Text(
              'Llamadas Recientes:',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: calls.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      calls[index],
                      style: TextStyle(fontSize: 18),
                    ),
                    subtitle: Text(
                      patientInfo[index],
                      style: TextStyle(fontSize: 16),
                    ),
                  );
                },
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
                      'Condición: ' + patients[index]['condition'],
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
