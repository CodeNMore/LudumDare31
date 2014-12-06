library ld31_particleEmitter;

import "dart:html";
import "dart:math";
import "Particle.dart";

class ParticleEmitter{
  
  List<Particle> _particles;
  List<int> _toRemove;
  
  double _x, _y;
  String _style;
  int _amount, _generated, _removed;
  int _particleWidth, _particleHeight;
  int _minSpeed, _maxSpeed, _minAngle, _maxAngle, _minLife, _maxLife;
  double _stableLife;
  
  ParticleEmitter(double x, double y, int amount, int particleWidth, int particleHeight, String style,
      int minSpeed, int maxSpeed, int minAngle, int maxAngle, int minLife, int maxLife, double stableLife){
    _particles = [];
    _toRemove = [];
    
    _x = x;
    _y = y;
    _amount = amount;
    _particleWidth = particleWidth;
    _particleHeight = particleHeight;
    _style = style;
    _minSpeed = minSpeed;
    _maxSpeed = maxSpeed;
    _minAngle = minAngle;
    _maxAngle = maxAngle;
    _minLife = minLife;
    _maxLife = maxLife;
    _stableLife = stableLife;
    
    _generated = 0;
    _removed = 0;
  }
  
  bool tick(final double delta){
    if(_amount == -1 || _generated < _amount){
      _emit();
      _generated++;
    }
    
    for(int i = 0;i < _particles.length;++i){
      if(_particles[i].tick(delta))
        _toRemove.add(i);
    }
    
    for(int i = 0;i < _toRemove.length;++i){
      if(_toRemove[i] < _particles.length)
        _particles.removeAt(_toRemove[i]);
    }
    _toRemove.clear();
    
    if(_particles.length <= 0)
      return true;
    return false;
  }
  
  void render(CanvasRenderingContext2D g){
    g.fillStyle = _style;
    
    for(int i = 0;i < _particles.length;++i)
      _particles[i].render(g, _particleWidth, _particleHeight);
  }
  
  void _emit(){
    if(_stableLife == 0)
      _particles.add(new Particle(_x, _y, _randomize(_minAngle, _maxAngle), _randomize(_minSpeed, _maxSpeed), _randomize(_minLife, _maxLife) + 0.0));
    else
      _particles.add(new Particle(_x, _y, _randomize(_minAngle, _maxAngle), _randomize(_minSpeed, _maxSpeed), _stableLife));
  }
  
  int _randomize(int min, int max){
    var r = new Random();
    return r.nextInt((max - min) + 1) + min;
  }
  
  void setPos(double x, double y){
    _x = x;
    _y = y;
  }
  
}