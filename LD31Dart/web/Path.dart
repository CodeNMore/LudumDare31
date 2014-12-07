library ld31_path;

import "dart:math";
import "Vector.dart";
import "Enemy.dart";

class Path{
  
  //Static paths
  
  static List<Vector> _circlePathCoordinates = [
    new Vector(83.0, 68.0, 0),
    new Vector(191.0, 33.0, 0),
    new Vector(328.0, 32.0, 0),
    new Vector(540.0, 34.0, 0),
    new Vector(698.0, 113.0, 0),
    new Vector(735.0, 298.0, 0),
    new Vector(697.0, 496.0, 0),
    new Vector(447.0, 537.0, 0),
    new Vector(175.0, 532.0, 0),
    new Vector(84.0, 386.0, 0),
    new Vector(70.0, 201.0, 0)
  ];
  static Path _circlePath = new Path(_circlePathCoordinates);
  
  static List<Vector> _diag1PathCoordinates = [
      new Vector(84.0, 536.0, 0),
      new Vector(118.0, 447.0, 0),
      new Vector(173.0, 367.0, 0),
      new Vector(321.0, 330.0, 0),
      new Vector(470.0, 201.0, 0),
      new Vector(571.0, 131.0, 0),
      new Vector(707.0, 61.0, 0)
    ];
    static Path _diag1Path = new Path(_diag1PathCoordinates);
  
  static List<Path> paths = [
    _circlePath, _diag1Path
  ];
  
  //End
  
  int _threshhold = 8;
  List<Vector> _coords;
  Vector _resultVector;
  
  Path(List<Vector> coords){
    _coords = coords;
    _resultVector = new Vector(0.0, 0.0, 0);
  }
  
  Vector moveAlongPath(double x, double y, int index){
    if(index >= _coords.length)
      index = 0;
    else if(index < 0)
      index = _coords.length - 1;

    double tx = _coords[index].getX();
    double ty = _coords[index].getY();
    
    double angle = atan2(ty - y, tx - x);
    _resultVector.setX(cos(angle));
    _resultVector.setY(sin(angle));
    
    if(x > tx - _threshhold && x < tx + _threshhold){
      if(y > ty - _threshhold && y < ty + _threshhold){
        _resultVector.setZ(index + 1);
      }else{
        _resultVector.setZ(index);
      }
    }else{
      _resultVector.setZ(index);
    }
    
    return _resultVector;
  }
  
}