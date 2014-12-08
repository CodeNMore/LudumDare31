library ld31_player_module;

import "dart:html";
import "dart:math";
import "Player.dart";
import "Gun.dart";
import "Path.dart";
import "Vector.dart";
import "Game.dart";

class PlayerModule{
  
  Player _player;
  int _health;
  int _width, _height;
  double _x, _y, _xSpeed = 0.0, _ySpeed = 0.0;
  double _moveSpeed = 1.0, _maxSpeed = 6.0;
  double _friction = 0.3;
  double _xo, _yo;
  Gun _gun;
  Rectangle _bounds;
  bool _isAttached;
  
  int _toIndex;
  Path _path;
  Vector _pathVector;
  
  PlayerModule(Player player, double x, double y, double xo, double yo){
    _player = player;
    _xo = xo;
    _yo = yo;
    _x = x;
    _y = y;
    _width = _player.getWidth();
    _height = player.getHeight();
    _bounds = new Rectangle(_x, _y, _width, _height);
    _health = 40;
    _isAttached = false;
    
    _toIndex = 0;
    var r = new Random();
    _path = Path.paths[r.nextInt(Path.paths.length)];
    _pathVector = new Vector(0.0, 0.0, 0);
    
    _gun = new Gun(0.8, true);
  }
  
  bool tick(final double delta){
    if(_isAttached){
      _x = _player.getX() + _xo;
      _y = _player.getY() + _yo;
    
      _gun.tickPlayer(delta, _x + _width / 2, _y + _height / 2, (_xo / 20).round(), (_yo / 20).round());
    
      int times = Gun.collision(getBounds(), true);
      _health -= times * 10;
    }else{
      _handleMovement();
      _tickFriction();
      _finalMove();
    }
    
    if(_health <= 0)
      return true;
    return false;
  }
  
  void render(CanvasRenderingContext2D g){
    g.fillStyle = "#FF66FF";
    g.fillRect(_x, _y, _width, _height);
  }
  
  Rectangle getBounds(){
    return (_bounds = new Rectangle(_x, _y, _width, _height));
  }
  
  void setHealth(int h){
    _health = h;
  }
  
  void _handleMovement(){
    _pathVector = _path.moveAlongPath(_x, _y, _toIndex);
    _xSpeed = _moveSpeed * 4 * _pathVector.getX();
    _ySpeed = _moveSpeed * 4 * _pathVector.getY();
    _toIndex = _pathVector.getZ();
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
  
  bool isAttached() => _isAttached;
  
  double getXOffset() => _xo;
  double getYOffset() => _yo;
  
  void setAttached(bool t){
    _isAttached = t;
  }
  
}