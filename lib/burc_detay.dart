import 'package:flutter/material.dart';
import 'package:burc_rehberi/models/burc.dart';
import 'package:burc_rehberi/burc_liste.dart';
import 'package:palette_generator/palette_generator.dart';
class BurcDetay extends StatefulWidget {
  int _index;
  BurcDetay(this._index);

  @override
  _BurcDetayState createState() => _BurcDetayState();
}

class _BurcDetayState extends State<BurcDetay> {
  Burc secilenBurc;
  Color baskinrenk;
  PaletteGenerator paletteGenerator;

  @override
  void initState() {
    super.initState();
    secilenBurc = BurcListesi.tumBurclar[widget._index];
    baskinRengiBul();
  }

  void baskinRengiBul(){
    Future<PaletteGenerator> fPaletGenerator = PaletteGenerator
        .fromImageProvider(AssetImage("images/" + secilenBurc.burcBuyukResim));

    fPaletGenerator.then((value) {
      paletteGenerator = value;

      setState(() {
        baskinrenk = paletteGenerator.dominantColor.color;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: CustomScrollView(
        primary: false,
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 250,
            backgroundColor: baskinrenk != null ? baskinrenk : Colors.pink,
            pinned: true,
            primary: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(secilenBurc.burcAdi + " Burcu ve Özellikleri"),
              background: Image.asset("images/"+secilenBurc.burcBuyukResim, fit: BoxFit.cover,),
              centerTitle: true,
            ),

          ),

          SliverToBoxAdapter(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(secilenBurc.burcDetayi, style: TextStyle(fontSize: 18, color: Colors.black),),
              ),
            ),
          ),

        ],
      ),

    );
  }
}
