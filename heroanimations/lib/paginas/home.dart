import 'package:flutter/material.dart';
import 'dart:math';

class Home extends StatefulWidget {
  final String title;
  Home({this.title = 'Casas disponibles'});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var imagesVisible = true;
  var listadoCards = [];

  @override
  void initState() {
    var rng = Random();
    var tag = 0;

    //for para cantidad de imagenes
    for (var i = 0; i < 5; i++) {
      var imagen = AssetImage("assets/img/casa-${(i)}.jpg");
      var subtitulo ='${(rng.nextInt(3) + 1).toString()} Habitaciones, ${(rng.nextInt(2) + 1).toString()} Baños';
      var descripcion = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur ex velit, molestie a mi eget.';
      var titulo = '\$${(rng.nextInt(20) + 15).toString()}0 al mes';
      var informacionCard = {
        'titulo': titulo,
        'subtitulo': subtitulo,
        'imagen': imagen,
        'descripcion': descripcion,
        'tag': (tag++).toString(),
      };
      listadoCards.add(informacionCard);
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.teal,
            title: Text(widget.title),
            actions: [
              Switch(
                value: imagesVisible,
                activeColor: Colors.tealAccent,
                onChanged: (bool switchState) {
                  setState(() {
                    imagesVisible = switchState;
                  });
                },
              ),
            ]),
        body: bodyApp());
  }

  Container bodyApp() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children:
                listadoCards.map((informacionCard) => constructorCard(informacionCard)).toList(),
          )),
    );
  }

  Card constructorCard(Map<String, dynamic> informacionCard) {
    var image = Ink.image(
      image: informacionCard['imagen']!,
      fit: BoxFit.cover,
    );
    return Card(
        elevation: 4.0,
        child: GestureDetector(
          onTap: () => {
            Navigator.push(
              context,
              MaterialPageRoute<void>(
                builder: (BuildContext context) => DetalleCasa(
                  imagenCasa: image,
                  tag: informacionCard['tag'],
                  informacionCard: informacionCard,
                ),
              ),
            )
          },
          child: Column(
            children: [
              ListTile(
                title: Text(informacionCard['titulo']!),
                subtitle: Text(informacionCard['subtitulo']!),
                trailing: const Icon(Icons.star),
              ),
              Visibility(
                visible: imagesVisible,
                child: Container(
                  height: 200.0,
                  child: Hero(
                    tag: informacionCard['tag'],
                    child: Material(child: image),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(12.0),
                alignment: Alignment.centerLeft,
                child: Text(informacionCard['descripcion']!),
              ),
              ButtonBar(
                children: [
                  TextButton(
                    child: const Text('Agendar cita'),
                    onPressed: () {

                    },
                  ),
                ],
              )
            ],
          ),
        ));
  }
}

class DetalleCasa extends StatelessWidget {
  final Widget imagenCasa;
  final String tag;
  final Map<String, dynamic> informacionCard;

  const DetalleCasa(
      {Key? key,
      required this.imagenCasa,
      required this.tag,
      required this.informacionCard})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text('Descripcion'),
      ),
      body: vistaDescripcion(),
    );
  }

  vistaDescripcion() {
    return Column(children: [
      Container(
        height: 300.0,
        child: Hero(
          tag: tag,
          child: Material(child: imagenCasa),
        ),
      ),
      ListTile(
        title: Text(informacionCard['titulo']!),
        subtitle: Text(informacionCard['subtitulo']!),
        trailing: Icon(Icons.favorite_outline),
      ),
      Container(
        padding: EdgeInsets.all(16.0),
        alignment: Alignment.centerLeft,
        child: Text(informacionCard['descripcion']!),
      ),
    ]);
  }
}
