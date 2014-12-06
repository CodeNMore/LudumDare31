library ld31;

import "dart:html";
import "Game.dart";

void main(){
  Game game = new Game(querySelector("#frame"));
  game.start();
}