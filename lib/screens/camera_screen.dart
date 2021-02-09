import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:forum/screens/picture_screen.dart';
import 'package:forum/constants.dart';

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
    _cameraController = CameraController(widget.camera, ResolutionPreset.high);

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
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text('envia una foto' , style: kPhotoAppBarTextStyle,),
        leading: Container(
          padding: EdgeInsets.all(5.0),
          child: Image.asset('images/logo.png'),
        ),
        actions: [
          FlatButton(
            onPressed: () => Navigator.pop(context),
            child: Icon(
              Icons.clear,
              color: Colors.white,
            ),
          )
        ],
      ),

      // esperamos hasta que el controlador esté inicializado antes de mostrar
      // la vista de cámara , para ello usamos un FutureBuilder
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          final size = MediaQuery.of(context).size;
          final deviceRatio = size.width / size.height;

          if (snapshot.connectionState == ConnectionState.done) {
            return Container(
              child: Center(child: CameraPreview(_cameraController)),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      floatingActionButton: Align(
        alignment: Alignment.bottomCenter,
        child: FloatingActionButton(
          child: Icon(Icons.camera_rounded),
          onPressed: () async {
            // Intentamos tomar una foto

            try {
              //nos aseguramos que el controlador este inicializado (esperamos a este future)
              await _initializeControllerFuture;

              // intento de guardar la imagen
              XFile file = await _cameraController.takePicture();

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PictureScreen(imagePath: file.path,)
                ),
              );
            } catch (e) {}
          },
        ),
      ),
    );
  }
}
