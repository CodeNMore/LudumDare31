library ld31_game;

import "dart:html";
import "ParticleEmitter.dart";

class Game{
  
  static final int WIDTH = 720, HEIGHT = 480;
  
  int _lastTimestamp = 0;
  
  CanvasElement _canvas;
  CanvasRenderingContext2D g;
  
  ParticleEmitter pe;
  
  Game(CanvasElement canvas){
    _canvas = canvas;
    canvas.width = WIDTH;
    canvas.height = HEIGHT;
    g = canvas.getContext("2d");
    canvas.focus();
    
    pe = new ParticleEmitter(200.0, 200.0, 100, 20, 20, "#FFFF00",
        1, 2, 0, 90, 2, 6);
  }
  
  void _tick(final double delta){
    pe.tick(delta);
  }
  
  void _render(){
    g.fillStyle = "BLACK";
    g.fillRect(0, 0, WIDTH, HEIGHT);
    
    pe.render(g);
  }
  
  void _loop(final double _d){
    _tick(_getTime());
    _render();
    window.requestAnimationFrame(_loop);
  }
  
  double _getTime(){
    final int time = new DateTime.now().millisecondsSinceEpoch;
    
    double elapsed = 0.0;
    if(_lastTimestamp != 0){
      elapsed = (time - _lastTimestamp) / 1000.0;
    }
    
    _lastTimestamp = time;
    return elapsed;
  }
  
  void start(){
    window.requestAnimationFrame(_loop);
  }
  
}