library ld31_bullet;

import "dart:html";
import "dart:math";
import "Game.dart";

class Bullet{
  
  static double _speed = 12.0;
  
  int _width = 6, _height = 6;
  
  double _x, _y;
  double _xSpeed, _ySpeed;
  bool _isFromPlayer;
  
  Bullet(double x, double y, double angle, bool isFromPlayer){
    _xSpeed = _speed * cos(angle);
    _ySpeed = _speed * sin(angle);
    
    _isFromPlayer = isFromPlayer;
    _x = x;
    _y = y;
  }
  
  bool tick(final double delta){
    _x += _xSpeed;
    _y += _ySpeed;
    //TODO: CHECK FOR ENEMY COLLISION
    if(_x < 0 || _x > Game.WIDTH || _y < 0 || _y > Game.HEIGHT)
      return true;
    
    return false;
  }
  
  void render(CanvasRenderingContext2D g){
    g.fillRect(_x, _y, _width, _height);
  }
  
}