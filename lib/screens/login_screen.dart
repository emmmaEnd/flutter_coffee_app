import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';



class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  
  TextEditingController conUser = TextEditingController();
  TextEditingController conPwd = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    bool isValidating = false;

    final txtUser = TextField(
      keyboardType: TextInputType.emailAddress ,
      controller: conUser, 
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),//el escrito por el usuario
      decoration: const InputDecoration(
        hintText: 'Correo electronico',
        hintStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),//el "hint"
      ),
    );
    final txtPwd = TextField(
      obscureText: true,
      controller: conPwd,
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),//el escrito por el usuario
      decoration: const InputDecoration(
        hintText: 'contraseña',
        
        hintStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),//el "hint"
      ),
    );
    return Scaffold(
      
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage("assets/quark_bottom.jpg") //networkImage(url)
          ) 
        ),
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Positioned(
              top: 200,
              child: Text('Titulos chidos', 
              style: TextStyle(fontSize: 40, fontFamily: 'verdana',color: cs.onPrimary)
              ),
            ),
            Positioned(
              //de abajo hacia arriba 50 pixeles
              bottom: 80, 
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                //color: Colors.amber, //no puede haber decoracion y color a la misma altura
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * .2,
                decoration: BoxDecoration(
                  color: cs.primary,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Column( 
                  children: [
                    txtUser,
                    txtPwd,
                    
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: (){
                            isValidating = true;
                            setState((){});
                            Future.delayed(const Duration(milliseconds: 1000)).then(
                              (value) => Navigator.pushNamed(context, '/home'),
                            );
                          },
                          child: const Text("acceder"),
                        ),
                        ElevatedButton(
                          onPressed: (){
                            Navigator.pushNamed(context, '/register');
                          },
                          child: const Text("registrarte"),
                        ),
                      ],
                    )
                  ],
                ),

              )
            ),
            Positioned(
              top: 300,
              child: !isValidating ? Lottie.asset('assets/loading2.json',height: 200) 
              : Container(),
            )
          ],
        ),
      ),
    );
  }
}