import 'package:get/get.dart';
import 'package:convenient_way_sender/app/bindings/controller_binding.dart';
import 'package:convenient_way_sender/app/bindings/local_bindings.dart';
import 'package:convenient_way_sender/app/bindings/repository_bindings.dart';

class InitialBinding implements Bindings {
  @override
  void dependencies() {
    RepositoryBindings().dependencies();
    LocalBindings().dependencies();
    ControllerBindings().dependencies();
  }
}
