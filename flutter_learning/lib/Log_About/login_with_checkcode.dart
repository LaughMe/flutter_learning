
import 'package:flutter/material.dart';
import 'dart:async';


///这个类制作了一个简易的登陆界面并带有验证码计时发送功能
///This class makes a simple login interface with a verification code timing sending function
class Login extends StatefulWidget {
  @override
  _Login createState() => new _Login();
}

class _Login extends State<Login> {
  //获取Key用来获取Form表单组件
  GlobalKey<FormState> loginKey = new GlobalKey<FormState>();
  late String userName;
  late String password;


  late Timer _timer;
  int _countdownTime = 0;

  void login(){
    //读取当前的Form状态
    var loginForm = loginKey.currentState;
    //验证Form表单
    if(loginForm!.validate()){
      loginForm.save();
      print('userName: ' + userName + ' password: ' + password);
    }

  }


  //开启计数器方法
  void startCountdownTimer() {
    const oneSec = const Duration(seconds: 1);

    var callback = (timer) => {
      setState(() {
        if (_countdownTime < 1) {
          _timer.cancel();
        } else {
          _countdownTime = _countdownTime - 1;
        }
      })
    };

    _timer = Timer.periodic(oneSec, callback);
  }









  @override
  Widget build(BuildContext context){

    return   MaterialApp(
      title: 'Form表单示例',
      home: new Scaffold(
        body: new Column(
          children: <Widget>[
            new Container(
                padding: EdgeInsets.only(top: 100.0, bottom: 10.0),
                child: new Text(
                  'LOGO',
                  style: TextStyle(
                      color: Color.fromARGB(255, 53, 53, 53),
                      fontSize: 50.0
                  ),
                )
            ),
            new Container(
              padding: const EdgeInsets.all(16.0),
              child: new Form(
                key: loginKey,
                autovalidate: true,
                child: new Column(
                  children: <Widget>[
                    new Container(
                      decoration: new BoxDecoration(
                          border: new Border(
                              bottom: BorderSide(
                                  color: Color.fromARGB(255, 240, 240, 240),
                                  width: 1.0
                              )
                          )
                      ),
                      child: new TextFormField(
                        decoration: new InputDecoration(
                          labelText: '请输入手机号',
                          labelStyle: new TextStyle( fontSize: 15.0, color: Color.fromARGB(255, 93, 93, 93)),
                          border: InputBorder.none,
                          // suffixIcon: new IconButton(
                          //   icon: new Icon(
                          //     Icons.close,
                          //     color: Color.fromARGB(255, 126, 126, 126),
                          //   ),
                          //   onPressed: () {

                          //   },
                          // ),
                        ),
                        keyboardType: TextInputType.phone,
                        onSaved: (value) {
                          userName = value!;
                        },
                        validator: (phone) {
                          if(phone!.length == 0){
                            return '请输入手机号';
                          }
                        },
                        onFieldSubmitted: (value) {

                        },
                      ),
                    ),
                    new Container(
                      decoration: new BoxDecoration(
                          border: new Border(
                              bottom: BorderSide(
                                  color: Color.fromARGB(255, 240, 240, 240),
                                  width: 1.0
                              )
                          )
                      ),
                      child: new TextFormField(
                        decoration:  new InputDecoration(
                          labelText: '请输入验证码',
                          labelStyle: new TextStyle( fontSize: 15.0, color: Color.fromARGB(255, 93, 93, 93)),
                          border: InputBorder.none,
                          suffixIcon:
                          TextButton(

                            style: ButtonStyle(
                              foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                            ),
                            onPressed:
                            _countdownTime >0? //设置读秒时按钮无法点击
                            null:
                                () {
                              print("clicked");
                              if (_countdownTime == 0 ) {

                                setState(() {
                                  _countdownTime = 60;
                                });
                                //开始倒计时
                                startCountdownTimer();
                              }
                            },
                            child: Text(    //设置按钮文本自动更新
                              _countdownTime > 0 ? '$_countdownTime后重新获取' : '获取验证码',
                              style: TextStyle(
                                fontSize: 14,
                                color: _countdownTime > 0
                                    ? Color.fromARGB(255, 183, 184, 195)
                                    : Color.fromARGB(255, 17, 132, 255),
                              ),
                            ),

                          ),

                        ),
                        keyboardType: TextInputType.phone,
                        onSaved: (value) {
                          password = value!;
                        },
                      ),
                    ),
                    new Container(
                      height: 45.0,
                      margin: EdgeInsets.only(top: 40.0),
                      child: new SizedBox.expand(
                        child: new RaisedButton(
                          onPressed: login,
                          color: Color.fromARGB(255, 61, 203, 128),
                          child: new Text(
                            '登录',
                            style: TextStyle(
                                fontSize: 14.0,
                                color: Color.fromARGB(255, 255, 255, 255)
                            ),
                          ),
                          shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(45.0)),
                        ),
                      ),
                    ),


                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );

  }
  @override
  void dispose() {
    super.dispose();
    if (_timer != null) {
      _timer.cancel();
    }
  }
}