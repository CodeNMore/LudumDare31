library ld31_entity_player;

import "dart:html";
import "Game.dart";
import "KeyManager.dart";
import "Gun.dart";
import "ParticleEmitter.dart";
import "HUD.dart";
import "EnemyManager.dart";
import "State.dart";
import "DeathState.dart";
import "Bomb.dart";
import "Sound.dart";

class Player {
  
  int _health = 130, _maxHealth = 130;
  int _width = 20, _height = 20;
  double _x, _y, _xSpeed, _ySpeed;
  double _moveSpeed = 1.0, _maxSpeed = 6.0;
  double _friction = 0.3;
  int _type = 0;
  HUD _hud;
  double _bombTimer = 0.0;
  ParticleEmitter trail;
  
  Gun _gun;
  
  Rectangle bounds;
  
  Player(double x, double y, HUD hud){
    _x = x;
    _y = y;
    _hud = hud;
    _xSpeed = 0.0;
    _ySpeed = 0.0;
    _hud.setHealth(_health);
    _hud.setMaxHealth(_maxHealth);
    
    trail = new ParticleEmitter(_x, _y, -1, 3, 3, "#FF33FF", 1, 2, 0, 360, 1, 1, 0.5);
    
    _gun = new Gun(0.45, true);//.35
    
    bounds = new Rectangle(_x, _y, _width, _height);
  }
  
  void tick(final double delta){
    _bombTimer += delta;
    
    _gun.tickPlayer(delta, _x + _width / 2, _y + _height / 2, 0, 0);
    
    _handleInput();
    _tickFriction();
    _finalMove();
    
    trail.setPos(_x + _width / 2, _y + _height / 2);
    trail.tick(delta);
    
    int times = Gun.collision(getBounds(), true);
    EnemyManager.collisionWithModule();
    
    _health -= times * 10;
    _hud.setHealth(_health);
    if(_health <= 0){
      die();
    }
    
    if(times > 0)
      Sound.playHurtSound();
  }
      
  void render(CanvasRenderingContext2D g){
    g.fillStyle = "#FF00FF";
    g.fillRect(_x, _y, _width, _height);
    trail.render(g);
  }
  
  void die(){
    DeathState.setWave(_hud.getWave());
    State.setState(Game.deathState);
    Sound.playExplosionSound();
  }
  
  void _finalMove(){
    if(_x + _xSpeed < 0){
      _x = 0.0;
//      _xSpeed = 0.0;
    }else if(_x + _width + _xSpeed >= Game.WIDTH){
      _x = Game.WIDTH - _width - 0.0;
//      _xSpeed = 0.0;
    }
    if(_y + _ySpeed < 0){
      _y = 0.0;
//      _ySpeed = 0.0;
    }else if(_y + _height + _ySpeed >= Game.HEIGHT){
      _y = Game.HEIGHT - _height - 0.0;
//      _ySpeed = 0.0;
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
  
  void _handleInput(){
    if(KeyManager.isPressed(KeyCode.A) || KeyManager.isPressed(KeyCode.LEFT)){
      _xSpeed -= _moveSpeed;
      if(_xSpeed < -_maxSpeed)
        _xSpeed = -_maxSpeed;
    }else if(KeyManager.isPressed(KeyCode.D) || KeyManager.isPressed(KeyCode.RIGHT)){
      _xSpeed += _moveSpeed;
      if(_xSpeed > _maxSpeed)
        _xSpeed = _maxSpeed;
    }
    
    if(KeyManager.isPressed(KeyCode.W) || KeyManager.isPressed(KeyCode.UP)){
      _ySpeed -= _moveSpeed;
      if(_ySpeed < -_maxSpeed)
        _ySpeed = -_maxSpeed;
    }else if(KeyManager.isPressed(KeyCode.S) || KeyManager.isPressed(KeyCode.DOWN)){
      _ySpeed += _moveSpeed;
       if(_ySpeed > _maxSpeed)
        _ySpeed = _maxSpeed;
    }
    
    if(_bombTimer > 1.5 && KeyManager.isPressed(KeyCode.SPACE) && _hud.getBombs() > 0){
      _hud.setBombs(_hud.getBombs() - 1);
      EnemyManager.addBomb(new Bomb(_x, _y));
      _bombTimer = 0.0;
    }
  }
  
  void reset(){
    _x = Game.WIDTH / 2;
    _y = Game.HEIGHT / 2;
    _xSpeed = 0.0;
    _ySpeed = 0.0;
    _gun.resetInstance();
    _health = _maxHealth;
    _bombTimer = 0.0;
  }
  
  Rectangle getBounds(){
    return (bounds = new Rectangle(_x, _y, _width, _height));
  }
  
  double getX() => _x;
  double getY() => _y;
  int getWidth() => _width;
  int getHeight() => _height;
  int getHealth() => _health;
  
}