library ld31_sound;

import "dart:html";

class Sound{
  
  static AudioElement hurtSound, explosionSound, attatchSound;
  static AudioElement ahurtSound, aexplosionSound, aattatchSound;
  
  static void load(){
    ahurtSound = new AudioElement("res/hurt.wav")..load();
    aexplosionSound = new AudioElement("res/explosion.wav")..load();
    aattatchSound = new AudioElement("res/attatch.wav")..load();
  }
  
  static void playHurtSound(){
    hurtSound = ahurtSound.clone(false);
    hurtSound.play();
  }
  
  static void playExplosionSound(){
      explosionSound = aexplosionSound.clone(false);
      explosionSound.play();
    }
  
  static void playAttatchSound(){
      attatchSound = aattatchSound.clone(false);
      attatchSound.play();
    }
  
}