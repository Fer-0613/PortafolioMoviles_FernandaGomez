# Análisis de Datos con Dart

## 🎯 1. Objetivo del proyecto
[cite_start]Construir una aplicación de consola en Dart que cargue, procese y analice datos almacenados en formato JSON utilizando estructuras de control, funciones y clases de programación orientada a objetos[cite: 778, 779, 780].

## 🧩 2. Problema que resuelve 
[cite_start]Permite leer de forma automática archivos físicos de datos (`datos.json`) que contienen registros con información opcional o nula (Null Safety), procesando y ordenando la información para realizar búsquedas rápidas y evitar errores de ejecución en el sistema[cite: 782, 783, 831, 832, 981].

## 🛠️ 3. Tecnologías utilizadas 
* [cite_start]**Lenguaje:** Dart [cite: 768]
* [cite_start]**Librerías nativas:** `dart:io` (Lectura y escritura de archivos físicos) y `dart:convert` (Decodificación de formato JSON)[cite: 823, 827, 828, 942, 943].

## 🧠 4. Conceptos aplicados 
* [cite_start]Modelado de datos mediante clases, constructores y métodos encapsulados (Getters)[cite: 829, 832, 834].
* [cite_start]Control de valores nulos utilizando el operador de asignación por defecto (`??`)[cite: 833, 835].
* [cite_start]Iteración y filtrado de colecciones dinámicas mediante ciclos `for`, condicionales `if` y manejo de diccionarios (`Map`)[cite: 841, 846, 863, 941, 947].
* [cite_start]Menús interactivos de consola utilizando estructuras de control cíclicas `while` y de selección `switch`[cite: 994, 995, 1038].

## 📱 5. Capturas de pantalla 
![Menu Consola](./capturas/mostrar_todos_registros.png)
![Reporte Consola](./capturas/reporte_consola.png)
![Reporte JSON](./capturas/reporte_JSON.png)

## 🚀 6. Instrucciones de ejecución
1. Asegurarse de tener instalado el SDK de Dart.
2. Abrir la terminal de comandos dentro de esta carpeta.
3. [cite_start]Ejecutar la aplicación con el comando: `dart analizar.dart`[cite: 1068].

## 💬 7. Reflexión personal
* [cite_start]**¿Qué aprendí?:** Aprendí a manipular archivos físicos e interpretar el formato JSON desde una aplicación de consola, además de la importancia de proteger el código contra valores nulos con Null Safety[cite: 779, 827, 828, 831, 835].
* [cite_start]**¿Qué fue difícil?:** Lo más complejo fue estructurar correctamente la lógica del cálculo matemático para las edades mínimas y máximas dentro del ciclo de lectura sin que se rompiera el flujo[cite: 897, 898, 916].
* [cite_start]**¿Qué mejoraría?:** En lugar de una interfaz de consola pura, mejoraría el proyecto adaptándole una interfaz gráfica móvil para desplegar las estadísticas en tarjetas visuales de Flutter[cite: 894, 931].
