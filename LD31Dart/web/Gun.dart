library ld31_gun;

import "dart:html";
import "dart:math";
import "MouseManager.dart";
import "Bullet.dart";
import "ParticleEmitter.dart";

class Gun{
  
  double _fireDelay;
  double _timer;
  bool _canFire;
  
  static List<Bullet> _bullets;
  static List<int> _toRemove, _toRemoveEmitters;
  static List<ParticleEmitter> _emitters;
  
  bool _isFromPlayer;
  
  Gun(double fireDelay, bool isFromPlayer){
    _fireDelay = fireDelay;
    _timer = 0.0;
    _canFire = true;
    _isFromPlayer = isFromPlayer;
    
    _bullets = [];
    _toRemove = [];
    _toRemoveEmitters = [];
    _emitters = [];
  }
  
  void tickPlayer(final double delta, double x, double y){
    _timer += delta;
    
    if(!_canFire){
      if(_timer >= _fireDelay)
        _canFire = true;
    }else if(MouseManager.isPressed()){
      _fire(MouseManager.getX(), MouseManager.getY(), x, y);
      
      _canFire = false;
      _timer = 0.0;
    }
    
  }
  
  void tick(final double delta, int mx, int my, double x, double y, bool shoot){
    _timer += delta;
    
    if(!_canFire){
      if(_timer >= _fireDelay)
        _canFire = true;
    }else if(shoot){
      _fire(mx, my, x, y);
      
      _canFire = false;
      _timer = 0.0;
    }
  }
  
  static void tickBullets(final double delta){
    if(_bullets.length > 0){
       for(int i = 0;i < _bullets.length;++i){
         if(_bullets[i].tick(delta))
           _toRemove.add(i);
       }
     }
    
    if(_emitters.length > 0){
      for(int i = 0;i < _emitters.length;++i){
        if(_emitters[i].tick(delta))
          _toRemoveEmitters.add(i);
      }
    }
       
     iterateToRemove();
  }
  
  void _fire(int mx, int my, double x, double y){
    double rad = atan2(my - y, mx - x);
    
    _bullets.add(new Bullet(x, y, rad, _isFromPlayer));
  }
  
  static void iterateToRemove(){
    for(int i = 0;i < _toRemove.length;++i){
      if(_toRemove[i] < _bullets.length)
        _bullets.removeAt(_toRemove[i]);
    }
    _toRemove.clear();
    
    for(int i = 0;i < _toRemoveEmitters.length;++i){
      if(_toRemoveEmitters[i] < _emitters.length)
        _emitters.removeAt(_toRemoveEmitters[i]);
    }
    _toRemoveEmitters.clear();
  }
  
  static int collision(Rectangle r, bool isPlayer){
    Rectangle r2;
    Bullet b;
    int timesCollided = 0;
    
    for(int i = 0;i < _bullets.length;++i){
      b = _bullets[i];
      if((isPlayer && !b.isFromPlayer()) || (!isPlayer && b.isFromPlayer())){
        r2 = new Rectangle(b.getX(), b.getY(), b.getWidth(), b.getHeight());
        if(r2.intersects(r)){//COLLISION!
          timesCollided++;
          _toRemove.add(i);
          _emitters.add(new ParticleEmitter(b.getX(), b.getY(), 8, 4, 4, "#333333", 1, 1, 0, 360, 1, 1, 0.5));
        }
      }
    }
    
    iterateToRemove();
    
    return timesCollided;
  }
  
//  static void fireTest(double x, double y){
//        double rad = atan2(y, x);
//        _bullets.add(new Bullet(x, y, rad, false));
//  }
  
  static void renderBullets(CanvasRenderingContext2D g){
    g.fillStyle = "#222222";
    
    for(int i = 0;i < _bullets.length;++i){
      _bullets[i].render(g);
    }
    
    for(int i = 0;i < _emitters.length;++i){
      _emitters[i].render(g);
    }
  }
  
}