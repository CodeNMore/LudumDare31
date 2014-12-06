library ld31_key;

import "dart:html";
import "dart:collection";

class KeyManager{
  
  static final HashSet<int> _keys = new HashSet<int>();
  
  KeyManager(){
    window.onKeyDown.listen((final KeyboardEvent e){
      _keys.add(e.keyCode);
    });
    
    window.onKeyUp.listen((final KeyboardEvent e){
      _keys.remove(e.keyCode);
    });
  }
  
  static isPressed(final int keyCode) => _keys.contains(keyCode);
  
}