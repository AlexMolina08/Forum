import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:forum/screens/picture_screen.dart';
import 'package:path/path.dart' show join;
import 'package:path_provider/path_provider.dart';

/*
*
* Pantalla que te permite tomar una foto usando la camara especificada
*
* */
/*
*
* Pantalla que te permite tomar una foto usando la camara especificada
*
* */
class CameraScreen extends StatefulWidget {
  static const String routeID = '/camera';
  final CameraDescription camera; // camara que vamos a utilizar
  CameraScreen({@required this.camera});

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  CameraController _cameraController; //controlador de la cámara
  Future<void>
      _initializeControllerFuture; // para almacenar el future que devuelve _cameraController.initialize

  @override
  void initState() {
    super.initState();

    // inicializamos el controlador (le decimos la cámara que tiene que usar y la resolucion)
    _cameraController =
        CameraController(widget.camera, ResolutionPreset.medium);

    // guardamos el future de inicializar el controlador de la camara
    _initializeControllerFuture = _cameraController.initialize();
  }

  @override
  void dispose() {
    super.dispose();
    _cameraController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('toma una foto'),
      ),

      // esperamos hasta que el controlador esté inicializado antes de mostrar
      // la vista de cámara , para ello usamos un FutureBuilder
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          FutureBuilder<void>(
            future: _initializeControllerFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done)
                return CameraPreview(_cameraController);
              else
                return Center(
                  child: CircularProgressIndicator(),
                );
            },
          ),
          Expanded(
            child: Container(
              color: NeumorphicTheme.baseColor(context),
              child: FloatingActionButton(
                onPressed: () async {
                  // tomar una foto
                  try {
                    // asegurarse que la camera está inicializada (espera al future)
                    await _initializeControllerFuture;

                    // establecemos el path donde se va a guardar la foto
                    final path = join(
                        // Guardare la foto en /temp
                        // encuentro el /temp usando path_provider
                        (await getTemporaryDirectory()).path,
                        // nombre de la foto (fecha actual)
                        '${DateTime.now()}.png');

                    // INTENTO DE TOMAR UNA FOTO Y GUARDARLA EN PATH
                    XFile file = await _cameraController.takePicture();

                    // Si se ha tomado la foto , que se muestre en otra pantalla
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PictureScreen(
                          imagePath: file.path,
                        ),
                      ),
                    );
                  } catch (e) {
                    print(e);
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
