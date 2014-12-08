library ld31_bomb;

import "dart:html";
import "EnemyManager.dart";
import "Enemy.dart";
import "Sound.dart";

class Bomb{
  
  double _timer;
  double _blowTime = 2.5;
  double _x, _y;
  double _anim = 0.0;
  double _animIncrement = 9.5;
  int _width = 14, _height = 14;
  int _radius = 164;
  bool _blown, _done;
  
  Bomb(double x, double y){
    _x = x;
    _y = y;
    _timer = 0.0;
    _blown = false;
    _done = false;
  }
  
  bool tick(final double delta){
    _timer += delta;
    
    if(!_blown && _timer > _blowTime){
      _blow();
      _blown = true;
      Sound.playExplosionSound();
    }
    
    if(_blown && !_done){
      _anim += _animIncrement;
      
      if(_anim > _radius)
        _done = true;
    }
    
    if(_blown && _done)
      return true;
    
    return false;
  }
  
  void _blow(){
    List<Enemy> enemies = EnemyManager.getEnemies();
    Rectangle r = getBounds();
    Rectangle r2;
    if(enemies.length > 0){
      for(int i = 0;i < enemies.length;i++){
        r2 = enemies[i].getBounds();
        if(r.intersects(r2)){
          enemies[i].setHealth(0);
        }
      }
    }
  }
  
  Rectangle getBounds(){
    return new Rectangle(_x - _radius / 2, _y - _radius / 2, _width + _radius, _height + _radius);
  }
  
  void render(CanvasRenderingContext2D g){
    g.fillStyle = "#000000";
    if(_anim == 0)
      g.fillRect(_x - _anim / 2, _y - _anim / 2, _width + _anim, _height + _anim);
    else{
      g.strokeStyle = "#000000";
      g.beginPath();
      g.rect(_x - _anim / 2, _y - _anim / 2, _width + _anim, _height + _anim);
      g.stroke();
    }
  }
  
}