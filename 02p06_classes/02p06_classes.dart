abstract class Phone {
  String get osType;
  Camera? get camera;
}

class AndroidPhone extends Phone {
  static const _osType = 'Android';

  final Camera? camera;

  AndroidPhone([this.camera]);

  AndroidPhone.withCameraFl(double fl) : this(Camera(fl));

  @override
  String get osType => _osType;
}

class Camera {
  final double _focalLength;

  Camera(this._focalLength);

  void takeShot() {
    print("A shot with FL=${_focalLength} taken");
  }
}

void main() {
  final phone12 = AndroidPhone(Camera(12));
  print("This phone os type is ${phone12.osType}.");
  phone12.camera?.takeShot();

  final phone8 = AndroidPhone.withCameraFl(8);
  phone8.camera?.takeShot();
}
