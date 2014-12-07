library ld31_enemy_manager;

import "dart:html";
import "Enemy.dart";
import "Player.dart";
import "ParticleEmitter.dart";
import "Gun.dart";
import "PlayerModule.dart";

//TODO: Waves

class EnemyManager{
  
  static List<Enemy> _enemies;
  static List<PlayerModule> _modules;
  
  static Player _player;
  
  static void init(Player player){
    _enemies = [];
    _modules = [];
    _player = player;
        
//    _enemies.add(new Enemy(100.0, 100.0, 3, 0, player));
    _enemies.add(new Enemy(200.0, 200.0, 2, 0, player));
    _enemies.add(new Enemy(300.0, 300.0, 1, 0, player));
    _modules.add(new PlayerModule(_player, 20.0, 0.0, 100.0, 100.0));
  }
  
  static void tick(final double delta){
    for(int i = 0;i < _enemies.length;++i){
      if(_enemies[i].tick(delta)){
        Gun.getEmitters().add(new ParticleEmitter(_enemies[i].getX(), _enemies[i].getY(), 8, 4, 4, _enemies[i].getMainColor(), 1, 2, 0, 360, 1, 1, 0.6));
        _enemies.removeAt(i);
        i--;
      }
    }
    
    for(int i = 0;i < _modules.length;++i){
      if(_modules[i].tick(delta)){
        _modules.removeAt(i);
        i--;
      }
    }
  }
  
  static void render(CanvasRenderingContext2D g){
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
        }
      }
    }
  }
  
}