import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:yanapay_app/src/ui/widgets/post.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
  bool emergencyActivated = false;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Yanapay",
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontWeight: FontWeight.bold
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          Container(
            height: 75,
            width: 75,
            child: Image.asset("assets/images/yanapay-logo.png"),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          top: 18,
        ),
        child: ListView(
          children: [
            Post(),
            const SizedBox(height: 10),
            Post(
              mProfileImage: "https://z-p3-scontent.flpb2-1.fna.fbcdn.net/v/t1.0-9/59615867_2031559946969845_8598453715466190848_o.jpg?_nc_cat=108&ccb=1-3&_nc_sid=174925&_nc_ohc=mRvQbYmZ1asAX_8AJPw&_nc_ht=z-p3-scontent.flpb2-1.fna&oh=6d05f9fa53d20beefc1fa6b1ef9f1a5d&oe=607AB8C4",
              mPostImage: "https://i0.wp.com/acolita.com/wp-content/uploads/2012/04/incendios-forestales11.jpg?fit=533%2C400&ssl=1",
              mName: "Karol Catacora",
              mDescription: "Por favor ayuda!!! El bosquecillo de Pura Pura se está incendiando",
            ),
            const SizedBox(height: 10),
            Post(
              mDescription: "La luminaria de mi calle no está funcionando correctamente, Calle Alvarez Plata #1191",
              mPostImage: "https://upload.wikimedia.org/wikipedia/commons/c/c1/2014-10-31_17_48_17_Recently_activated_sodium_vapor_street_light_along_Terrace_Boulevard_in_Ewing%2C_New_Jersey.JPG",
            ),
            const SizedBox(height: 10),
            Post(
              mProfileImage: "https://z-p3-scontent.flpb2-1.fna.fbcdn.net/v/t1.0-9/59615867_2031559946969845_8598453715466190848_o.jpg?_nc_cat=108&ccb=1-3&_nc_sid=174925&_nc_ohc=mRvQbYmZ1asAX_8AJPw&_nc_ht=z-p3-scontent.flpb2-1.fna&oh=6d05f9fa53d20beefc1fa6b1ef9f1a5d&oe=607AB8C4",
              mName: "Karol Catacora",
              mDescription: "Están loteando tierras en la zona de mi tía, pido ayuda por favor! Son Areas Verdes, Zona Alto Sopocachi",
              mPostImage: "https://www.eldiario.net/noticias/2019/2019_02/nt190217/f_2019-02-17_66.jpg",
            )
          ]
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AnimatedOpacity(
            opacity: emergencyActivated ? 1.0 : 0.0,
            duration: const Duration(seconds: 1),
            child: Container(
              margin: const EdgeInsets.only(left: 12),
              child: Column(
                children: [
                  FloatingActionButton(
                    heroTag: "violence-tag",
                    backgroundColor: Colors.red,
                    child: Icon(Icons.warning_amber_outlined),
                    onPressed: () {
                      Flushbar(
                        message: "Se avisó de violencia correctamente",
                        backgroundColor: Colors.red,
                        duration: const Duration(milliseconds: 2500),
                      ).show(context);
                    },
                  ),
                  const SizedBox(height: 4),
                  FloatingActionButton(
                    heroTag: "fire-tag",
                    backgroundColor: Colors.orange,
                    child: Icon(Icons.fireplace),
                    onPressed: () {
                      Flushbar(
                        message: "Se aviso del incendio correctamente",
                        backgroundColor: Colors.orange,
                        duration: const Duration(milliseconds: 2500),
                      ).show(context);
                    },
                  ),
                  const SizedBox(height: 4),
                  FloatingActionButton(
                    heroTag: "medical-tag",
                    child: Icon(Icons.local_hospital),
                    backgroundColor: Colors.redAccent,
                    onPressed: () {
                      Flushbar(
                        message: "Se avisó emergencia médica correctamnte",
                        backgroundColor: Colors.redAccent,
                        duration: const Duration(milliseconds: 2500),
                      ).show(context);
                    },
                  ),
                  const SizedBox(height: 4)
                ],
              ),
            )
          ),
          Row(
            children: [
              const SizedBox(width: 12),
              FloatingActionButton(
                heroTag: "warning-tag",
                child: Icon(Icons.warning),
                onPressed: () {
                  setState(() {
                    emergencyActivated = !emergencyActivated;
                  });
                },
              ),
              Spacer(),
              FloatingActionButton(
                heroTag: "post-tag",
                child: Icon(Icons.edit),
                onPressed: () {
                
                },
              ),
              const SizedBox(width: 12)
            ],
          ),
        ],
      )
    );
  }
}