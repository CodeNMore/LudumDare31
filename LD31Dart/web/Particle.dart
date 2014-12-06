library ld31_particle;

import "dart:html";
import "dart:math";

class Particle{
  
  double _x, _y;
  double _xSpeed, _ySpeed;
  int _life;
  double _timer;
  String _style;
  
  Particle(double x, double y, int degAngle, int speed, int life){
    _x = x;
    _y = y;
    _life = life;
    _timer = 0.0;
    
    num angleR = degAngle * PI / 180;
    
    _xSpeed = speed * cos(angleR);
    _ySpeed = -speed * sin(angleR);
  }
  
  bool tick(final double delta){
    _timer += delta;
    if(_timer > _life)
      return true;
    
    _x += _xSpeed;
    _y += _ySpeed;
    
    return false;
  }
  
  void render(CanvasRenderingContext2D g, int width, int height){
    g.fillRect(_x, _y, width, height);
  }
  
}