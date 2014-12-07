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
  static List<ParticleEmitter> _emitters;
  
  bool _isFromPlayer;
  
  Gun(double fireDelay, bool isFromPlayer){
    _fireDelay = fireDelay;
    _timer = 0.0;
    _canFire = true;
    _isFromPlayer = isFromPlayer;
    
    _bullets = [];
    _emitters = [];
  }
  
  void tickPlayer(final double delta, double x, double y, int offset){
    _timer += delta;
    
    if(!_canFire){
      if(_timer >= _fireDelay)
        _canFire = true;
    }else if(MouseManager.isPressed()){
      _fire(MouseManager.getX() + offset, MouseManager.getY(), x, y);
      
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
         if(_bullets[i].tick(delta)){
           _bullets.removeAt(i);
           i--;
         }
       }
     }
    
    if(_emitters.length > 0){
      for(int i = 0;i < _emitters.length;++i){
        if(_emitters[i].tick(delta)){
          _emitters.removeAt(i);
          i--;
        }
      }
    }
  }
  
  void _fire(int mx, int my, double x, double y){
    double rad = atan2(my - y, mx - x);
    
    _bullets.add(new Bullet(x, y, rad, _isFromPlayer));
  }
  
  static int collision(Rectangle r, bool isPlayer){
    Rectangle r2;
    Bullet b;
    int timesCollided = 0;
    
    if(_bullets.length > 0){
      for(int i = 0;i < _bullets.length;++i){
       b = _bullets[i];
       if((isPlayer && !b.isFromPlayer()) || (!isPlayer && b.isFromPlayer())){
         r2 = new Rectangle(b.getX(), b.getY(), b.getWidth(), b.getHeight());
         if(r2.intersects(r)){//COLLISION!
           timesCollided++;
           _emitters.add(new ParticleEmitter(b.getX(), b.getY(), 16, 4, 4, "#333333", 1, 1, 0, 360, 1, 1, 0.5));
           _bullets.removeAt(i);
           i--;
         }
       }
      }
    }
    
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
  
  static List<ParticleEmitter> getEmitters(){
    return _emitters;
  }
  
}