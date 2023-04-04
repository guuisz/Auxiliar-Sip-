import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MaterialApp(
    home: TabBarDemo(),
  ));
}

class Usuario {
  late String login;
  late String password;
  late String name;
  late String apelido;
  late String areaResponsavel;
  late String dia;

  Usuario(String login, String password, String name, String apelido,
      String areaResponsavel, String dia) {
    this.login = login;
    this.password = password;
    this.name = name;
    this.apelido = apelido;
    this.areaResponsavel = areaResponsavel;
    this.dia = dia;
  }
}

Usuario atualUsuario = new Usuario('', '', '', '', '', '');
List<String> companheirosDia = [];
List<String> companheirosArea = [];

final _form = GlobalKey<FormState>();
final _form2 = GlobalKey<FormState>();

late String loginAttemption;
late String passwordAttemption;

late String login;
late String password;
late String name;
late String apelido;
late String area;
late String dia;

List<String> listaLogins = [];
List<String> listaPasswords = [];
List<String> listaNames = [];
List<String> listaApelidos = [];
List<String> listaAreas = [];
List<String> listaDias = [];

void writeAccountRegister() async {
  _form.currentState!.save();

  var urlLogin =
      "https://trabalho-2-31a95-default-rtdb.firebaseio.com/" + "login.json";
  var urlPassword =
      "https://trabalho-2-31a95-default-rtdb.firebaseio.com/" + "password.json";
  var urlName =
      "https://trabalho-2-31a95-default-rtdb.firebaseio.com/" + "name.json";
  var urlApelido =
      "https://trabalho-2-31a95-default-rtdb.firebaseio.com/" + "apelido.json";
  var urlArea =
      "https://trabalho-2-31a95-default-rtdb.firebaseio.com/" + "area.json";
  var urlDia =
      "https://trabalho-2-31a95-default-rtdb.firebaseio.com/" + "dia.json";

  try {
    final responseLogin = await http.post(
      Uri.parse(urlLogin),
      body: json.encode({"login": login}),
    );
    final responsePassword = await http.post(
      Uri.parse(urlPassword),
      body: json.encode({"password": password}),
    );
    final responseName = await http.post(
      Uri.parse(urlName),
      body: json.encode({"name": name}),
    );
    final responseApelido = await http.post(
      Uri.parse(urlApelido),
      body: json.encode({"apelido": apelido}),
    );
    final responseArea = await http.post(
      Uri.parse(urlArea),
      body: json.encode({"area": area}),
    );
    final responseDia = await http.post(
      Uri.parse(urlDia),
      body: json.encode({"dia": dia}),
    );

    readUserInfos();
  } catch (error) {
    throw error;
  }
}

Future<void> readUserInfos() async {
  var urlLogin =
      "https://trabalho-2-31a95-default-rtdb.firebaseio.com/" + "login.json";
  var urlPassword =
      "https://trabalho-2-31a95-default-rtdb.firebaseio.com/" + "password.json";
  var urlName =
      "https://trabalho-2-31a95-default-rtdb.firebaseio.com/" + "name.json";
  var urlApelido =
      "https://trabalho-2-31a95-default-rtdb.firebaseio.com/" + "apelido.json";
  var urlArea =
      "https://trabalho-2-31a95-default-rtdb.firebaseio.com/" + "area.json";
  var urlDia =
      "https://trabalho-2-31a95-default-rtdb.firebaseio.com/" + "dia.json";

  listaLogins.clear();
  listaPasswords.clear();
  listaNames.clear();
  listaApelidos.clear();
  listaAreas.clear();
  listaDias.clear();

  try {
    final responseLogin = await http.get(Uri.parse(urlLogin));
    final extractedLogin =
        json.decode(responseLogin.body) as Map<String, dynamic>;
    if (extractedLogin == null) {
      return;
    }
    extractedLogin.forEach((blogId, blogData) {
      listaLogins.add(blogData["login"]);
    });

    final responsePassword = await http.get(Uri.parse(urlPassword));
    final extractedPassword =
        json.decode(responsePassword.body) as Map<String, dynamic>;
    if (extractedPassword == null) {
      return;
    }
    extractedPassword.forEach((blogId, blogData) {
      listaPasswords.add(blogData["password"]);
    });

    final responseName = await http.get(Uri.parse(urlName));
    final extractedName =
        json.decode(responseName.body) as Map<String, dynamic>;
    if (extractedName == null) {
      return;
    }
    extractedName.forEach((blogId, blogData) {
      listaNames.add(blogData["name"]);
    });

    final responseApelido = await http.get(Uri.parse(urlApelido));
    final extractedApelido =
        json.decode(responseApelido.body) as Map<String, dynamic>;
    if (extractedApelido == null) {
      return;
    }
    extractedApelido.forEach((blogId, blogData) {
      listaApelidos.add(blogData["apelido"]);
    });

    final responseArea = await http.get(Uri.parse(urlArea));
    final extractedArea =
        json.decode(responseArea.body) as Map<String, dynamic>;
    if (extractedArea == null) {
      return;
    }
    extractedArea.forEach((blogId, blogData) {
      listaAreas.add(blogData["area"]);
    });

    final responseDia = await http.get(Uri.parse(urlDia));
    final extractedDia = json.decode(responseDia.body) as Map<String, dynamic>;
    if (extractedDia == null) {
      return;
    }
    extractedDia.forEach((blogId, blogData) {
      listaDias.add(blogData["dia"]);
    });
  } catch (error) {
    throw error;
  }
}

List<Usuario> usuarios = [];
late bool userAttempetion;

void loginInProgram() async {
  _form2.currentState!.save();

  usuarios.clear();
  companheirosDia.clear();
  companheirosArea.clear();

  userAttempetion = false;

  int contador = 0;
  while (contador < listaApelidos.length) {
    Usuario usuario = new Usuario(
        listaLogins[contador],
        listaPasswords[contador],
        listaNames[contador],
        listaApelidos[contador],
        listaAreas[contador],
        listaDias[contador]);
    usuarios.add(usuario);
    contador += 1;
  }

  for (Usuario usuario in usuarios) {
    if (loginAttemption == usuario.login &&
        passwordAttemption == usuario.password) {
      userAttempetion = true;
      atualUsuario = usuario;
    }
  }

  for (Usuario usuario in usuarios) {
    if (atualUsuario.dia == usuario.dia) {
      companheirosDia.add(usuario.apelido);
    }
    if (atualUsuario.areaResponsavel == usuario.areaResponsavel) {
      companheirosArea.add(usuario.apelido);
    }
  }
}

class TabBarDemo extends StatefulWidget {
  @override
  State<TabBarDemo> createState() => _TabBarDemoState();
}

class _TabBarDemoState extends State<TabBarDemo> {
  void initState() {
    super.initState();
    readUserInfos();
    readComentariosGeral();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              tabs: [
                Tab(icon: Icon(Icons.login)),
                Tab(icon: Icon(Icons.save_as)),
              ],
            ),
            title: Text('Sipá Application'),
            backgroundColor: Colors.orange,
          ),
          body: TabBarView(
            children: [
              Container(
                child: Form(
                    key: _form2,
                    child: Center(
                        child: Column(
                      children: [
                        Image.asset("images/sipa.png", width: 600, height: 300),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          decoration: InputDecoration(hintText: "Enter Login"),
                          onSaved: (loginAttemptionValue) {
                            if (loginAttemptionValue != null && loginAttemptionValue != '') {
                              loginAttemption = loginAttemptionValue;
                            }
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          decoration:
                              InputDecoration(hintText: "Enter Password"),
                          onSaved: (passwordAttemptionValue) {
                            if (passwordAttemptionValue != null && passwordAttemptionValue != '') {
                              passwordAttemption = passwordAttemptionValue;
                            }
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        ElevatedButton(
                            onPressed: () {
                              loginInProgram();
                              if (userAttempetion == true) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SegundaRota()),
                                );
                              }
                            },
                            child: Text(
                              "Realizar login",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                            )),
                      ],
                    ))),
              ),
              Form(
                key: _form,
                child: Center(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        decoration: InputDecoration(hintText: "Enter Login"),
                        onSaved: (loginValue) {
                          if (loginValue != null && loginValue != '') {
                            login = loginValue;
                          }
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        decoration: InputDecoration(hintText: "Enter Password"),
                        onSaved: (valuePassword) {
                          if (valuePassword != null && valuePassword != '') {
                            password = valuePassword;
                          }
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        decoration: InputDecoration(hintText: "Enter Name"),
                        onSaved: (valueName) {
                          if (valueName != null && valueName != '') {
                            name = valueName;
                          }
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        decoration: InputDecoration(hintText: "Enter Apelido"),
                        onSaved: (valueApelido) {
                          if (valueApelido != null && valueApelido != '') {
                            apelido = valueApelido;
                          }
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        decoration:
                            InputDecoration(hintText: "Enter Area Responsável"),
                        onSaved: (valueArea) {
                          if (valueArea != null && valueArea != '') {
                            area = valueArea;
                          }
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        decoration:
                            InputDecoration(hintText: "Enter Dia Responsável"),
                        onSaved: (valueDia) {
                          if (valueDia != null && valueDia != '') {
                            dia = valueDia;
                          }
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          writeAccountRegister();
                        },
                        child: Text(
                          "Realizar cadastro",
                          style: TextStyle(color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SegundaRota extends StatefulWidget {
  @override
  State<SegundaRota> createState() => _SegundaRotaState();
}

class _SegundaRotaState extends State<SegundaRota> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              tabs: [
                Tab(icon: Icon(Icons.account_box)),
                Tab(icon: Icon(Icons.format_list_bulleted_outlined)),
                Tab(icon: Icon(Icons.smart_button_outlined)),
              ],
            ),
            title: Text('Sipá Application'),
            backgroundColor: Colors.orange,
          ),
          body: TabBarView(children: [
            Container(
              child: Center(
                  child: Column(
                children: [
                  Image.asset("images/fotinha.jpeg", width: 300, height: 300),
                  Padding(
                    padding: const EdgeInsets.only(top: 50),
                    child: Text(
                      "Nome:" '${atualUsuario.name}',
                      style: TextStyle(
                        fontSize: 24,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 25),
                    child: Text(
                      "Apelido:" '${atualUsuario.apelido}',
                      style: TextStyle(
                        fontSize: 24,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 25.0),
                    child: Text(
                      "Tarefa:" '${atualUsuario.areaResponsavel}',
                      style: TextStyle(
                        fontSize: 24,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 25.0),
                    child: Text(
                      "Dia da Semana:" '${atualUsuario.dia}',
                      style: TextStyle(
                        fontSize: 24,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('Retornar !'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                      ),
                    ),
                  )
                ],
              )),
            ),
            Column(children: [
              Padding(
                padding: const EdgeInsets.only(top: 25.0),
                child: Container(
                  child: Text(
                    "Lista de todos os usuários:",
                    style: TextStyle(
                      fontSize: 24,
                    ),
                  ),
                ),
              ),
              Expanded(
                  child: ListView.builder(
                      itemCount: listaApelidos.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                            leading: Image.asset("images/fotinha.jpeg"),
                            trailing: const Text(
                              "Aluno",
                              style:
                                  TextStyle(color: Colors.green, fontSize: 15),
                            ),
                            title: Text(listaApelidos.elementAt(index)));
                      })),
              Container(
                child: Text(
                  "Lista dos seus companheiros do dia ${atualUsuario.dia} :",
                  style: TextStyle(
                    fontSize: 24,
                  ),
                ),
              ),
              Expanded(
                  child: ListView.builder(
                      itemCount: companheirosDia.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                            leading: Image.asset("images/fotinha.jpeg"),
                            trailing: const Text(
                              "Aluno",
                              style:
                                  TextStyle(color: Colors.green, fontSize: 15),
                            ),
                            title: Text(companheirosDia.elementAt(index)));
                      })),
              Container(
                child: Text(
                  "Lista dos seus companheiros de area ${atualUsuario.areaResponsavel} :",
                  style: TextStyle(
                    fontSize: 24,
                  ),
                ),
              ),
              Expanded(
                  child: ListView.builder(
                      itemCount: companheirosArea.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                            leading: Image.asset("images/fotinha.jpeg"),
                            trailing: const Text(
                              "Aluno",
                              style:
                                  TextStyle(color: Colors.green, fontSize: 15),
                            ),
                            title: Text(companheirosArea.elementAt(index)));
                      })),
            ]),
            Container(
              child: Center(
                  child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 200, bottom: 100),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black),
                      onPressed: () {
                        readComentariosAtividadeGrupo();
                        readComentariosBateGrupo();
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => QuintaRota()),
                        );
                      },
                      child: Text(
                        "Acessar o Grupo de ${atualUsuario.dia}",
                        style: TextStyle(
                          fontSize: 24,
                        ),
                      ),
                    ),
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black),
                      onPressed: () {
                        readComentariosGeral();
                        readComentariosAtividadeGeral();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TerceiraRota()),
                        );
                      },
                      child: Text(
                        "Acessar o Grupo Geral",
                        style: TextStyle(
                          fontSize: 24,
                        ),
                      )),
                ],
              )),
            ),
          ]),
        ),
      ),
    );
  }
}

final _form3 = GlobalKey<FormState>();

late String comment;

void writeComentarioGeral() async {
  _form3.currentState!.save();

  var urlComentarioGeral =
      "https://trabalho-2-31a95-default-rtdb.firebaseio.com/" +
          "comentarioGeral.json";

  try {
    final responseComentario = await http.post(
      Uri.parse(urlComentarioGeral),
      body: json.encode({"conteudo": comment}),
    );
  } catch (error) {
    throw error;
  }

  readComentariosGeral();
  readComentariosAtividadeGeral();
}

List<String> listaComentarioGeral = [];

Future<void> readComentariosGeral() async {
  var urlComentarioGeral =
      "https://trabalho-2-31a95-default-rtdb.firebaseio.com/" +
          "comentarioGeral.json";

  listaComentarioGeral.clear();

  try {
    final responseComentario = await http.get(Uri.parse(urlComentarioGeral));
    final extractedComentario =
        json.decode(responseComentario.body) as Map<String, dynamic>;
    if (extractedComentario == null) {
      return;
    }
    extractedComentario.forEach((blogId, blogData) {
      listaComentarioGeral.add(blogData["conteudo"]);
    });
  } catch (error) {
    throw error;
  }
}

late String commentAtividadeGeral;

void writeComentarioAtividadeGeral() async {
  _form3.currentState!.save();

  var urlComentarioAtividadeGeral =
      "https://trabalho-2-31a95-default-rtdb.firebaseio.com/" +
          "ComentarioAtividadeGeral.json";

  try {
    final responseComentarioAtividadeGeral = await http.post(
      Uri.parse(urlComentarioAtividadeGeral),
      body: json.encode({"conteudo": commentAtividadeGeral}),
    );
  } catch (error) {
    throw error;
  }

  readComentariosAtividadeGeral();
}

List<String> listaComentarioAtividadeGeral = [];

Future<void> readComentariosAtividadeGeral() async {
  var urlComentarioAtividadeGeral =
      "https://trabalho-2-31a95-default-rtdb.firebaseio.com/" +
          "ComentarioAtividadeGeral.json";

  listaComentarioAtividadeGeral.clear();

  try {
    final responseComentarioAtividadeGeral =
        await http.get(Uri.parse(urlComentarioAtividadeGeral));
    final extractedComentarioAtividadeGeral = json
        .decode(responseComentarioAtividadeGeral.body) as Map<String, dynamic>;
    if (extractedComentarioAtividadeGeral == null) {
      return;
    }
    extractedComentarioAtividadeGeral.forEach((blogId, blogData) {
      listaComentarioAtividadeGeral.add(blogData["conteudo"]);
    });
  } catch (error) {
    throw error;
  }
}

class TerceiraRota extends StatefulWidget {
  @override
  State<TerceiraRota> createState() => _TerceiraRotaState();
}

class _TerceiraRotaState extends State<TerceiraRota> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
          length: 1,
          child: Scaffold(
            appBar: AppBar(
              bottom: TabBar(
                tabs: [
                  Tab(icon: Icon(Icons.save_as)),
                ],
              ),
              title: Text('Sipá Application'),
              backgroundColor: Colors.orange,
            ),
            body: TabBarView(
              children: [
                Column(
                  children: [
                    Form(
                        key: _form3,
                        child: Column(
                          children: [
                            TextFormField(
                              decoration:
                                  InputDecoration(hintText: "Enter Comment"),
                              onSaved: (commenAtttemptionValue) {
                                if (commenAtttemptionValue != null) {
                                  comment =
                                      '${atualUsuario.apelido} - $commenAtttemptionValue';
                                }
                              },
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 25.0, bottom: 25),
                              child: ElevatedButton(
                                onPressed: () {
                                  writeComentarioGeral();
                                },
                                child: Text(
                                  "Submeter Comentário Geral",
                                  style: TextStyle(color: Colors.white),
                                  textAlign: TextAlign.center,
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.black,
                                ),
                              ),
                            ),
                            TextFormField(
                              decoration: InputDecoration(
                                  hintText: "Enter Comment Atividade Geral"),
                              onSaved: (commenAtividadeGeralAtttemptionValue) {
                                if (commenAtividadeGeralAtttemptionValue !=
                                    null) {
                                  commentAtividadeGeral =
                                      '${atualUsuario.apelido} - $commenAtividadeGeralAtttemptionValue';
                                }
                              },
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 25.0),
                              child: ElevatedButton(
                                onPressed: () {
                                  writeComentarioAtividadeGeral();
                                },
                                child: Text(
                                  "Submeter Comentário Atividade Geral",
                                  style: TextStyle(color: Colors.white),
                                  textAlign: TextAlign.center,
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.black,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 25.0),
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.black),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => QuartaRota()),
                                    );
                                  },
                                  child: Text(
                                      "Acessar os comentários do grupo geral")),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 25.0),
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text('Retornar !'),
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.black),
                              ),
                            ),
                          ],
                        )),
                  ],
                ),
              ],
            ),
          )),
    );
  }
}

class QuartaRota extends StatefulWidget {
  @override
  State<QuartaRota> createState() => _QuartaRota();
}

class _QuartaRota extends State<QuartaRota> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            tabs: [
              Tab(icon: Icon(Icons.format_list_bulleted_outlined)),
              Tab(icon: Icon(Icons.format_list_bulleted_outlined)),
            ],
          ),
          title: Text('Quarta Rota'),
          backgroundColor: Colors.orange,
        ),
        body: TabBarView(
          children: [
            Column(
              children: [
              Text("Lista de Comentários Gerais da Casa"),
              Expanded(
                  child: ListView.builder(
                      itemCount: listaComentarioGeral.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                            leading: Image.asset("images/fotinha.jpeg"),
                            trailing: const Text(
                              "Comentario",
                              style:
                                  TextStyle(color: Colors.green, fontSize: 15),
                            ),
                            title: Text(listaComentarioGeral.elementAt(index)));
                      })),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Retornar !'),
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.black),
                ),
              ),
            ]),
            Column(children: [
              Text("Comentário sobre as atividades gerais da casa"),
              Expanded(
                  child: ListView.builder(
                      itemCount: listaComentarioAtividadeGeral.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                            leading: Image.asset("images/fotinha.jpeg"),
                            trailing: const Text(
                              "Comentário sobre a Atividade",
                              style:
                                  TextStyle(color: Colors.green, fontSize: 15),
                            ),
                            title: Text(listaComentarioAtividadeGeral
                                .elementAt(index)));
                      })),
            ]),
          ],
        ),
      ),
    ));
  }
}

final _form4 = GlobalKey<FormState>();

late String comentarioBateGrupo;

void writeComentarioBateGrupo() async {
  _form4.currentState!.save();

  String jsonBP = 'batePapo${atualUsuario.dia}.json';

  var urlComentarioBateGrupo =
      "https://trabalho-2-31a95-default-rtdb.firebaseio.com/" + jsonBP;

  try {
    final responseComentarioBateGrupo = await http.post(
      Uri.parse(urlComentarioBateGrupo),
      body: json.encode({"conteudo": comentarioBateGrupo}),
    );
  } catch (error) {
    throw error;
  }

  readComentariosBateGrupo();
}

late String comentarioAtividadeGrupo;

void writeComentarioAtividadeGrupo() async {
  _form4.currentState!.save();

  String jsonAT = 'atividadeGrupo${atualUsuario.dia}.json';

  var urlComentarioAtividadeGrupo =
      "https://trabalho-2-31a95-default-rtdb.firebaseio.com/" + jsonAT;

  try {
    final responseComentarioAtividadeGrupo = await http.post(
      Uri.parse(urlComentarioAtividadeGrupo),
      body: json.encode({"conteudo": comentarioAtividadeGrupo}),
    );
  } catch (error) {
    throw error;
  }

  readComentariosAtividadeGrupo();
}

List<String> listaComentarioAtividadeGrupo = [];

Future<void> readComentariosAtividadeGrupo() async {
  String jsonAT = 'atividadeGrupo${atualUsuario.dia}.json';

  var urlComentarioAtividadeGrupo =
      "https://trabalho-2-31a95-default-rtdb.firebaseio.com/" + jsonAT;

  listaComentarioAtividadeGrupo.clear();

  try {
    final responseComentarioAtividadeGrupo =
        await http.get(Uri.parse(urlComentarioAtividadeGrupo));
    final extractedComentarioAtividadeGrupo = json
        .decode(responseComentarioAtividadeGrupo.body) as Map<String, dynamic>;
    if (extractedComentarioAtividadeGrupo == null) {
      return;
    }
    extractedComentarioAtividadeGrupo.forEach((blogId, blogData) {
      listaComentarioAtividadeGrupo.add(blogData["conteudo"]);
    });
  } catch (error) {
    throw error;
  }
}

List<String> listaComentarioBateGrupo = [];

Future<void> readComentariosBateGrupo() async {
  String jsonBP = 'batePapo${atualUsuario.dia}.json';

  var urlComentarioBateGrupo =
      "https://trabalho-2-31a95-default-rtdb.firebaseio.com/" + jsonBP;

  listaComentarioBateGrupo.clear();

  try {
    final responseComentarioBateGrupo =
        await http.get(Uri.parse(urlComentarioBateGrupo));
    final extractedComentarioBateGrupo =
        json.decode(responseComentarioBateGrupo.body) as Map<String, dynamic>;
    if (extractedComentarioBateGrupo == null) {
      return;
    }
    extractedComentarioBateGrupo.forEach((blogId, blogData) {
      listaComentarioBateGrupo.add(blogData["conteudo"]);
    });
  } catch (error) {
    throw error;
  }
}

class QuintaRota extends StatefulWidget {
  @override
  State<QuintaRota> createState() => _QuintaRota();
}

class _QuintaRota extends State<QuintaRota> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
          length: 1,
          child: Scaffold(
            appBar: AppBar(
              bottom: TabBar(
                tabs: [
                  Tab(icon: Icon(Icons.save_as)),
                ],
              ),
              title: Text('Sipá Application'),
              backgroundColor: Colors.orange,
            ),
            body: TabBarView(
              children: [
                Column(
                  children: [
                    Form(
                        key: _form4,
                        child: Column(
                          children: [
                            TextFormField(
                              decoration: InputDecoration(
                                  hintText:
                                      "Enviar comentário para bate papo do grupo"),
                              onSaved: (comentarioBateGrupoAtttemptionValue) {
                                if (comentarioBateGrupoAtttemptionValue !=
                                    null) {
                                  comentarioBateGrupo =
                                      '${atualUsuario.apelido} - $comentarioBateGrupoAtttemptionValue';
                                }
                              },
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 25.0, bottom: 25),
                              child: ElevatedButton(
                                onPressed: () {
                                  writeComentarioBateGrupo();
                                },
                                child: Text(
                                  "Submeter comentário para o bate papo",
                                  style: TextStyle(color: Colors.white),
                                  textAlign: TextAlign.center,
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.black,
                                ),
                              ),
                            ),
                            TextFormField(
                              decoration: InputDecoration(
                                  hintText:
                                      "Enviar comentário sobre as atividades do dia"),
                              onSaved:
                                  (comentarioAtividadeGrupoAtttemptionValue) {
                                if (comentarioAtividadeGrupoAtttemptionValue !=
                                    null) {
                                  comentarioAtividadeGrupo =
                                      '${atualUsuario.apelido} - $comentarioAtividadeGrupoAtttemptionValue';
                                }
                              },
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 25.0),
                              child: ElevatedButton(
                                onPressed: () {
                                  writeComentarioAtividadeGrupo();
                                  readComentariosAtividadeGrupo();
                                },
                                child: Text(
                                  "Submeter comentário sobre as atividades do dia",
                                  style: TextStyle(color: Colors.white),
                                  textAlign: TextAlign.center,
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.black,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 25.0),
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.black),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => SextaRota()),
                                    );
                                  },
                                  child: Text(
                                      "Acessar os comentários grupo de ${atualUsuario.dia}")),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 25.0),
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text('Retornar '),
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.black),
                              ),
                            ),
                          ],
                        )),
                  ],
                ),
              ],
            ),
          )),
    );
  }
}

class SextaRota extends StatefulWidget {
  @override
  State<SextaRota> createState() => _SextaRota();
}

class _SextaRota extends State<SextaRota> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            tabs: [
              Tab(icon: Icon(Icons.format_list_bulleted_outlined)),
              Tab(icon: Icon(Icons.format_list_bulleted_outlined)),
            ],
          ),
          title: Text('Sexta Rota'),
          backgroundColor: Colors.orange,
        ),
        body: TabBarView(
          children: [
            Column(children: [
              Text("Comentários gerais com o grupo da semana"),
              Expanded(
                  child: ListView.builder(
                      itemCount: listaComentarioBateGrupo.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                            leading: Image.asset("images/fotinha.jpeg"),
                            trailing: const Text(
                              "Comentario",
                              style:
                                  TextStyle(color: Colors.green, fontSize: 15),
                            ),
                            title: Text(
                                listaComentarioBateGrupo.elementAt(index)));
                      })),
              Padding(
                padding: const EdgeInsets.only(top: 25.0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Retornar !'),
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.black),
                ),
              ),
            ]),
            Column(children: [
              Text("Comentários sobre as atividades com o grupo da semana"),
              Expanded(
                  child: ListView.builder(
                      itemCount: listaComentarioAtividadeGrupo.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                            leading: Image.asset("images/fotinha.jpeg"),
                            trailing: const Text(
                              "Comentário sobre a Atividade",
                              style:
                                  TextStyle(color: Colors.green, fontSize: 15),
                            ),
                            title: Text(listaComentarioAtividadeGrupo
                                .elementAt(index)));
                      }))
            ])
          ],
        ),
      ),
    ));
  }
}