Task Manager - Aplicación de Gestión de Tareas
Una aplicación full-stack para gestión de tareas desarrollada con NestJS (backend) y Flutter (frontend).
📋 Tabla de Contenidos

Descripción
Tecnologías Utilizadas
Arquitectura del Proyecto
Configuración del Proyecto
Ejecución del Backend
Ejecución del Frontend
Endpoints API
Decisiones de Diseño
Limitaciones y Suposiciones
Estructura del Proyecto

📖 Descripción
Task Manager es una aplicación móvil que permite a los usuarios gestionar sus tareas diarias de manera eficiente. La aplicación incluye funcionalidades de autenticación, creación, visualización y gestión de tareas.

Funcionalidades Principales

Autenticación de usuarios (registro y login)
Gestión de tareas (crear, leer)
Interfaz móvil intuitiva
Sincronización en tiempo real
Estados de tareas (completadas/pendientes)

🛠️ Tecnologías Utilizadas
Backend (NestJS)

NestJS v10.0.0 - Framework de Node.js para aplicaciones escalables
Firebase Admin v12.3.0 - Base de datos y autenticación
Passport JWT v4.0.1 - Autenticación basada en tokens
Swagger v11.2.0 - Documentación automática de API
TypeScript v5.1.3 - Tipado estático
CORS v2.8.5 - Política de origen cruzado

Frontend (Flutter)

Flutter SDK ^3.8.1 - Framework multiplataforma
GetX v4.7.2 - Gestión de estado y navegación
HTTP v0.13.5 - Cliente HTTP para API calls
Dart ^3.8.1 - Lenguaje de programación


⚙️ Configuración del Proyecto
Prerrequisitos

Node.js (versión 16 o superior)
npm o yarn
Flutter SDK (versión 3.8.1 o superior)
Dart SDK
Firebase cuenta y proyecto configurado

Configuración de Firebase

Crear un proyecto en Firebase Console
Configurar Authentication (Email/Password)
Configurar Firestore Database
Descargar el archivo de configuración:

google-services.json para Android
GoogleService-Info.plist para iOS
Service Account Key para el backend



🚀 Ejecución del Backend
1. Instalación de dependencias
bashcd backend
npm install
2. Configuración de variables de entorno
Crear un archivo .env en la raíz del directorio backend:
envFIREBASE_PROJECT_ID=tu-project-id
FIREBASE_PRIVATE_KEY=tu-private-key
FIREBASE_CLIENT_EMAIL=tu-client-email
JWT_SECRET=tu-jwt-secret
PORT=3000
3. Configuración de Firebase Admin
Colocar el archivo serviceAccountKey.json en la carpeta backend/src/config/
4. Ejecución del servidor
bash# Desarrollo
npm run start:dev

# Producción
npm run build
npm run start:prod
El servidor estará disponible en http://localhost:3000
5. Documentación API
Acceder a Swagger UI en: http://localhost:3000/api
📱 Ejecución del Frontend
1. Instalación de dependencias
bashcd frontend
flutter pub get
2. Configuración de Firebase

Colocar google-services.json en android/app/
Colocar GoogleService-Info.plist en ios/Runner/

3. Configuración de la IP del servidor
Actualizar la IP en los archivos del controlador:
dart// En lib/controller/auth_controller.dart
final baseUrl = 'http://TU_IP_LOCAL:3000';
4. Ejecución de la aplicación
bash# Verificar dispositivos disponibles
flutter devices

# Ejecutar en dispositivo/emulador
flutter run
🔗 Endpoints API
Autenticación
MétodoEndpointDescripciónBodyPOST/auth/registerRegistrar usuario{ "email": "string", "password": "string" }POST/auth/loginIniciar sesión{ "email": "string", "password": "string" }
Tareas
MétodoEndpointDescripciónBodyGET/taskObtener todas las tareas-POST/taskCrear nueva tarea{ "title": "string", "description": "string", "do": boolean, "createdAt": "Date" }GET/task/:idObtener tarea por ID-PATCH/task/:idActualizar tarea{ "title": "string", "description": "string", "do": boolean }DELETE/task/:idEliminar tarea-
Respuestas de ejemplo
Registro exitoso
json{
  "status": "success",
  "message": "Usuario registrado exitosamente",
  "uid": "jT5KR9ZCzKxGu4hyrU5V"
}
Lista de tareas
json[
  {
    "id": "task123",
    "title": "Completar proyecto",
    "description": "Finalizar el desarrollo de la aplicación",
    "do": false,
    "createdAt": "2024-01-15T10:30:00Z"
  }
]

🎨 Decisiones de Diseño
Backend (NestJS)
Arquitectura Modular

Justificación: Separación clara de responsabilidades entre autenticación y gestión de tareas
Beneficios: Mantenibilidad, escalabilidad y testing independiente

Firebase como Base de Datos

Justificación: Integración nativa con autenticación y tiempo real
Beneficios: Escalabilidad automática, sincronización en tiempo real, seguridad integrada

Passport JWT para Autenticación

Justificación: Estándar de la industria para APIs REST
Beneficios: Stateless, seguro, fácil de implementar

Swagger para Documentación

Justificación: Documentación automática y interactiva
Beneficios: Facilita el testing y la integración

Frontend (Flutter)
GetX para Gestión de Estado

Justificación: Simplifica la gestión de estado, navegación y dependencias
Beneficios: Menos código boilerplate, mejor rendimiento, fácil de aprender

Arquitectura MVC

Justificación: Separación clara entre lógica de negocio y presentación
Beneficios: Código más organizado, testeable y mantenible

HTTP Package

Justificación: Cliente HTTP oficial de Dart, simple y eficiente
Beneficios: Ligero, bien documentado, ampliamente usado

Material Design

Justificación: Consistencia visual y UX familiar para usuarios
Beneficios: Componentes pre-diseñados, accesibilidad integrada

🔒 Patrones de Seguridad
Backend

JWT Tokens: Autenticación stateless
CORS: Configuración de orígenes permitidos
Validation: DTOs para validación de entrada
Firebase Rules: Reglas de seguridad en base de datos

Frontend

Token Storage: Gestión segura de tokens
Input Validation: Validación en cliente
Error Handling: Manejo apropiado de errores de red


Mejoras Futuras

 Implementar modo offline
 Agregar notificaciones push
 Soporte para categorías de tareas
 Filtros y búsqueda avanzada
 Exportar datos
 Modo oscuro
 Localización multiidioma


👥 Contribución
Este proyecto fue desarrollado como prueba técnica. Para contribuir:

Fork el repositorio
Crear una branch para la feature
Commit los cambios
Push a la branch
Crear un Pull Request


📄 Licencia
Desarrollado por: Jhonatan Mejias
Versión: 1.0.0