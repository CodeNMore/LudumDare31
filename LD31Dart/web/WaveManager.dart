library ld31_wave_manager;

import "dart:html";
import "dart:math";
import "EnemyManager.dart";
import "Player.dart";
import "Game.dart";
import "HUD.dart";
import "Enemy.dart";
import "Vector.dart";
import "PlayerModule.dart";

class WaveManager{
  
  Player _player;
  HUD _hud;
  int _wave;
  double _timer;
  int _waveWaitTime;
  bool _doDisplay, _once;
  Vector _tempVector;
  
  WaveManager(Player player, HUD hud){
    _wave = 0;
    _timer = 0.0;
    _waveWaitTime = 5;
    _doDisplay = true;
    _player = player;
    _hud = hud;
    _once = false;
  }
  
  void tick(final double delta){
    _timer += delta;
    
    if(EnemyManager.isFinished()){//NEXT WAVE!
      if(!_once){
        _once = true;
        _timer = 0.0;
        _wave++;
        _hud.setWave(_wave);
      }
      if(_timer > _waveWaitTime){//Generate Wave!
        var r = new Random();
        for(int i = 0;i < _wave;++i){
          EnemyManager.addEnemy(new Enemy(r.nextInt(Game.WIDTH - 30 + 1)+ 0.0, r.nextInt(Game.HEIGHT - 30 + 1)+ 0.0,
              r.nextInt(3) + 1, _wave, _player));
        }
        if((_wave > 6) || (_wave % 2 == 0 && EnemyManager.getAvailableSlots().length > 0)){
          _tempVector = EnemyManager.getAvailableSlots()[0];
          EnemyManager.getAvailableSlots().removeAt(0);
          EnemyManager.addModule(new PlayerModule(_player, r.nextInt(Game.WIDTH - 30 + 1)+ 0.0, r.nextInt(Game.HEIGHT - 30 + 1)+ 0.0, _tempVector.getX(), _tempVector.getY()));
        }
        if(_wave > 12){
          if(_wave % 3 == 0){
            _hud.addBomb();
          }
        }else if(_wave % 4 == 0){
          _hud.addBomb();
        }
        
        _once = false;
        _doDisplay = false;
      }else{//Display Next!
        _doDisplay = true;
      }
    }else{
      _once = false;
    }
  }
  
  void render(CanvasRenderingContext2D g){
    if(_doDisplay){//Display Message!
      g.font = "56px Arial";
      g.fillStyle = "#333333";
      g.fillText("Next Wave Coming - " + (_waveWaitTime - _timer.round()).toString() + "!", Game.WIDTH / 2 - 300, Game.HEIGHT / 2);
    }
  }
  
  void reset(){
    _wave = 0;
    _once = false;
    _timer = 0.0;
    _doDisplay = true;
  }
  
}