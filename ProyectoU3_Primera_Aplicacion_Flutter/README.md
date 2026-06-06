# Mi Primera Aplicación de Flutter 

## 🎯 1. Objetivo del proyecto
[cite_start]Aplicar los conceptos fundamentales de Flutter y Dart para concebir una aplicación móvil responsiva capaz de generar pares de palabras aleatorias y gestionar un estado interactivo local[cite: 218, 229, 755, 757].

## 🧩 2. Problema que resuelve 
[cite_start]Suministra una interfaz de usuario fluida e interactiva que soluciona la gestión de estados globales, permitiendo al usuario guardar o eliminar favoritos en tiempo real sin perder la consistencia visual del diseño[cite: 456, 459, 462, 756].

## 🛠️ 3. Tecnologías utilizadas 
* [cite_start]**Framework:** Flutter SDK [cite: 218, 229]
* [cite_start]**Lenguaje:** Dart [cite: 755]
* [cite_start]**Paquetes externos:** `english_words` (para la creación de palabras) y `provider` (para la administración del estado reactivo)[cite: 294].

## 🧠 4. Conceptos aplicados 
* [cite_start]Arquitectura basada en widgets con y sin estado (`StatefulWidget` / `StatelessWidget`)[cite: 414, 434, 499, 500, 565].
* [cite_start]Gestión de estados reactivos utilizando `ChangeNotifier`, `context.watch` y notificación de escuchas (`notifyListeners`)[cite: 416, 455, 457, 461, 557].
* [cite_start]Diseño responsivo adaptado mediante `LayoutBuilder` para modificar la UI (riel de navegación expandido o compacto) según el ancho de pantalla[cite: 507, 508, 509, 523, 757].
* [cite_start]Estilos globales, listas dinámicas con colecciones de flujo (`for` dentro de listas) y accesibilidad con `semanticsLabel`[cite: 419, 441, 611, 651].

## 📱 5. Capturas de pantalla 
![Interfaz Principal](./capturas/interfaz_principal.png)
![Interfaz Favoritos](./capturas/interfaz_favoritos_con_fav.png)
![Cambio de tamaño](./capturas/cambio_tamaño_pantalla.png)

## 🚀 6. Instrucciones de ejecución
1. [cite_start]Ejecutar el comando `flutter pub get` en la terminal para instalar las dependencias[cite: 294].
2. [cite_start]Asegurarse de tener un emulador activo o dispositivo seleccionado[cite: 364, 365].
3. [cite_start]Correr el proyecto con el comando: `flutter run`[cite: 364, 380].

## 💬 7. Reflexión personal
* [cite_start]**¿Qué aprendí?:** Comprendí cómo funciona la programación declarativa en Flutter, el árbol de widgets y la importancia de separar la lógica de negocio usando el patrón Provider[cite: 294, 398, 416].
* [cite_start]**¿Qué fue difícil?:** Lo más complicado al principio fue entender la transición entre un widget estático y uno con estado para lograr que el menú lateral reaccionara al clic[cite: 499, 500, 510].
* [cite_start]**¿Qué mejoraría?:** Agregarle persistencia de datos local (como SQLite o Shared Preferences) para que las palabras marcadas como favoritas no se borren al cerrar por completo la aplicación[cite: 459].
