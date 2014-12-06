library ld31_gun;

import "dart:html";
import "dart:math";
import "MouseManager.dart";
import "Bullet.dart";

class Gun{
  
  double _fireDelay;
  int _amount;
  double _timer;
  bool _canFire;
  
  List<Bullet> _bullets;
  List<int> _toRemove;
  
  bool _isFromPlayer;
  
  Gun(double fireDelay, int amount, bool isFromPlayer){
    _fireDelay = fireDelay;
    _amount = amount;
    _timer = 0.0;
    _canFire = true;
    _isFromPlayer = isFromPlayer;
    
    _bullets = [];
    _toRemove = [];
  }
  
  void tick(final double delta, double x, double y){
    _timer += delta;
    
    if(!_canFire){
      if(_timer >= _fireDelay)
        _canFire = true;
    }else if(MouseManager.isPressed()){
      _fire(x, y);
      
      _canFire = false;
      _timer = 0.0;
    }
    
    if(_bullets.length > 0){
      for(int i = 0;i < _bullets.length;++i){
        if(_bullets[i].tick(delta))
          _toRemove.add(i);
      }
    }
    
    for(int i = 0;i < _toRemove.length;++i){
      if(_toRemove[i] < _bullets.length)
        _bullets.removeAt(_toRemove[i]);
    }
    _toRemove.clear();
    
  }
  
  void _fire(double x, double y){
    int mx = MouseManager.getX();
    int my = MouseManager.getY();
    
    double rad = atan2(my - y, mx - x);
    
    _bullets.add(new Bullet(x, y, rad, _isFromPlayer));
  }
  
  void render(CanvasRenderingContext2D g){
    g.fillStyle = "#222222";
    
    for(int i = 0;i < _bullets.length;++i){
      _bullets[i].render(g);
    }
  }
  
}