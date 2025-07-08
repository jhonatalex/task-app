import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:http/http.dart' as http;

class Dashboardscreen extends StatefulWidget {
  const Dashboardscreen({super.key});

  @override
  State<Dashboardscreen> createState() => _DashboardscreenState();
}

class _DashboardscreenState extends State<Dashboardscreen> {
  List<dynamic> tasks = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadTasks();
  }

  Future<void> loadTasks() async {
    try {
      setState(() {
        isLoading = true;
      });
      final fetchedTasks = await fetchTasks();
      setState(() {
        tasks = fetchedTasks;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<List<dynamic>> fetchTasks() async {
    final response = await http.get(
      Uri.parse('http://192.168.1.90:3000/task/'),
      headers: {'Authorization': 'Bearer'}
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      Get.snackbar('Error', 'Fallo al obtener las tareas');
      throw Exception('Failed to load tasks');
    }
  }

  Future<void> createTask(String title, String description, bool isDone) async {
    try {
      final response = await http.post(
        Uri.parse('http://192.168.1.90:3000/task/'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer'
        },
        body: jsonEncode({
          'title': title,
          'description': description,
          'do': isDone,
          'createdAt': DateTime.now().toIso8601String(),
        }),
      );

      if (response.statusCode == 201) {
        Get.snackbar('Éxito', 'Tarea creada exitosamente',
            backgroundColor: Colors.green.shade100,
            colorText: Colors.green.shade800);
        loadTasks();
      } else {
        Get.snackbar('Error', 'Error al crear la tarea');
      }
    } catch (e) {
      Get.snackbar('Error', 'Error de conexión');
    }
  }

  void _showCreateTaskModal() {
    final titleController = TextEditingController();
    final descriptionController = TextEditingController();
    bool isDone = false;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Row(
                children: [
                  Text('Nueva Tarea'),
                ],
              ),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: titleController,
                      decoration: InputDecoration(
                        labelText: 'Título',
                        hintText: 'Ingresa el título de la tarea',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        prefixIcon: Icon(Icons.title),
                      ),
                    ),
                    SizedBox(height: 16),
                    TextField(
                      controller: descriptionController,
                      maxLines: 3,
                      decoration: InputDecoration(
                        labelText: 'Descripción',
                        hintText: 'Describe la tarea...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        prefixIcon: Icon(Icons.description),
                      ),
                    ),
                    SizedBox(height: 16),
                    Row(
                      children: [
                        Checkbox(
                          value: isDone,
                          onChanged: (value) {
                            setState(() {
                              isDone = value ?? false;
                            });
                          },
                        ),
                        Text('Marcar como completada'),
                      ],
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Cancelar'),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (titleController.text.isNotEmpty &&
                        descriptionController.text.isNotEmpty) {
                      createTask(
                        titleController.text,
                        descriptionController.text,
                        isDone,
                      );
                      Navigator.of(context).pop();
                    } else {
                      Get.snackbar('Error', 'Por favor completa todos los campos');
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                  ),
                  child: Text('Crear Tarea'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
        backgroundColor: const Color.fromARGB(255, 121, 126, 130),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              const Color.fromARGB(255, 171, 171, 171),
              Colors.white,
            ],
          ),
        ),
        child: isLoading
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 16),
                    Text('Cargando...'),
                  ],
                ),
              )
            : tasks.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.task_alt,
                          size: 80,
                          color: Colors.grey.shade400,
                        ),
                        SizedBox(height: 16),
                        Text(
                          'No hay tareas disponibles',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey.shade600,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Toca el botón + para crear tu primera tarea',
                          style: TextStyle(
                            color: Colors.grey.shade500,
                          ),
                        ),
                      ],
                    ),
                  )
                : RefreshIndicator(
                    onRefresh: loadTasks,
                    child: ListView.builder(
                      padding: EdgeInsets.all(16),
                      itemCount: tasks.length,
                      itemBuilder: (context, index) {
                        final task = tasks[index];
                        return Card(
                          margin: EdgeInsets.only(bottom: 12),
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ListTile(
                            contentPadding: EdgeInsets.all(16),
                            leading: SizedBox(
                              width: 50,
                              height: 50,
                             
                              child: Icon(
                                task['do'] == true
                                    ? Icons.check_circle
                                    : Icons.pending,
                                color: task['do'] == true
                                    ? Colors.green
                                    : Colors.orange,
                              ),
                            ),
                            title: Text(
                              task['title'] ?? 'Sin título',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                decoration: task['do'] == true
                                    ? TextDecoration.lineThrough
                                    : null,
                              ),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (task['description'] != null)
                                  Padding(
                                    padding: EdgeInsets.only(top: 4),
                                    child: Text(
                                      task['description'],
                                      style: TextStyle(
                                        color: Colors.grey.shade600,
                                        decoration: task['do'] == true
                                            ? TextDecoration.lineThrough
                                            : null,
                                      ),
                                    ),
                                  ),
                                SizedBox(height: 8),
                                Row(
                                  children: [
                                   
                                    SizedBox(width: 4),
                                    Text(
                                      task['createdAt'] != null
                                          ? DateTime.parse(task['createdAt'])
                                              .toString()
                                              .split('.')[0]
                                          : 'Sin fecha',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey.shade500,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            
                            onTap: () {
                              Get.toNamed(
                                '/task/${task['id']}',
                                arguments: task,
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showCreateTaskModal,
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        icon: Icon(Icons.add),
        label: Text('Nueva Tarea'),
      ),
    );
  }
}