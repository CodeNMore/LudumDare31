library ld31_vector;

class Vector{
  
  double _x, _y;
  int _z;
  
  Vector(double x, double y, int z){
    _x = x;
    _y = y;
    _z = z;
  }
  
  double getX() => _x;
  double getY() => _y;
  int getZ() => _z;
  void setX(double x){
    _x = x;
  }
  void setY(double y){
    _y = y;
  }
  void setZ(int z){
    _z = z;
  }
  
}