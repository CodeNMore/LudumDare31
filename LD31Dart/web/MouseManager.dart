library ld31_mouse;

import "dart:html";

class MouseManager{
  
  int _xo, _yo;
  static int _mouseX, _mouseY;
  static bool _pressed = false;
  
  MouseManager(CanvasElement canvas){
    _xo = canvas.offsetLeft;
    _yo = canvas.offsetTop;
    _mouseX = 0;
    _mouseY = 0;
    
    canvas.onMouseMove.listen((MouseEvent e){
      _mouseX = e.client.x - _xo;
      _mouseY = e.client.y - _yo;
//      print(_mouseX.toString() + "    " + _mouseY.toString());
    });
    
    canvas.onMouseDown.listen((MouseEvent e){
      _pressed = true;
    });
    
    canvas.onMouseUp.listen((MouseEvent e){
      _pressed = false;
    });
  }
  
  static bool isPressed(){
    return _pressed;
  }
  
  static int getX(){
    return _mouseX;
  }
  
  static int getY(){
    return _mouseY;
  }
  
}