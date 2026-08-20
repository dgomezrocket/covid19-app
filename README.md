# 📱 CroniApp — Aplicación Flutter de Salud en Mapa / CroniWeb Legacy

![Flutter](https://img.shields.io/badge/Flutter-%E2%89%A5%202.0.0%20declarado-02569B?logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-%3E%3D2.12.0%20%3C4.0.0-0175C2?logo=dart&logoColor=white)
![flutter_map](https://img.shields.io/badge/flutter__map-6.2.1-4CAF50?logo=leaflet&logoColor=white)
![Geolocator](https://img.shields.io/badge/geolocator-10.1.1-FF7043?logo=googlemaps&logoColor=white)
![OpenStreetMap](https://img.shields.io/badge/Mapas-OpenStreetMap-7EBC6F?logo=openstreetmap&logoColor=white)
![Android](https://img.shields.io/badge/Android-compileSdk%2036-3DDC84?logo=android&logoColor=white)
![Java](https://img.shields.io/badge/Java-17-ED8B00?logo=openjdk&logoColor=white)
[![Backend](https://img.shields.io/badge/Backend-Railway-0B0D0E?logo=railway&logoColor=white)](https://backend-core-covid19-production.up.railway.app)

**CroniApp** es el cliente **Flutter orientado al paciente** del sistema legacy **Salud en Mapa / CroniWeb**.

La aplicación permite que el paciente inicie sesión, administre sus datos personales y su ubicación, complete los formularios que el sistema le asigna, consulte sus respuestas anteriores, visualice hospitales sobre un mapa y mantenga un intercambio de mensajes con el sistema.

Toda la comunicación se realiza mediante **API REST con autenticación JWT** contra el backend `backend-core-covid19`.

- 📱 **Repositorio de esta aplicación:** [dgomezrocket/covid19-app](https://github.com/dgomezrocket/covid19-app)
- 🔧 **Backend consumido:** [backend-core-covid19](https://github.com/dgomezrocket/backend-core-covid19) — [producción en Railway](https://backend-core-covid19-production.up.railway.app)
- 🌐 **Frontend web relacionado:** [covid19-web-old](https://github.com/dgomezrocket/covid19-web-old) — [old.saludenmapa.com](https://old.saludenmapa.com/)

---

## 📋 Tabla de contenidos

- [🎯 Descripción del proyecto](#-descripción-del-proyecto)
- [🔗 Ecosistema Salud en Mapa / CroniWeb Legacy](#-ecosistema-salud-en-mapa--croniweb-legacy)
- [✨ Características implementadas](#-características-implementadas)
- [📱 Módulos principales](#-módulos-principales)
- [🧭 Navegación y pantallas](#-navegación-y-pantallas)
- [🧱 Arquitectura](#-arquitectura)
- [🔐 Autenticación y sesión](#-autenticación-y-sesión)
- [💾 Persistencia local](#-persistencia-local)
- [🔌 Integración con el backend](#-integración-con-el-backend)
- [🔌 Endpoints consumidos por CroniApp](#-endpoints-consumidos-por-croniapp)
- [👤 Perfil del paciente](#-perfil-del-paciente)
- [📋 Formularios y respuestas](#-formularios-y-respuestas)
- [🏥 Hospitales y geolocalización](#-hospitales-y-geolocalización)
- [💬 Mensajería](#-mensajería)
- [📚 Modelos del dominio](#-modelos-del-dominio)
- [🌐 Plataformas configuradas](#-plataformas-configuradas)
- [📍 Permisos](#-permisos)
- [🧰 Tecnologías utilizadas](#-tecnologías-utilizadas)
- [📦 Requisitos previos](#-requisitos-previos)
- [💻 Entorno de desarrollo](#-entorno-de-desarrollo)
- [🚀 Instalación](#-instalación)
- [🏃 Ejecución](#-ejecución)
- [📦 Builds](#-builds)
- [📂 Estructura del proyecto](#-estructura-del-proyecto)
- [🌍 Internacionalización](#-internacionalización)
- [🧪 Pruebas](#-pruebas)
- [🤝 Contribución](#-contribución)
- [🔗 Proyectos relacionados](#-proyectos-relacionados)
- [👥 Autores](#-autores)
- [👤 Autor y contacto](#-autor-y-contacto)

---

## 🎯 Descripción del proyecto

CroniApp es la aplicación Flutter de la versión **legacy** del sistema Salud en Mapa / CroniWeb, un sistema de registro y seguimiento georreferenciado de pacientes desarrollado en el contexto de la pandemia de COVID-19.

Dentro de ese ecosistema, CroniApp cumple el rol de **cliente del paciente**: es la interfaz por la que la persona registrada carga y actualiza sus propios datos, responde los formularios que el sistema le asigna y se comunica con él. Las tareas administrativas y de gestión no forman parte de esta aplicación; se realizan desde el frontend web.

La aplicación no posee base de datos propia ni lógica de negocio del lado del cliente: delega la totalidad de las operaciones en la API REST del backend y conserva localmente únicamente el token de sesión.

**Usuario objetivo:** el paciente registrado en el sistema.

El nombre visible de la aplicación es `CroniApp` (definido en `MaterialApp.title` y en la barra superior). El identificador del paquete Dart es `covid19`, y los identificadores nativos permanecen como `com.example.covid19`.

---

## 🔗 Ecosistema Salud en Mapa / CroniWeb Legacy

El sistema legacy está compuesto por tres repositorios. Los dos clientes son independientes entre sí y se comunican únicamente a través del backend.

```text
                    Salud en Mapa / CroniWeb
                         Sistema Legacy

    ┌────────────────────────────┐      ┌────────────────────────────┐
    │        Frontend Web        │      │         CroniApp           │
    │    old.saludenmapa.com     │      │      Flutter / Dart        │
    │           React            │      │        Pacientes           │
    │      covid19-web-old       │      │       covid19-app          │
    └─────────────┬──────────────┘      └─────────────┬──────────────┘
                  │                                   │
                  │  REST + Authorization: Bearer     │
                  └─────────────┬─────────────────────┘
                                ▼
                  ┌───────────────────────────────┐
                  │            Backend            │
                  │     backend-core-covid19      │
                  │          Spring Boot          │
                  │            Railway            │
                  └───────────────┬───────────────┘
                                  ▼
                          ┌───────────────┐
                          │  PostgreSQL   │
                          │   (Railway)   │
                          └───────────────┘
```

| Componente | Repositorio | Rol |
|---|---|---|
| 📱 **CroniApp** | [covid19-app](https://github.com/dgomezrocket/covid19-app) | Cliente Flutter orientado al paciente — **este repositorio** |
| 🌐 **Frontend Web** | [covid19-web-old](https://github.com/dgomezrocket/covid19-web-old) | Frontend web React de la misma versión legacy |
| 🔧 **Backend** | [backend-core-covid19](https://github.com/dgomezrocket/backend-core-covid19) | API REST Spring Boot sobre PostgreSQL, desplegada en Railway |

> [!NOTE]
> La URL [old.saludenmapa.com](https://old.saludenmapa.com/) corresponde al frontend web React (`covid19-web-old`). No es un despliegue del directorio `web/` de esta aplicación Flutter.

---

## ✨ Características implementadas

Esta sección documenta únicamente funcionalidades verificadas contra el código, con llamada efectiva al backend.

### 🔐 Autenticación y sesión

- Registro de cuenta con correo y contraseña (`POST /accounts/signup`).
- Inicio de sesión con correo y contraseña (`POST /authentication/authenticate`).
- Validación reactiva de correo y contraseña mediante streams antes de habilitar el envío.
- Persistencia del token JWT con `SharedPreferences`.
- Restauración de la sesión al abrir la aplicación.
- Cierre de sesión con diálogo de confirmación y limpieza del almacenamiento local.

### 👤 Datos personales

- Consulta de los datos del paciente autenticado (`GET /persons/my`).
- Edición y guardado de documento, nombres, apellidos, teléfono, dirección, provincia, fecha de nacimiento y sexo (`PUT /persons/`).
- Selección de provincia a partir del listado del backend (`GET /provinces/`).
- Selector de fecha de nacimiento localizado en español.
- Captura de coordenadas del domicilio mediante GPS sobre un mapa.

### 📋 Formularios

- Listado de los formularios asignados al paciente (`GET /forms/my`).
- Apertura de un formulario y construcción dinámica de sus ítems según el tipo declarado por el backend.
- Ítems de tipo casilla de verificación (`CHECK`) y de tipo texto libre (`INPUT_TEXT`).
- Envío de las respuestas con confirmación previa (`POST /answers/`).

### ✅ Respuestas

- Consulta del historial de formularios respondidos (`GET /answers/`).
- Listado expandible por respuesta, con el título del formulario, su fecha y el texto registrado para cada ítem.

### 🏥 Hospitales y ubicación

- Obtención de los hospitales asociados al paciente (`GET /hospitals/my`).
- Representación de los hospitales sobre un mapa de OpenStreetMap.
- Marcador diferenciado para la ubicación del paciente y para los hospitales.
- Obtención de la ubicación del dispositivo con solicitud de permisos y verificación del estado del GPS.

### 💬 Mensajería

- Consulta de los mensajes del paciente (`GET /messages/`).
- Envío de mensajes de texto (`POST /messages/`).
- Presentación en burbujas diferenciadas según emisor y receptor.
- Actualización del listado luego de enviar un mensaje.

---

## 📱 Módulos principales

La pantalla `Home` (`lib/src/screens/home_screen.dart`) organiza la aplicación en cinco módulos mediante un `BottomNavigationBar`.

| # | Módulo | Icono | Widget | Función |
|---|---|---|---|---|
| 0 | **Datos** | `person` | `ProfilePage` | Consulta y actualización de los datos personales y de la ubicación del domicilio |
| 1 | **Formularios** | `assessment` | `FormsPage` | Formularios asignados al paciente y acceso a su resolución |
| 2 | **Respuestas** | `assessment` | `AnswersPage` | Consulta del historial de formularios respondidos |
| 3 | **Hospitales** | `add_location` | `OSMMap` | Hospitales del paciente representados sobre un mapa |
| 4 | **Mensajes** | `mail` | `MessagePage` | Consulta y envío de mensajes |

La barra superior muestra el título `CroniApp` y una acción **Salir** que cierra la sesión.

> [!NOTE]
> La barra de navegación se construye a partir del resultado de `GET /persons/my`. Si esa consulta no devuelve datos, la pantalla se muestra sin la barra inferior.

---

## 🧭 Navegación y pantallas

La aplicación utiliza el sistema de rutas clásico de Flutter. `lib/src/utils/routes.dart` declara **cuatro rutas nombradas**; no hay `initialRoute`, `onGenerateRoute` ni Navigator 2.0. El punto de entrada se resuelve en `MaterialApp.home`, que decide entre `Home` y `LoginScreen` según exista un token almacenado.

### Rutas nombradas

| Ruta | Pantalla | Descripción | Estado funcional |
|---|---|---|---|
| `/home` | `Home` | Contenedor con la barra de navegación de los cinco módulos | Implementada |
| `/login` | `LoginScreen` | Inicio de sesión contra el backend | Implementada |
| `/signup` | `SignupScreen` | Registro de cuenta con correo y contraseña | Implementada |
| `/forgot_password` | `ForgotPassword` | Pantalla estática que muestra el texto `Forgot password` | Solo interfaz: no contiene campos, ni acción de envío, ni llamada al backend |

### Navegación mediante `MaterialPageRoute`

Dos pantallas no están registradas como rutas nombradas y se alcanzan por navegación directa.

| Origen | Destino | Descripción | Estado funcional |
|---|---|---|---|
| `FormsPage` | `FormPage` | Resolución de un formulario concreto | Implementada |
| `ProfilePage` | `LiveMap` | Selección de la ubicación del domicilio; devuelve la posición obtenida al perfil | Implementada |

### Transiciones que reemplazan la pila

| Situación | Destino |
|---|---|
| Registro exitoso | `/login` (`pushNamedAndRemoveUntil`) |
| Inicio de sesión exitoso | `/home` (`pushNamedAndRemoveUntil`) |
| Cierre de sesión confirmado | `/login` (`pushNamedAndRemoveUntil`) |

El uso de `pushNamedAndRemoveUntil` en el ingreso y en el cierre de sesión impide volver con el botón atrás a la pantalla anterior.

---

## 🧱 Arquitectura

CroniApp organiza el código en capas por responsabilidad. **No aplica un único patrón de estado en toda la aplicación:** conviven dos enfoques bien delimitados.

```text
Paciente
   │
   ▼
Screens / Pages
   │
   ├── Autenticación (login, signup)
   │        └── FormBloc  ──►  rxdart (BehaviorSubject + StreamTransformer)
   │
   └── Resto de módulos (perfil, formularios, respuestas, mapa, mensajes)
            └── FutureBuilder  ──►  profileProvider (singleton)
   │
   ▼
Services  (AuthService · PersonService)
   │
   ▼
package:http   +   Authorization: Bearer <token>
   │
   ▼
API REST Spring Boot  (backend-core-covid19 · Railway)
   │
   ▼
PostgreSQL
```

### Responsabilidad de cada directorio

| Directorio | Responsabilidad |
|---|---|
| `lib/main.dart` | Punto de entrada; ejecuta `runApp(App())` |
| `lib/src/app.dart` | Configura `MaterialApp`, rutas, localizaciones y resuelve la pantalla inicial según la sesión |
| `lib/src/blocs/` | Lógica reactiva de los formularios de autenticación (`form_bloc.dart`) |
| `lib/src/mixins/` | Validadores de correo y contraseña, y widget de mensaje de error compartido |
| `lib/src/models/` | Modelos del dominio con `fromJson` / `toJson` |
| `lib/src/options/` | Widgets reutilizables de ítems de formulario, respuestas y burbujas de mensaje |
| `lib/src/pages/` | Páginas de los módulos de la barra de navegación, más el formulario y el mapa de ubicación |
| `lib/src/providers/` | `InheritedWidget` propio y singleton de acceso a datos |
| `lib/src/screens/` | Pantallas de autenticación y contenedor principal |
| `lib/src/services/` | Clientes HTTP y manejo del token |
| `lib/src/utils/` | URL base, rutas, constantes, estilos y utilidades |

### BLoC y RxDart

`lib/src/blocs/form_bloc.dart` es el **único** BLoC del proyecto y lo consumen **exclusivamente** `LoginScreen` y `SignupScreen`.

Expone tres `BehaviorSubject` de `rxdart` (correo, contraseña y mensaje de error), dos `StreamTransformer` de validación provistos por `ValidationMixin`, y un stream combinado con `Rx.combineLatest3` que alimenta el estado del botón de envío. Además concentra las llamadas de registro e inicio de sesión y la navegación posterior.

Los módulos de perfil, formularios, respuestas, hospitales y mensajes **no usan streams ni BLoC**: resuelven su estado con `FutureBuilder` y `setState`.

### Providers

| Archivo | Clase | Descripción |
|---|---|---|
| `providers/provider.dart` | `Provider` | `InheritedWidget` propio que expone una instancia de `FormBloc` al árbol de widgets mediante `Provider.of(context)` |
| `providers/profile_provider.dart` | `profileProvider` | Singleton global que envuelve a `PersonService` y traduce las respuestas JSON a los modelos del dominio |

> [!IMPORTANT]
> `Provider` es una clase propia de este proyecto. **El paquete [`provider`](https://pub.dev/packages/provider) no es una dependencia de CroniApp** y no debe confundirse con esta implementación.

---

## 🔐 Autenticación y sesión

### Registro

`SignupScreen` recolecta **únicamente correo y contraseña** y los envía a `POST /accounts/signup`. Los datos personales del paciente no se cargan en el registro: se administran desde el módulo **Datos**. Si la respuesta incluye un campo `status`, el mensaje se muestra como error; en caso contrario la aplicación navega a `/login`.

### Inicio de sesión

`LoginScreen` envía las credenciales a `POST /authentication/authenticate`. El token se toma del campo **`jwt`** de la respuesta JSON y se almacena localmente antes de navegar a `/home`.

### Uso del token

Todas las operaciones de `PersonService` incorporan la cabecera de autorización:

```http
Authorization: Bearer <token>
```

Las dos operaciones de `AuthService` (registro e inicio de sesión) se envían sin cabecera de autorización, con `Content-Type: application/json`.

### Restauración de la sesión

`lib/src/app.dart` resuelve la pantalla inicial con un `FutureBuilder` sobre la lectura del token:

```text
Apertura de la aplicación
      │
      ▼
Lectura de la clave 'token' en SharedPreferences
      │
      ├── existe   ──►  Home
      └── no existe ──►  LoginScreen
```

La sesión se considera activa por la **presencia** de la clave. El token no se decodifica ni se valida localmente, y no se almacena información de expiración.

### Cierre de sesión

La acción **Salir** abre un diálogo de confirmación. Al aceptar, se limpia el almacenamiento local de `SharedPreferences` y se navega a `/login` descartando la pila de navegación.

---

## 💾 Persistencia local

El único mecanismo de persistencia local es **`shared_preferences`**, y todo su uso está concentrado en `lib/src/services/auth_service.dart`.

| Clave | Tipo | Contenido | Operaciones |
|---|---|---|---|
| `token` | `String` | Token JWT devuelto por el backend en el campo `jwt` | escritura al iniciar sesión, lectura en cada petición protegida y al restaurar la sesión |

`removeToken()` invoca `clear()`, por lo que el cierre de sesión elimina la totalidad del almacenamiento de preferencias de la aplicación.

> [!IMPORTANT]
> `SharedPreferences` almacena los valores en texto plano y no ofrece cifrado. El proyecto **no** utiliza SQLite, Hive, Drift, Isar ni almacenamiento seguro del sistema operativo: no existe base de datos local ni caché offline, y toda la información se obtiene del backend en cada consulta.

---

## 🔌 Integración con el backend

CroniApp consume la API REST de [`backend-core-covid19`](https://github.com/dgomezrocket/backend-core-covid19), desplegada actualmente en Railway:

```text
https://backend-core-covid19-production.up.railway.app
```

La URL está definida de forma literal en `lib/src/utils/config.dart`, cuyo contenido completo es una única línea:

```dart
final baseUrl = 'https://backend-core-covid19-production.up.railway.app';
```

No existen archivos `.env`, variables de entorno ni perfiles de configuración por ambiente: la URL de producción es la única configurada y los servicios construyen cada endpoint interpolando `'$baseUrl/...'`.

La comunicación se realiza con el paquete `http`. Las respuestas de lectura se decodifican con `utf8.decode(resp.bodyBytes)` antes de interpretarse como JSON, para preservar los caracteres acentuados.

### Servicios

| Service | Archivo | Responsabilidad |
|---|---|---|
| `AuthService` | `lib/src/services/auth_service.dart` | Registro, inicio de sesión y manejo local del token en `SharedPreferences` |
| `PersonService` | `lib/src/services/person_service.dart` | Operaciones autenticadas del paciente: datos personales, formularios, respuestas, hospitales, mensajes y provincias |

---

## 🔌 Endpoints consumidos por CroniApp

Listado completo y verificado de las **11 operaciones HTTP** que la aplicación realiza. Todas las rutas se resuelven sobre `baseUrl`.

### 🔐 Autenticación

| Método | Endpoint | Uso | Autorización |
|---|---|---|---|
| `POST` | `/accounts/signup` | Registro de cuenta con `email` y `password` | — |
| `POST` | `/authentication/authenticate` | Inicio de sesión; la respuesta incluye el campo `jwt` | — |

### 👤 Paciente

| Método | Endpoint | Uso | Autorización |
|---|---|---|---|
| `GET` | `/persons/my` | Datos del paciente autenticado | Bearer |
| `PUT` | `/persons/` | Actualización de los datos personales, la provincia y la ubicación | Bearer |

### 📋 Formularios

| Método | Endpoint | Uso | Autorización |
|---|---|---|---|
| `GET` | `/forms/my` | Formularios asignados al paciente, con sus ítems y opciones | Bearer |

### ✅ Respuestas

| Método | Endpoint | Uso | Autorización |
|---|---|---|---|
| `GET` | `/answers/` | Historial de formularios respondidos | Bearer |
| `POST` | `/answers/` | Envío de las respuestas de un formulario | Bearer |

### 🏥 Hospitales

| Método | Endpoint | Uso | Autorización |
|---|---|---|---|
| `GET` | `/hospitals/my` | Hospitales asociados al paciente, junto con sus datos y ubicación | Bearer |

### 💬 Mensajes

| Método | Endpoint | Uso | Autorización |
|---|---|---|---|
| `GET` | `/messages/` | Mensajes del paciente y sus propios datos | Bearer |
| `POST` | `/messages/` | Envío de un mensaje de texto | Bearer |

### 🌎 Provincias

| Método | Endpoint | Uso | Autorización |
|---|---|---|---|
| `GET` | `/provinces/` | Listado de provincias para el selector del perfil | Bearer |

> [!NOTE]
> El backend expone más recursos de los aquí listados. Esta tabla documenta exclusivamente lo que **esta aplicación Flutter** consume.

---

## 👤 Perfil del paciente

El módulo **Datos** (`lib/src/pages/profile_page.dart`) es la pantalla de mayor extensión de la aplicación. Al abrirse solicita el listado de provincias y luego los datos del paciente.

### Campos editables

| Campo | Control | Validación |
|---|---|---|
| Documento | Texto | Obligatorio |
| Nombres | Texto | Obligatorio |
| Apellidos | Texto | Obligatorio |
| Teléfono | Texto | Obligatorio |
| Dirección | Texto + botón de ubicación | Obligatoria, y requiere que exista una ubicación asociada |
| Provincia | Lista desplegable poblada desde `GET /provinces/` | Selección |
| Fecha de nacimiento | Selector de fecha (`showDatePicker`, formato `dd/MM/yyyy`, locale `es_ES`) | Selección |
| Sexo | Lista desplegable con `MASCULINO` y `FEMENINO` | Selección |

El rango del selector de fecha va desde el año 1800 hasta la fecha actual, y se posiciona inicialmente 18 años atrás.

### Ubicación del domicilio

El botón junto al campo de dirección abre `LiveMap`, que devuelve la posición obtenida al perfil y la asocia como latitud y longitud del paciente. La validación del campo de dirección exige que exista esa ubicación antes de permitir el guardado.

### Guardado

El botón **Guardar** abre un diálogo de confirmación. Al aceptar se validan los campos del formulario y se envía el paciente completo mediante `PUT /persons/`. El resultado se informa con un mensaje de éxito o de error.

Los datos enviados incluyen documento, nombres, apellidos, fecha de nacimiento, teléfono, sexo, dirección, ubicación, estado y provincia.

---

## 📋 Formularios y respuestas

### Formularios disponibles

`FormsPage` consulta `GET /forms/my` y presenta cada formulario como una tarjeta con su título y subtítulo. Si no hay formularios, muestra el mensaje `No hay formularios disponibles`.

### Resolución de un formulario

`FormPage` construye los controles a partir del campo `type` de cada ítem que envía el backend:

| `type` del ítem | Control generado | Respuesta registrada |
|---|---|---|
| `CHECK` | Casilla de verificación con título y subtítulo | Texto `Sí` cuando queda marcada |
| `INPUT_TEXT` | Panel expandible con campo de texto libre | El texto ingresado |

Al confirmar el guardado, la aplicación recorre los controles, arma el conjunto de respuestas junto con el formulario y la fecha actual, y lo envía mediante `POST /answers/`.

### Historial de respuestas

`AnswersPage` consulta `GET /answers/` y presenta un listado expandible. Cada entrada muestra el título del formulario y su fecha con el formato `dd/MM/yyyy – kk:mm`, o `Sin fecha` si no la tiene. Al expandirla se listan los ítems con el texto registrado, o `Sin respuesta` cuando está vacío.

Se trata de una vista de **consulta**: no permite editar ni reenviar respuestas anteriores.

---

## 🏥 Hospitales y geolocalización

El proveedor cartográfico es **OpenStreetMap**, consumido con `flutter_map`. Las coordenadas se manejan con `latlong2` y el acceso a la ubicación del dispositivo con `geolocator`. **El proyecto no utiliza Google Maps.**

La plantilla de mosaicos es idéntica en todos los mapas de la aplicación:

```text
TileLayer(
  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
  userAgentPackageName: 'com.example.covid19',
)
```

### Mapa de hospitales

`lib/src/pages/map_page.dart` (`OSMMap`, módulo **Hospitales**) consulta `GET /hospitals/my` y dibuja el resultado sobre el mapa:

| Elemento | Marcador |
|---|---|
| Ubicación del paciente | Icono `accessibility` |
| Cada hospital | Icono `local_hospital` |

El mapa se centra en la ubicación registrada del paciente. Cuando esa ubicación no está disponible, utiliza las coordenadas de referencia `-25.2819, -57.635` (Asunción) con un nivel de zoom de 15. Los marcadores son informativos: no tienen acción al tocarlos.

### Captura de la ubicación

`lib/src/pages/livemap_location.dart` (`LiveMap`, título **Mi domicilio**) concentra todo el uso de `geolocator` y se abre desde el perfil. Ofrece dos acciones:

- **Obtener la posición actual**, que consulta el GPS y recentra el mapa sobre el resultado.
- **Confirmar la ubicación**, que devuelve la posición al perfil.

Si el paciente ya tiene una ubicación registrada, el mapa parte de ella; en caso contrario intenta la última posición conocida del dispositivo y, a falta de ambas, utiliza las coordenadas de referencia de Asunción.

El flujo de permisos verifica el permiso concedido, lo solicita cuando corresponde y comprueba que el servicio de ubicación esté activo, con hasta dos intentos. Informa `Por favor, active su gps para continuar.` cuando el GPS está desactivado y `No se puede continuar por falta de permisos.` cuando el permiso no fue otorgado.

> [!NOTE]
> `lib/src/pages/other_map.dart` contiene un mapa con marcadores de coordenadas fijas y no está referenciado por la navegación de la aplicación.

---

## 💬 Mensajería

El módulo **Mensajes** (`lib/src/pages/message_page.dart`) utiliza **HTTP/REST** sobre los mismos endpoints autenticados que el resto de la aplicación.

- Al abrirse consulta `GET /messages/`, que devuelve los mensajes junto con los datos del propio paciente.
- Los mensajes se presentan en burbujas, diferenciando visualmente los propios de los recibidos, con la fecha y el nombre de la persona.
- El campo de escritura admite varias líneas y el botón de envío permanece deshabilitado mientras el texto esté vacío.
- Al enviar, la aplicación realiza `POST /messages/` y vuelve a consultar el listado.

> [!IMPORTANT]
> La mensajería es **HTTP/REST por consulta**. La aplicación **no** implementa WebSocket, no mantiene una conexión persistente, no realiza sondeo periódico y no utiliza notificaciones push. El listado se actualiza al abrir el módulo y luego de enviar un mensaje.

---

## 📚 Modelos del dominio

`lib/src/models/` define los objetos que la aplicación intercambia con la API. Cada modelo implementa `fromJson`, y los que se envían al backend implementan además `toJson`.

| Modelo | Representa |
|---|---|
| `Person` | Paciente: documento, nombres, apellidos, fecha de nacimiento, teléfono, sexo, dirección, ubicación, estado y provincia |
| `Account` | Cuenta con su correo, la persona asociada y sus roles |
| `Role` | Rol asignado a una cuenta |
| `Status` | Estado del paciente |
| `Location` | Coordenadas de latitud y longitud |
| `Province` | Provincia con código, nombre y capital |
| `District` | Distrito, asociado a una provincia |
| `FormPerson` | Formulario con título, subtítulo, orden y sus ítems |
| `Item` | Ítem o pregunta de un formulario, con su tipo y opciones |
| `Option` | Opción asociada a un ítem |
| `Answer` | Conjunto de respuestas de un formulario, con su fecha |
| `ItemsAnswer` | Respuesta individual a un ítem |
| `Hospital` | Hospital con nombre, dirección, código, teléfono, área, director, tipo, distrito y ubicación |
| `HospitalResponse` | Respuesta de `GET /hospitals/my`: el paciente y sus hospitales |
| `Message` | Mensaje a enviar: texto, fecha, emisor y receptor |
| `MessageItem` | Mensaje recibido: texto, fecha, persona y condición de receptor |
| `MessageResponse` | Respuesta de `GET /messages/`: los mensajes y los datos propios |

---

## 🌐 Plataformas configuradas

El repositorio versiona configuración nativa para **tres plataformas**:

| Plataforma | Directorio | Estado de la configuración |
|---|---|---|
| 🤖 **Android** | `android/` | Configurada: Gradle, manifiestos, permisos, `MainActivity.kt` e iconos de lanzador |
| 🍎 **iOS** | `ios/` | Configurada: proyecto Xcode, `Info.plist` con permisos de ubicación y `AppDelegate.swift` |
| 🌐 **Web** | `web/` | Configurada: `index.html`, `manifest.json`, favicon e iconos |

> [!IMPORTANT]
> **No existen aplicaciones nativas de escritorio.** El repositorio no contiene los directorios `windows/`, `macos/` ni `linux/`, por lo que CroniApp no puede describirse como aplicación de escritorio nativa.

### Android

| Parámetro | Valor |
|---|---|
| `namespace` / `applicationId` | `com.example.covid19` |
| `compileSdk` / `targetSdk` | `36` |
| `minSdk` | Delegado a `flutter.minSdkVersion` |
| Compatibilidad Java | `17` (source y target) |
| Kotlin `jvmTarget` | `17` |
| Android Gradle Plugin | `8.7.0` |
| Plugin de Kotlin | `2.1.0` |
| Gradle (wrapper) | `8.9` |
| `android:label` | `covid19` |
| Firma de `release` | Reutiliza `signingConfigs.debug`; no hay bloque `signingConfigs` propio |

El código nativo se reduce a `MainActivity.kt`, que extiende `FlutterActivity` sin lógica adicional.

### iOS

| Parámetro | Valor |
|---|---|
| `PRODUCT_BUNDLE_IDENTIFIER` | `com.example.covid19` |
| `IPHONEOS_DEPLOYMENT_TARGET` | `9.0` |
| `SWIFT_VERSION` | `5.0` |
| `CFBundleName` | `covid19` |
| `CFBundleDisplayName` | No definido |
| Orientaciones | Vertical y horizontal en iPhone; se agrega vertical invertida en iPad |

El repositorio **no versiona `Podfile` ni `Podfile.lock`**, y los archivos `Debug.xcconfig` y `Release.xcconfig` solo incluyen `Generated.xcconfig`.

### Web

| Parámetro | Valor |
|---|---|
| `<title>` de `index.html` | `covid19` |
| `name` / `short_name` del manifiesto | `covid19` |
| `theme_color` / `background_color` | `#0175C2` |
| Orientación | `portrait-primary` |
| Iconos | `Icon-192.png` y `Icon-512.png` |

`web/index.html` corresponde a la plantilla histórica de Flutter Web: registra el service worker manualmente, carga `main.dart.js` de forma directa y no declara una etiqueta `<base href>`.

---

## 📍 Permisos

Los permisos ya están declarados en el repositorio. Esta sección documenta los existentes.

### Android

`android/app/src/main/AndroidManifest.xml`:

```xml
<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
<uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />
<uses-permission android:name="android.permission.INTERNET" />
```

| Permiso | Motivo |
|---|---|
| `ACCESS_FINE_LOCATION` | Obtener la ubicación precisa del domicilio con alta exactitud |
| `ACCESS_COARSE_LOCATION` | Obtener la ubicación aproximada del dispositivo |
| `INTERNET` | Consumir la API REST y descargar los mosaicos de OpenStreetMap |

Los manifiestos de `debug` y `profile` declaran únicamente `INTERNET`, necesario para la comunicación con las herramientas de Flutter.

### iOS

`ios/Runner/Info.plist` declara dos descripciones de uso de la ubicación:

| Clave | Valor declarado |
|---|---|
| `NSLocationWhenInUseUsageDescription` | `This app needs access to location when open.` |
| `NSLocationAlwaysUsageDescription` | `This app needs access to location when in the background.` |

No se declaran otros permisos ni descripciones de uso.

---

## 🧰 Tecnologías utilizadas

### Dependencias declaradas

Fuente: `pubspec.yaml`. La columna *Resuelta* proviene de `pubspec.lock`.

| Dependencia | Restricción declarada | Resuelta | Uso |
|---|---|---|---|
| `flutter` | SDK | — | Framework de la aplicación |
| `flutter_localizations` | SDK | — | Localización de los componentes de Flutter |
| `cupertino_icons` | `^1.0.0` | `1.0.8` | Iconografía de estilo iOS |
| `rxdart` | `^0.27.7` | `0.27.7` | Streams y `BehaviorSubject` del BLoC de autenticación |
| `http` | `^1.1.0` | `1.6.0` | Cliente HTTP contra la API REST |
| `shared_preferences` | `^2.5.4` | `2.5.4` | Persistencia local del token |
| `intl` | `^0.20.2` | `0.20.2` | Formateo de fechas |
| `flutter_map` | `^6.1.0` | `6.2.1` | Renderizado de mapas |
| `latlong2` | `^0.9.1` | `0.9.1` | Manejo de coordenadas |
| `geolocator` | `^10.1.0` | `10.1.1` | Acceso a la ubicación del dispositivo |
| `flutter_test` | SDK (desarrollo) | — | Pruebas de widgets |

Servicio externo: **OpenStreetMap** como proveedor de mosaicos cartográficos.

### Versiones del SDK

Este es un proyecto legacy y conviene distinguir tres niveles distintos de versionado:

| Nivel | Fuente | Valor |
|---|---|---|
| Mínimo declarado por el proyecto | `pubspec.yaml` | `sdk: ">=2.12.0 <4.0.0"`, `flutter: ">=2.0.0"` |
| Resuelto por las dependencias actuales | `pubspec.lock` | `dart >=3.9.0 <4.0.0`, `flutter >=3.35.0` |
| Configuración nativa de Android | `android/app/build.gradle` | Java 17, `compileSdk` y `targetSdk` 36 |

El `pubspec.yaml` declara compatibilidad desde Flutter 2.0 y Dart 2.12, mientras que el conjunto de dependencias efectivamente bloqueado requiere versiones considerablemente más altas. Ambos valores forman parte del estado actual del repositorio.

`.metadata` registra el canal `beta` y no contiene sección `platforms:`, por corresponder al formato anterior de ese archivo.

---

## 📦 Requisitos previos

- [Git](https://git-scm.com/downloads)
- [Flutter SDK](https://docs.flutter.dev/get-started/install) con su Dart SDK incluido
- **Android SDK** con la plataforma correspondiente a `compileSdk 36`, para ejecutar en Android
- **JDK 17**, acorde a la compatibilidad Java declarada en la configuración de Gradle
- Un emulador de Android o un dispositivo físico con depuración USB habilitada
- Un navegador, para ejecutar la aplicación en Flutter Web
- Conectividad con el backend en Railway

Para ejecutar o compilar la versión iOS se requiere además macOS con Xcode y CocoaPods, dado que el repositorio no versiona el `Podfile`.

Verificación del entorno:

```bash
flutter --version
flutter doctor -v
```

---

## 💻 Entorno de desarrollo

El proyecto se mantiene principalmente con **IntelliJ IDEA**, que es también el origen de la configuración de `.idea/` presente en el repositorio.

- **IntelliJ IDEA** — IDE utilizado para el mantenimiento del proyecto.
- **Flutter SDK / Dart SDK** — desarrollo, análisis y compilación.
- **Android SDK** — compilación y ejecución en Android.
- **JDK 17** — compilación de la parte nativa de Android.

El uso de IntelliJ IDEA es el entorno recomendado por consistencia con el proyecto, no un requisito: cualquier editor con soporte para Flutter permite trabajar sobre el repositorio.

---

## 🚀 Instalación

### 1. Clonar el repositorio

```bash
git clone https://github.com/dgomezrocket/covid19-app.git
cd covid19-app
```

### 2. Descargar las dependencias

```bash
flutter pub get
```

### 3. Verificar el entorno y los dispositivos

```bash
flutter doctor
flutter devices
```

No se requiere ningún paso adicional de configuración: la URL del backend ya está definida en `lib/src/utils/config.dart` y el proyecto no utiliza archivos de entorno.

---

## 🏃 Ejecución

```bash
flutter run
```

Para seleccionar un dispositivo concreto entre los que informa `flutter devices`:

```bash
flutter run -d <id-del-dispositivo>
```

Ejecución en un navegador:

```bash
flutter run -d chrome
```

Durante la sesión de `flutter run`:

| Tecla | Acción |
|---|---|
| `r` | Hot reload |
| `R` | Hot restart |
| `q` | Finalizar la ejecución |

Si es necesario descartar artefactos previos:

```bash
flutter clean
flutter pub get
```

---

## 📦 Builds

Compilación de la versión web, sobre la configuración presente en `web/`:

```bash
flutter build web
```

El resultado se genera en `build/web/`.

> [!NOTE]
> `web/index.html` no declara una etiqueta `<base href>`, por lo que la salida está preparada para servirse desde la raíz del dominio.

---

## 📂 Estructura del proyecto

```text
covid19-app/
├── android/                          # Configuración nativa de Android
│   ├── app/
│   │   ├── build.gradle
│   │   └── src/main/
│   │       ├── AndroidManifest.xml
│   │       └── kotlin/.../MainActivity.kt
│   ├── build.gradle
│   ├── settings.gradle
│   └── gradle.properties
│
├── ios/                              # Proyecto Xcode
│   ├── Runner/
│   │   ├── AppDelegate.swift
│   │   └── Info.plist
│   └── Runner.xcodeproj/
│
├── web/                              # Configuración de Flutter Web
│   ├── index.html
│   ├── manifest.json
│   └── icons/
│
├── lib/
│   ├── main.dart                     # Punto de entrada
│   └── src/
│       ├── app.dart                  # MaterialApp, rutas y pantalla inicial
│       ├── blocs/
│       │   └── form_bloc.dart         # BLoC de login y registro (rxdart)
│       ├── mixins/
│       │   ├── helper.dart            # Widget de mensaje de error
│       │   └── validation_mixin.dart  # Validadores de correo y contraseña
│       ├── models/                    # Modelos del dominio (17 archivos)
│       ├── options/                   # Widgets de ítems, respuestas y mensajes
│       ├── pages/
│       │   ├── profile_page.dart       # Módulo Datos
│       │   ├── forms_page.dart         # Módulo Formularios
│       │   ├── form_page.dart          # Resolución de un formulario
│       │   ├── answers_page.dart       # Módulo Respuestas
│       │   ├── map_page.dart           # Módulo Hospitales
│       │   ├── livemap_location.dart   # Captura de la ubicación
│       │   ├── message_page.dart       # Módulo Mensajes
│       │   └── other_map.dart          # Mapa con coordenadas fijas
│       ├── providers/
│       │   ├── provider.dart           # InheritedWidget propio
│       │   └── profile_provider.dart   # Singleton de acceso a datos
│       ├── screens/
│       │   ├── home_screen.dart        # Contenedor y barra de navegación
│       │   ├── login_screen.dart
│       │   ├── signup_screen.dart
│       │   └── forgot_password.dart
│       ├── services/
│       │   ├── auth_service.dart       # Registro, login y token
│       │   └── person_service.dart     # Operaciones autenticadas
│       └── utils/
│           ├── config.dart             # URL base del backend
│           ├── routes.dart             # Rutas nombradas
│           ├── functions_utils.dart
│           ├── styles_options.dart
│           ├── util_classes.dart
│           ├── util_constants.dart
│           └── widgets.dart
│
├── test/
│   └── widget_test.dart
├── .metadata
├── pubspec.yaml
├── pubspec.lock
└── README.md
```

---

## 🌍 Internacionalización

`lib/src/app.dart` declara los delegados de localización de Flutter y dos locales admitidos:

```text
localizationsDelegates: [
  GlobalMaterialLocalizations.delegate,
  GlobalWidgetsLocalizations.delegate,
  GlobalCupertinoLocalizations.delegate,
],
supportedLocales: [
  const Locale('en', 'US'),
  const Locale('es', 'ES'),
],
```

Es importante distinguir dos alcances distintos:

| Alcance | Estado |
|---|---|
| Componentes propios de Flutter (selectores de fecha, botones del sistema, widgets Material y Cupertino) | Localizados mediante los delegados y los locales declarados |
| Textos propios de la aplicación | **No** están internacionalizados |

El proyecto **no** contiene archivos ARB, no utiliza `flutter gen-l10n` y no genera una clase de localizaciones. Los textos de la interfaz están escritos de forma literal en el código, en español, con la excepción del texto `Forgot password` de la pantalla `/forgot_password` y de las descripciones de permisos de iOS, que están en inglés.

El paquete `intl` se emplea para el formateo de fechas (`dd/MM/yyyy` y `dd/MM/yyyy – kk:mm`) y para indicar el locale `es_ES` en el selector de fecha.

---

## 🧪 Pruebas

El directorio `test/` contiene un único archivo, `test/widget_test.dart`.

Ese archivo es el smoke test que genera `flutter create`, adaptado solamente para importar y montar `App()`. Sus aserciones corresponden a la aplicación de contador de la plantilla: verifican los textos `0` y `1` y un icono `Icons.add`, elementos que la interfaz de CroniApp no contiene.

El repositorio no incluye `analysis_options.yaml` ni el paquete `flutter_lints`, por lo que `flutter analyze` se ejecuta con el conjunto de reglas predeterminado. Tampoco hay pruebas de integración ni configuración de integración continua.

```bash
flutter test
flutter analyze
```

---

## 🤝 Contribución

1. Realizá un fork del repositorio y creá una rama descriptiva.
2. Mantené el estilo del código con `dart format .`.
3. Verificá el proyecto con `flutter analyze` antes de publicar los cambios.
4. Abrí un Pull Request hacia `master` describiendo el cambio y cómo se verificó.

Los reportes de errores y las consultas pueden canalizarse por [Issues](https://github.com/dgomezrocket/covid19-app/issues).

---

## 🔗 Proyectos relacionados

### 🔧 Backend — `backend-core-covid19`

API REST desarrollada con Spring Boot que CroniApp consume, sobre una base de datos PostgreSQL.

- **Repositorio:** [github.com/dgomezrocket/backend-core-covid19](https://github.com/dgomezrocket/backend-core-covid19)
- **Producción:** [backend-core-covid19-production.up.railway.app](https://backend-core-covid19-production.up.railway.app)

### 🌐 Frontend Web — `covid19-web-old`

Frontend web React de esta misma versión legacy del sistema.

- **Repositorio:** [github.com/dgomezrocket/covid19-web-old](https://github.com/dgomezrocket/covid19-web-old)
- **Producción:** [old.saludenmapa.com](https://old.saludenmapa.com/)

---

## 👥 Autores

| Autor | Participación |
|---|---|
| **Jesús Aguilar** | Desarrollo inicial |
| **Derlis Gómez** | Adecuaciones, mantenimiento y mejoras |

---

## 👤 Autor y contacto

**Derlis Gómez** — Adecuaciones, mantenimiento y mejoras del proyecto.

[![LinkedIn](https://img.shields.io/badge/LinkedIn-Derlis%20Gómez-0A66C2?logo=linkedin&logoColor=white)](https://www.linkedin.com/in/derlisgomez/)
[![GitHub](https://img.shields.io/badge/GitHub-dgomezrocket-181717?logo=github&logoColor=white)](https://github.com/dgomezrocket)
[![Email](https://img.shields.io/badge/Email-derlisrgomez@gmail.com-EA4335?logo=gmail&logoColor=white)](mailto:derlisrgomez@gmail.com)

- 💼 **LinkedIn:** [linkedin.com/in/derlisgomez](https://www.linkedin.com/in/derlisgomez/)
- 🐙 **GitHub:** [github.com/dgomezrocket](https://github.com/dgomezrocket)
- 📧 **Email:** derlisrgomez@gmail.com

Para reportar un problema o sugerir una mejora, podés utilizar la sección **Issues** del repositorio.
