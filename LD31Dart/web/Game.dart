library ld31_game;

import "dart:html";
import "KeyManager.dart";
import "State.dart";
import "GameState.dart";

class Game{
  
  static final int WIDTH = 720, HEIGHT = 480;
  
  int _lastTimestamp = 0;
  
  CanvasElement _canvas;
  CanvasRenderingContext2D g;
  
  static State gameState;
  
  Game(CanvasElement canvas){
    _canvas = canvas;
    canvas.width = WIDTH;
    canvas.height = HEIGHT;
    g = canvas.getContext("2d");
    canvas.focus();
    
    new KeyManager();
    
    //States
    gameState = new GameState();
    State.setState(gameState);
  }
  
  void _tick(final double delta){
    //Tick
    if(State.getState() != null)
      State.getState().tick(delta);
  }
  
  void _render(){
    //Clear
    g.fillStyle = "WHITE";
    g.fillRect(0, 0, WIDTH, HEIGHT);
    
    //Render
    if(State.getState() != null)
      State.getState().render(g);
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