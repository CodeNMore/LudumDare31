library ld31_enemy;

import "dart:html";
import "dart:math";
import "ParticleEmitter.dart";
import "Gun.dart";
import "Player.dart";

class Enemy{
  
  double _x, _y;
  int _width = 20, _height = 20;
  double _xSpeed, _ySpeed;
  int _type;
  String _mainColor;
  int _health, _minAccuracy, _maxAccuracy;
  Player _player;
  Gun _gun;
  
  Rectangle _bounds;
  
  ParticleEmitter trail;
  
  Enemy(double x, double y, int type, Player player){
    _x = x;
    _y = y;
    _type = type;
    _player = player;
    _setStuff();
    
    trail = new ParticleEmitter(_x, _y, -1, 3, 3, _mainColor, 1, 2, 0, 360, 1, 1, 0.4);
  }
  
  bool tick(final double delta){
    //Gun
    _gun.tick(delta, _getAccuracy((_player.getX() + _player.getWidth() / 2).round()), _getAccuracy((_player.getY()  + _player.getHeight() / 2).round()), _x, _y, true);
    
    //Move
    
    
    //Etc
    trail.setPos(_x + _width / 2, _y + _height / 2);
    trail.tick(delta);
    
    int times = Gun.collision(getBounds(), false);
    _health -= times * 10;
    if(_health <= 0)
      return true;
    return false;
  }
  
  void render(CanvasRenderingContext2D g){
    g.fillStyle = _mainColor;
    g.fillRect(_x, _y, _width, _height);
    trail.render(g);
  }
  
  Rectangle getBounds(){
    return (_bounds = new Rectangle(_x, _y, _width, _height));
  }
  
  int _getAccuracy(int i){
    var r = new Random();
    return i + r.nextInt((_maxAccuracy - _minAccuracy) + 1) + _minAccuracy;
  }
  
//  void _finalMove(){
//    if(_x < 0)
//      _x = 0.0;
//    else if(_x + _width >= Game.WIDTH)
//      _x = Game.WIDTH - _width - 0.0;
//    if(_y < 0)
//      _y = 0.0;
//    else if(_y + _height >= Game.HEIGHT)
//      _y = Game.HEIGHT - _height - 0.0;
//    
//    _x += _xSpeed;
//    _y += _ySpeed;
//  }
//  
//  void _tickFriction(){
//    if(_xSpeed > 0){
//      _xSpeed -= _friction;
//      if(_xSpeed < 0)
//        _xSpeed = 0.0;
//    }else if(_xSpeed < 0){
//      _xSpeed += _friction;
//      if(_xSpeed > 0)
//        _xSpeed = 0.0;
//    }
//    
//    if(_ySpeed > 0){
//      _ySpeed -= _friction;
//      if(_ySpeed < 0)
//        _ySpeed = 0.0;
//    }else if(_ySpeed < 0){
//      _ySpeed += _friction;
//      if(_ySpeed > 0)
//        _ySpeed = 0.0;
//    }
//  }
  
  void _setStuff(){
    if(_type == 0){//Player
      _mainColor = "#FF66FF";
    }else if(_type == 1){
      _mainColor = "#FF3333";
      _health = 30;
      _minAccuracy = -20;
      _maxAccuracy = 20;
      _gun = new Gun(0.7, false);
    }else if(_type == 2){
      _mainColor = "#33FF33";
      _health = 40;
      _minAccuracy = -23;
      _maxAccuracy = 23;
      _gun = new Gun(0.6, false);
    }else{
      _mainColor = "#3333FF";
      _health = 50;
      _minAccuracy = -28;
      _maxAccuracy = 28;
      _gun = new Gun(0.5, false);
    }
  }
  
  double getX() => _x;
  double getY() => _y;
  int getWidth() => _width;
  int getHeight() => _height;
  String getMainColor() => _mainColor;
  
}