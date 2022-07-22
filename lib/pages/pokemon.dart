import 'package:flutter/material.dart';
import 'package:pokeapp/pages/config/header.dart';

class Pokemon extends StatefulWidget {
  const Pokemon({super.key});

  @override
  State<Pokemon> createState() => _PokemonState();
}

class _PokemonState extends State<Pokemon> {
  var scaffoldKey = GlobalKey<ScaffoldState>();

  var isLogin = false;

  String page = "pokedex";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: const DefaultAppBar(
        parms: {},
      ),
      drawer: DefaultContainer(parms: {
        'page': page,
        'account': const {'isLogged': false}
      }),
      endDrawer: DefaultDrawer(
        parms: const {},
      ),
      body: Container(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(16, 8, 16, 4),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    const BoxShadow(
                      blurRadius: 4,
                      color: const Color(0x32000000),
                      offset: Offset(0, 2),
                    )
                  ],
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(16, 12, 12, 12),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 136,
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    const BoxShadow(
                      blurRadius: 4,
                      color: Color(0x34090F13),
                      offset: const Offset(0, 2),
                    )
                  ],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(12, 12, 12, 12),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(0),
                        child: Image.network(
                          'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png',
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
                        child: const Text(
                          'bulbizar',
                        ),
                      ),
                      const Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                        child: const Text(
                          'N°1',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(16, 0, 16, 12),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: const Color(0xFFE0E3E7),
                    width: 2,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(12, 12, 12, 12),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Types',
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          const Card(
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            color: Color(0xFF53AC26),
                            child: const Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(5, 2, 5, 2),
                              child: Text(
                                'grass',
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          const Card(
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            color: const Color(0xFF9142D5),
                            child: Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(5, 2, 5, 2),
                              child: Text(
                                'poison',
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Divider(
                        height: 16,
                        thickness: 2,
                        color: Color(0xFFF1F4F8),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          const Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                5, 0, 5, 0),
                            child: Text(
                              'overgrow',
                            ),
                          ),
                          const Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                5, 0, 5, 0),
                            child: Text(
                              'chlorophyll',
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    const BoxShadow(
                      blurRadius: 7,
                      color: Color(0x2F1D2429),
                      offset: const Offset(0, 3),
                    )
                  ],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(16, 12, 16, 12),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Description',
                      ),
                      const Divider(
                        height: 16,
                        thickness: 2,
                        color: const Color(0xFFF1F4F8),
                      ),
                      const Text(
                        'Bulbasaur can be seen napping in bright sunlight. There is a seed on its back.\n\nBy soaking up the sun’s rays, the seed grows progressively larger.While it is young, it uses the nutrients that are stored in the seed on its back in order to grow.',
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
