# Mini Reproductor de Musica 

## 🎯 1. Objetivo del proyecto
Desarrollar un reproductor de música móvil temático y totalmente interactivo utilizando herramientas multimedia nativas de Flutter para el control y enlace secuencial de archivos de sonido locales.

## 🧩 2. Problema que resuelve 
Proporciona una solución multimedia autónoma capaz de procesar listas de reproducción reales sin bloqueos de memoria, automatizando el salto de canciones al concluir el tiempo y ofreciendo una experiencia inmersiva mediante respuestas visuales en tiempo real.

## 🛠️ 3. Tecnologías utilizadas 
* **Entorno:** Flutter SDK & Dart.
* **Paquetes multimedia:** `just_audio` (gestión del motor de sonido nativo) y `rxdart` (combinación avanzada de flujos de progreso).
* **Diseño:** `google_fonts` (Tipografía manuscrita estilizada para el AppBar).

## 🧠 4. Conceptos aplicados 
* Control de hilos multimedia y asincronía mediante Streams (`playerStateStream` y `positionStream`).
* Ciclo de vida estricto del widget inicializando y destruyendo procesos en memoria (`initState` y `dispose`).
* Animaciones fluidas continuas controladas matemáticamente por el reloj del sistema (`AnimationController` y `RotationTransition`).
* Diseño visual avanzado utilizando interfaces con degradados de color (`LinearGradient`), sombras neón (`BoxShadow`) y atenuaciones modernas (`withValues`).

## 📱 5. Capturas de pantalla 
![Cancion 1](./capturas/cancion1.jpeg)
![Cancion 2](./capturas/cancion2.jpeg)
![Cancion 3](./capturas/cancion3.jpeg)

## 🚀 6. Instrucciones de ejecución
1. Descargar las dependencias ejecutando `flutter pub get` en la terminal.
2. Verificar que los archivos multimedia estén debidamente registrados en el `pubspec.yaml`.
3. Conectar un dispositivo y compilar la app con el comando: `flutter run`.

## 💬 7. Reflexión personal
* **¿Qué aprendí?:** Fue mi práctica favorita; aprendí a manipular recursos multimedia reales, coordinar animaciones con lógica asíncrona y utilizar el analizador de código para resolver advertencias de deprecación como el uso de `.withValues()`.
* **¿Qué fue difícil?:** Lo más complicado fue lograr que el disco se detuviera de manera exacta en su ángulo actual al poner pausa y que se enlazara la playlist de forma automática al terminar la pista.
* **¿Qué mejoraría?:** Me gustaría implementar una barra de búsqueda de canciones dentro de la playlist y permitir la carga de archivos de audio externos descargados directamente de internet.
