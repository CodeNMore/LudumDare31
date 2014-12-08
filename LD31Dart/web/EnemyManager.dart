library ld31_enemy_manager;

import "dart:html";
import "Enemy.dart";
import "Player.dart";
import "ParticleEmitter.dart";
import "Gun.dart";
import "PlayerModule.dart";
import "Vector.dart";
import "Bomb.dart";
import "Sound.dart";

class EnemyManager{
  
  static List<Enemy> _enemies;
  static List<PlayerModule> _modules;
  static List<Bomb> _bombs;
  
  static List<Vector> _availableSlots = [
    new Vector(-20.0, 0.0, 0),
    new Vector(20.0, 0.0, 0),
    new Vector(0.0, -20.0, 0),
    new Vector(0.0, 20.0, 0),
    new Vector(-20.0, -20.0, 0),
    new Vector(20.0, -20.0, 0),
    new Vector(20.0, 20.0, 0),
    new Vector(-20.0, 20.0, 0)
  ];
  
  static List<Vector> _closedSlots;
  
  static Player _player;
  
  static void init(Player player){
    _enemies = [];
    _modules = [];
    _bombs = [];
    _player = player;
        
//    _enemies.add(new Enemy(100.0, 100.0, 3, 0, player));
//    _modules.add(new PlayerModule(_player, 20.0, 0.0, 100.0, 100.0));
  }
  
  static void tick(final double delta){
    for(int i = 0;i < _bombs.length;++i){
      if(_bombs[i].tick(delta)){
        _bombs.removeAt(i);
        i--;
      }
    }
    
    for(int i = 0;i < _enemies.length;++i){
      if(_enemies[i].tick(delta)){
        Gun.getEmitters().add(new ParticleEmitter(_enemies[i].getX(), _enemies[i].getY(), 8, 4, 4, _enemies[i].getMainColor(), 1, 2, 0, 360, 1, 1, 0.6));
        _enemies.removeAt(i);
        i--;
      }
    }
    
    for(int i = 0;i < _modules.length;++i){
      if(_modules[i].tick(delta)){
        _availableSlots.add(new Vector(_modules[i].getXOffset(), _modules[i].getYOffset(), 0));
        Sound.playHurtSound();
        _modules.removeAt(i);
        i--;
      }
    }
  }
  
  static void render(CanvasRenderingContext2D g){
    for(int i = 0;i < _bombs.length;++i){
      _bombs[i].render(g);
    }
    
    for(int i = 0;i < _enemies.length;++i){
      _enemies[i].render(g);
    }
    
    for(int i = 0;i < _modules.length;++i){
      _modules[i].render(g);
    }
  }
  
  static void collisionWithModule(){
    if(_modules.length > 0){
      Rectangle r = _player.getBounds();
      Rectangle r2;
      PlayerModule m;
      for(int i = 0;i < _modules.length;++i){
        m = _modules[i];
        r2 = m.getBounds();
        if(r.intersects(r2) && !m.isAttached()){
          m.setAttached(true);
          Sound.playAttatchSound();
        }
      }
    }
  }
  
  static void reset(){
    if(_availableSlots.length < 8){
      _availableSlots = [new Vector(-20.0, 0.0, 0),
        new Vector(20.0, 0.0, 0),
        new Vector(0.0, -20.0, 0),
        new Vector(0.0, 20.0, 0),
        new Vector(-20.0, -20.0, 0),
        new Vector(20.0, -20.0, 0),
        new Vector(20.0, 20.0, 0),
        new Vector(-20.0, 20.0, 0)
     ];
    }
    
    _modules.clear();
    _enemies.clear();
    _bombs.clear();
  }
  
  static bool isFinished(){
    return _enemies.length <= 0;
  }
  
  static void addEnemy(Enemy e){
    _enemies.add(e);
  }
  
  static void addModule(PlayerModule p){
    _modules.add(p);
  }
  
  static void addBomb(Bomb b){
    _bombs.add(b);
  }
  
  static List<Bomb> getBombs() => _bombs;
  static List<Vector> getAvailableSlots() => _availableSlots;
  static List<Enemy> getEnemies() => _enemies;
  
}