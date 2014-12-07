library ld31_hud;

import "dart:html";
import "Game.dart";

class HUD{
  
  static final int HUDHEIGHT = 32;
  
  static int HEALTH_BAR_WIDTH = 200;
  int _health, _maxHealth;
  
  CanvasElement _canvas;
  CanvasRenderingContext2D g2;
  
  HUD(CanvasElement canvas){
    _canvas = canvas;
    canvas.width = Game.WIDTH;
    canvas.height = HUDHEIGHT;
    g2 = canvas.getContext("2d");
    g2.font = "30px Arial";
    
    _maxHealth = 100;
    _health = 100;
  }
  
  void tick(final double delta){
    if(_health < 0){
      _health = 0;
    }
  }
  
  void render(){
    g2.fillStyle = "#CCCCCC";
    g2.fillRect(0, 0, Game.WIDTH, HUDHEIGHT);
    g2.fillStyle = "#333333";
    g2.fillText("Health:", 2, 26);
    
    g2.fillStyle = "#999999";
    g2.fillRect(108, 3, HEALTH_BAR_WIDTH, HUDHEIGHT - 6);
    g2.fillStyle = "#00FF00";
    g2.fillRect(110, 4, _health / _maxHealth * (HEALTH_BAR_WIDTH - 4), HUDHEIGHT - 8);
  }
  
  void setHealth(int health){
    _health = health;
  }
  
  void setMaxHealth(int max){
    _maxHealth = max;
  }
  
}