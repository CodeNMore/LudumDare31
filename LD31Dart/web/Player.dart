library ld31_entity_player;

import "dart:html";
import "KeyManager.dart";

class Player {
  
  int width = 32, height = 32;
  double _x, _y, _xSpeed, _ySpeed;
  double _moveSpeed = 0.75, _maxSpeed = 10.0;
  double _friction = 0.2;
  
  Player(double x, double y){
    _x = x;
    _y = y;
    _xSpeed = 0.0;
    _ySpeed = 0.0;
  }
  
  void tick(final double delta){
    _handleInput();
    _tickFriction();
    _finalMove();
  }
      
  void render(CanvasRenderingContext2D g){
    g.fillStyle = "#FF00FF";
    g.fillRect(_x, _y, width, height);
  }
  
  void _finalMove(){
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
  
  void _handleInput(){
    if(KeyManager.isPressed(KeyCode.D) || KeyManager.isPressed(KeyCode.RIGHT)){
      _xSpeed += _moveSpeed;
      if(_xSpeed > _maxSpeed)
        _xSpeed = _maxSpeed;
    }else if(KeyManager.isPressed(KeyCode.A) || KeyManager.isPressed(KeyCode.LEFT)){
      _xSpeed -= _moveSpeed;
      if(_xSpeed < -_maxSpeed)
        _xSpeed = -_maxSpeed;
    }

    if(KeyManager.isPressed(KeyCode.S) || KeyManager.isPressed(KeyCode.DOWN)){
      _ySpeed += _moveSpeed;
      if(_ySpeed > _maxSpeed)
        _ySpeed = _maxSpeed;
    }else if(KeyManager.isPressed(KeyCode.W) || KeyManager.isPressed(KeyCode.UP)){
      _ySpeed -= _moveSpeed;
      if(_ySpeed < -_maxSpeed)
        _ySpeed = -_maxSpeed;
    }
  }
  
}