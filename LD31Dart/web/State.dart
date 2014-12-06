library ld31_state;

import "dart:html";

abstract class State{
  
  static State _state;
  
  static State getState(){
    return _state;
  }
  
  static void setState(State s){
    if(_state != null)
      _state.onHide();
    _state = s;
    if(s != null)
      s.onShow();
  }
  
  void tick(final double delta){}
  
  void render(CanvasRenderingContext2D g){}
  
  void onShow(){}
  
  void onHide(){}
  
}