library ld31_enemy;

import "dart:html";
import "dart:math";
import "Gun.dart";
import "Path.dart";
import "Vector.dart";
import "Player.dart";
import "Game.dart";
//import "ParticleEmitter.dart";

class Enemy{
  
  double _moveSpeed = 0.6, _maxSpeed = 3.0;
  double _friction = 0.3;
  
  double _x, _y;
  int _width = 20, _height = 20;
  double _xSpeed, _ySpeed;
  int _type, _wave;
  String _mainColor;
  int _health, _minAccuracy, _maxAccuracy;
  Player _player;
  Gun _gun;
  
  int _toIndex;
  Vector _pathVector;
  Path _path;
  
  Rectangle _bounds;
  
  Enemy(double x, double y, int type, int wave, Player player){
    _x = x;
    _y = y;
    _xSpeed = 0.0;
    _ySpeed = 0.0;
    _type = type;
    _wave = wave;
    _player = player;
    _setStuff();
    
    _toIndex = 0;
    _pathVector = new Vector(0.0, 0.0, 0);
    
//    trail = new ParticleEmitter(_x, _y, -1, 3, 3, _mainColor, 1, 2, 0, 360, 1, 1, 0.4);
  }
  
  bool tick(final double delta){
    //Gun
    _gun.tick(delta, _getAccuracy((_player.getX() + _player.getWidth() / 2).round()), _getAccuracy((_player.getY()  + _player.getHeight() / 2).round()), _x, _y, true);
    
    //Move
    _handleMovement();
    _tickFriction();
    _finalMove();
    
    //Etc
//    trail.setPos(_x + _width / 2, _y + _height / 2);
//    trail.tick(delta);
    
    int times = Gun.collision(getBounds(), false);
    _health -= times * 10;
    
    if(_health <= 0)
      return true;
    
    return false;
  }
  
  void render(CanvasRenderingContext2D g){
    g.fillStyle = _mainColor;
    g.fillRect(_x, _y, _width, _height);
//    trail.render(g);
  }
  
  void _handleMovement(){
    _pathVector = _path.moveAlongPath(_x, _y, _toIndex);
    _xSpeed = _moveSpeed * 4 * _pathVector.getX();
    _ySpeed = _moveSpeed * 4 * _pathVector.getY();
    _toIndex = _pathVector.getZ();
  }
  
  Rectangle getBounds(){
    return (_bounds = new Rectangle(_x, _y, _width, _height));
  }
  
  int _getAccuracy(int i){
    var r = new Random();
    return i + r.nextInt((_maxAccuracy - _minAccuracy) + 1) + _minAccuracy;
  }
  
  void _finalMove(){
    if(_x + _xSpeed < 0){
      _x = 0.0;
      _xSpeed = 0.0;
    }else if(_x + _width + _xSpeed >= Game.WIDTH){
      _x = Game.WIDTH - _width - 0.0;
      _xSpeed = 0.0;
    }
    if(_y + _ySpeed < 0){
      _y = 0.0;
      _ySpeed = 0.0;
    }else if(_y + _height + _ySpeed >= Game.HEIGHT){
      _y = Game.HEIGHT - _height - 0.0;
      _ySpeed = 0.0;
    }
    
    _x += _xSpeed;
    _y += _ySpeed;
  }
  
  void _tickFriction(){
    if(_xSpeed > 0){
      _xSpeed -= _friction;
      if(_xSpeed < 0)
        _xSpeed = 0.0;
    }else if(_xSpeed < 0){
      _xSpeed += _friction;
      if(_xSpeed > 0)
        _xSpeed = 0.0;
    }
    
    if(_ySpeed > 0){
      _ySpeed -= _friction;
      if(_ySpeed < 0)
        _ySpeed = 0.0;
    }else if(_ySpeed < 0){
      _ySpeed += _friction;
      if(_ySpeed > 0)
        _ySpeed = 0.0;
    }
  }
  
  void _setStuff(){//TODO: Re-do health, gunspeed based on wave number, PATH
    _path = Path.paths[0];
    
    if(_type == 1){
      _mainColor = "#FF3333";
      _health = 30;
      _minAccuracy = -20;
      _maxAccuracy = 20;
      _gun = new Gun(0.8, false);
    }else if(_type == 2){
      _mainColor = "#33FF33";
      _health = 40;
      _minAccuracy = -23;
      _maxAccuracy = 23;
      _gun = new Gun(0.7, false);
    }else{
      _mainColor = "#3333FF";
      _health = 50;
      _minAccuracy = -28;
      _maxAccuracy = 28;
      _gun = new Gun(0.6, false);
    }
  }
  
  double getX() => _x;
  double getY() => _y;
  int getWidth() => _width;
  int getHeight() => _height;
  String getMainColor() => _mainColor;
  
}