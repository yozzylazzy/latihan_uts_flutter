import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const HomePage());
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: Text('Latihan'),
          ),
        drawer: Drawer(),
        body: FormIsi(),
      ),
    );
  }
}

class FormIsi extends StatefulWidget {
  const FormIsi({Key? key}) : super(key: key);

  @override
  State<FormIsi> createState() => _FormIsiState();
}

class _FormIsiState extends State<FormIsi> {
  TextEditingController nama = TextEditingController();
  TextEditingController alamat = TextEditingController();
  TextEditingController dateinput =  TextEditingController();
  TextEditingController ipk =  TextEditingController();
  String? _gender = 'Pria';
  String selectedAgama = '';
  bool _passwordVisible = false;
  bool dateEdit = false;
  final GlobalKey<FormState> _keyform = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.all(40),
        child: Form(
          key: _keyform,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Header(),
              TextFormField(
                keyboardType: TextInputType.name,
                controller: nama,
                validator: (value){
                  bool isName = RegExp(r'[!@#<>?":_`~;[\]\\//|=+)(*&^%0-9-]').hasMatch(value.toString());
                  if(value==null||value.isEmpty){
                    return 'Data Nama Masih Kosong!!!';
                  } else if (isName){
                    return 'Data Nama Belum Benar!';
                  }
                  return null;
                },
                style: TextStyle(
                  color: Colors.purple,
                ),
                decoration: InputDecoration(
                  labelText: "Nama",
                    icon: Icon(Icons.person),
                    suffixIcon: Icon(Icons.remove_red_eye_outlined),
                    //prefixIcon: Icon(Icons.ac_unit),
                    hoverColor: Colors.deepPurple,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    borderSide: BorderSide(
                      color: Colors.deepPurple,
                      style: BorderStyle.solid
                    )
                  )
                ),

              ),
              SizedBox(height: 20,),
              TextFormField(
                keyboardType: TextInputType.number,
                validator: (value){
                  bool isNpm = RegExp(r'[a-zA-Z,-,$,%,!,@,#,^,&,*,(,)]').hasMatch(value.toString());
                  if(value==null || value.isEmpty){
                      return 'Data NPM Masih Kosong!!!';
                  } else if (isNpm){
                    return 'Data NPM Belum Benar!';
                  }
                  return null;
                },
                obscureText: false,
                controller: alamat,
                style: TextStyle(
                  color: Colors.purple,
                ),
                decoration: InputDecoration(
                  labelText: "NPM",
                    hintText: "2020xxxxx",
                    icon: Icon(Icons.numbers),
                    suffixIcon: Icon(Icons.remove_red_eye_outlined),
                    //prefixIcon: Icon(Icons.ac_unit),
                    hoverColor: Colors.deepPurple,
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        borderSide: BorderSide(
                            color: Colors.deepPurple,
                            style: BorderStyle.solid
                        )
                    )
                ),
              ),
              SizedBox(height: 20,),
              Row(
                children: <Widget>[
                  Flexible(child: TextFormField(
                    controller: dateinput,
                    readOnly: true,
                    onTap: () async{
                      DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2101));
                      if(pickedDate != null) {
                        String formattedDate = DateFormat('dd-MM-yyyy').format(pickedDate);
                        setState(() {
                          dateinput.text = formattedDate;
                        });
                      }else {}
                    },
                    style: TextStyle(
                      color: Colors.purple,
                    ),
                    decoration: InputDecoration(
                        labelText: 'Tanggal Lahir',
                        icon: Icon(Icons.date_range),
                        suffixIcon: IconButton(
                          icon : Icon(
                              dateEdit? Icons.cancel: Icons.cancel_outlined),
                          onPressed: (){
                            setState(() {
                                dateEdit = !dateEdit;
                            });
                          },
                        ),
                        //prefixIcon: Icon(Icons.ac_unit),
                        hoverColor: Colors.deepPurple,
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            borderSide: BorderSide(
                                color: Colors.deepPurple,
                                style: BorderStyle.solid
                            )
                        )
                    ),
                  )),
                  SizedBox(width: 20,),
                  Flexible(child: TextFormField(
                    controller: ipk,
                    validator: (value){
                      bool nilaiValidator = RegExp(r'[a-zA-Z,-]').hasMatch(value.toString());
                      if(value == null || value.isEmpty || value.toString() == "."){
                        return 'Mohon Isikan IPK';
                      } else if (nilaiValidator || double.parse(value)>4){
                        return 'Isi Nilai IPK Belum Benar';
                      }
                      return null;
                    },
                    style: TextStyle(
                      color: Colors.purple,
                    ),
                    decoration: InputDecoration(
                       labelText: 'Nilai IPK',
                        icon: Icon(Icons.abc),
                        suffixIcon: Icon(Icons.remove_red_eye_outlined),
                        //prefixIcon: Icon(Icons.ac_unit),
                        hoverColor: Colors.deepPurple,
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            borderSide: BorderSide(
                                color: Colors.deepPurple,
                                style: BorderStyle.solid
                            )
                        )
                    ),
                  )),
                ],
              ),
              TextFormField(
                obscureText: !_passwordVisible,
                autocorrect: false,
                //controller: ,
                validator: (value){
                  return (value!.isEmpty?
                  "Password Tidak Boleh Kosong" : null);
                },
                decoration: InputDecoration(
                  labelText: 'Password',
                  hintText: 'Masukkan Password',
                  labelStyle: TextStyle(
                    color: Colors.deepPurple,
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _passwordVisible? Icons.visibility : Icons.visibility_off,
                      color: Theme.of(context).primaryColorDark,
                    ),
                    onPressed: (){
                      setState(() {
                        _passwordVisible = !_passwordVisible;
                      });
                    },
                  ),
                  prefixIcon: Icon(Icons.lock),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              DropdownButtonFormField<String>(
                isExpanded: true,
                //controller: ,
                validator: (value) => value ==null ? 'Agama Harus Dipilih' : null,
                items: <String>['Katolik', 'Kristen', 'Islam', 'Budha', 'Hindu'].map((String value)
                {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (value){
                  setState(() {
                    selectedAgama = value!;
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Pilih Agama',
                  labelStyle: TextStyle(
                    color: Colors.deepPurple,
                  ),
                  //prefixIcon: Icon(Icons.home),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: 20,),
              genderField(),
              SizedBox(height: 20,),
              ElevatedButton(onPressed: (){
                if(_keyform.currentState!.validate()){

                }
              },
                  child: Text("Submit")),
            ],
          ),
        )
      ),
    );
  }
  Widget Header(){
    return Container(
      margin: EdgeInsets.only(left: 60,right: 40,bottom: 30),
      child:  Align(
          alignment: AlignmentDirectional.center,
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  flex: 1,child: Image(image: AssetImage('images/git.png')),
                ),
                SizedBox(width: 60,),
                Expanded(
                    flex:1,
                    child: Container(
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft
                            , child: Container(
                            child :RichText(
                                text: TextSpan(
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold
                                    ),
                                    text: "Nama : ",
                                    children: <TextSpan>[
                                      TextSpan(text: ' Yosef Adrian ', style: TextStyle(fontStyle: FontStyle.italic,
                                          fontWeight: FontWeight.normal)),
                                    ]
                                )),
                          ),
                          ),
                          Align(
                            alignment: Alignment.centerLeft
                            , child: Container(
                            child :  RichText(
                                text: TextSpan(
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                    text: "NPM : ",
                                    children: <TextSpan>[
                                      TextSpan(text: ' 2020130002 ', style: TextStyle(fontWeight: FontWeight.bold)),
                                    ]
                                )),
                          ),),
                          Align(
                            alignment: Alignment.centerLeft
                            , child: Container(
                            child :  RichText(
                                text: TextSpan(
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'Roboto-Mono',
                                      fontStyle: FontStyle.italic,
                                    ),
                                    text: "Jurusan : ",
                                    children: <TextSpan>[
                                      TextSpan(text: ' Teknik Informatika ', style: TextStyle(fontWeight: FontWeight.bold,
                                          fontStyle: FontStyle.normal)),
                                    ]
                                )),
                          ),),
                        ],
                      ),
                    )
                ),
              ],
            ),
          )
      ),
    );
  }

  Widget genderField(){
    return Row(
      children: [
        Flexible(
          child: RadioListTile(
            value: 'Pria',
            groupValue: _gender,
            onChanged: (String? value){
              setState(() {
                _gender = value;
              });
            },
            title: const Text("Pria"),
          ),
        ),
        Flexible(child: RadioListTile(
          value: 'Wanita',
          groupValue: _gender,
          onChanged: (String? value){
            setState(() {
              _gender=value;
            });
          },
          title: const Text("Wanita"),
        )),
      ],
    );
  }
}




