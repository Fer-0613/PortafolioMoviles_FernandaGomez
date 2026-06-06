//importar librerias
import 'dart:io'; //ayuda para poder leer el archivo jason
import 'dart:convert'; //ayuda para usar jasonDecode

class Registro{
  //propiedades privadas y null saftey (operador ??) 
  String? _nombre; //el nombre puede ser ingresado o no 
  String _apellido;
  int _edad;
  double? _salario; //si no ingresa el salario se le asignara el salario minimo 
  
  //constructor, aqui se le asignan los valores por defecto que tendran 
  //las propiedades nulas 
  Registro(String? nombre, this._apellido, this._edad, double? salario)
    : _nombre = nombre ?? "Usuario",
      _salario = salario ?? 10000.00;
  
  //getters para tener acceso a las propiedades privadas
  String? get nombre => _nombre;
  String get apellido => _apellido;
  int get edad => _edad;
  double? get salario => _salario;

}

//funcion para poder buscar el registro por nombre 
//recibe la lista de los registros (objetos - main) y lo que debe de buscar
void buscarUsuario(List<Registro> registros, String nombreBusqueda){
  bool encontrado = false; //se verifica si hubo alguna coincidencia 

  //se utiliza un ciclo for para recorrer la lista
  for (var r in registros){
    //se especifica que  el nombre no es nulo en esta busqueda y da como resultado su informacion
    if (r.nombre!.toLowerCase() == nombreBusqueda.toLowerCase()) {
      print("Resultado: ${r.nombre} ${r.apellido}, Edad: ${r.edad}, Salario: ${r.salario}");
      encontrado = true;
    }
  }

  //al no encontrar el nombre, notifica con un mensaje
  if (!encontrado) print("Usuario no identificado.");
}

//funcion para poder filtrar por salario
//recibe la lista de los registros (objetos - main) y el valor del sueldo a comparar
void filtrarSalario(List<Registro> registros, double sueldoMin){
  print("\n--- Usuarios con salario mayor a ${sueldoMin} ---");
  bool resultadosSalario = false; //verifica si hubo alguna coincidencia de sueldo a comparar

  //se utiliza el ciclo for para recorrer la lista y comparar los sueldos aun si es nulo "?? 0"
  for (var r in registros){
    if((r.salario ?? 0) >= sueldoMin){
      print("${r.nombre} ${r.apellido} - Salario: ${r.salario}");
      resultadosSalario = true;
    }
  }

  //si no existe un registro de esa cantidad se indica con un menseje 
  if(!resultadosSalario) print("No hay registros con ese salario");
}

//se crea la funcion para poder realizar las estadisticas
//recibe la lista para realizar los calculos 
void estadisticas(List<Registro> registros){
  //se valida que haya datos para no procesar una lista vacia 
  if (registros.isEmpty){
    print("No hay datos que analizar");
    return;
  }

  //se inicializan las variables a utilizar 
  //sumar los sueldos para el promedio 
  //obtener la edad minima y la edad maxima que hay en el registro
  double sumaSalarios = 0;
  int edadMax = registros[0].edad;
  int edadMin = registros[0].edad;

  //con el ciclo for se recorre la lista
  for (var r in registros){
    //se suman todos los salarios 
    sumaSalarios += r.salario ?? 0;

    //con la condicional if se compara las edades para saber cual es mayor y menor
    if (r.edad > edadMax) edadMax = r.edad;
    if (r.edad < edadMin) edadMin = r.edad;
  }

  //se calcula el promedio salarial de acuerdo al valor de la suma y a la cantidad de registros
  double promedio = sumaSalarios / registros.length;

  print("\n--- ESTADÍSTICAS ---");
  print("1. Cantidad total de registros: ${registros.length}");
  print("2. Promedio de salarios: \$${promedio.toStringAsFixed(2)}");
  print("3. Rango de edades: Desde los $edadMin hasta los $edadMax años");

  //se llama a la funcion de generar reporte para poder exportar esta informacion en una rchivo JSON
  generarReporte(promedio, edadMax, edadMin, registros.length);
}

//se crea la funcion para poder generar los reportes json
//recibe la informacion que debe mostrar
void generarReporte(double promedio, int max, int min, int total){
  //se utiliza la estructura de datos "Map" (diccionario)
  //organiza la informacion en pares "llave-valor"
  Map<String, dynamic> reporte = {
    "total_registros": total,
    "promedio_salarial": promedio,
    "edad_maxima": max,
    "edad_minima": min,
    //se utiliza para registrar la hora en que se realizo el reporte
    "fecha_reporte": DateTime.now().toString() 
  };

  //se utiliza la libreria dart:convert para transformar el diccionario en JSON
  String jsonTexto = jsonEncode(reporte);

  //se utiliza la libreria dart:io para crear y escribir el archivo de manera fisica
  //con el metodo writeAsStringSync se asegura que el archivo pueda guardarse antes de continuar
  File('reporte_estadisticas.json').writeAsStringSync(jsonTexto);

  print("\n¡El reporte fue exportado exitosamente como 'reporte_estadisticas.json'!");
}

void main(){
  //leera el archivo json con los datos 
  String contenido = File('datos.json').readAsStringSync();

  //se convierte el jason en una lista
  List<dynamic> datosJson = jsonDecode(contenido);

  //se crea la lista de los registros del json
  List<Registro> listaRegistros = [];

  //se utiliza el ciclo for para convertir el contenido en un objeto
  for (var item in datosJson){
    listaRegistros.add(Registro(item['nombre'], item["apellido"], item['edad'], item['salario']));
  }

  //se crea el menu donde se podra elegir que hacer 
  //el menu se crea utilizando el ciclo while y switch
  while (true){
    print("\n--- ANALISIS DE DATOS ---");
    print("1. Mostrar todos los registros");
    print("2. Buscar usuario por NOMBRE");
    print("3. Filtrar por SALARIO MINIMO");
    print("4. Ver estadísticas y Generar reporte");
    print("5. Salir");
    stdout.write("Seleccione una opcion: ");
    String? opcion = stdin.readLineSync(); //se ingresa el numero de la opcion

    //con un switch, de acuerdo a la opcion que elija realizara su correspondiente actividad
    switch (opcion) {
      //muestra los todos los registros 
      case '1':
        for (var r in listaRegistros){
          print("${r.nombre} ${r.apellido} - Edad: ${r.edad} - Salario: ${r.salario}");
        }
        break;
      //se busca el registro de acuerdo al nombre
      case '2':
        stdout.write("Ingrese el NOMBRE a buscar: ");
        String? nombre = stdin.readLineSync();
        buscarUsuario(listaRegistros, nombre ?? "");
        break;
      //se utiliza el filtro del sueldo 
      case '3':
        stdout.write("Ingrese el salario mínimo para filtrar: ");
        String? entrada = stdin.readLineSync();

        double filtro = double.tryParse(entrada ?? "") ?? 0.0;
        filtrarSalario(listaRegistros, filtro);
      //muestra y genera el reporte de las estadisticas
      case '4':
        estadisticas(listaRegistros);
        break;
      //sale de la aplicacion 
      case '5':
        print("Saliendo del programa, Bonito dia!");
        return;
      //en caso de ingresar una opcion incorrecta 
      default:
        print("Opción no válida");
    }
  }

}