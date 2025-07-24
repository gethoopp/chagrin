// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'routes.dart';

/// generated route for
/// [LoginScreenAuth]
class LoginRouteRoute extends PageRouteInfo<void> {
  const LoginRouteRoute({List<PageRouteInfo>? children})
    : super(LoginRouteRoute.name, initialChildren: children);

  static const String name = 'LoginRouteRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const LoginScreenAuth();
    },
  );
}

/// generated route for
/// [ResgisteAuth]
class ResgisteRoute extends PageRouteInfo<ResgisteRouteArgs> {
  ResgisteRoute({
    Key? key,
    required AuthRepository authRepository,
    List<PageRouteInfo>? children,
  }) : super(
         ResgisteRoute.name,
         args: ResgisteRouteArgs(key: key, authRepository: authRepository),
         initialChildren: children,
       );

  static const String name = 'ResgisteRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ResgisteRouteArgs>();
      return ResgisteAuth(key: args.key, authRepository: args.authRepository);
    },
  );
}

class ResgisteRouteArgs {
  const ResgisteRouteArgs({this.key, required this.authRepository});

  final Key? key;

  final AuthRepository authRepository;

  @override
  String toString() {
    return 'ResgisteRouteArgs{key: $key, authRepository: $authRepository}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! ResgisteRouteArgs) return false;
    return key == other.key && authRepository == other.authRepository;
  }

  @override
  int get hashCode => key.hashCode ^ authRepository.hashCode;
}

/// generated route for
/// [SplashScreen]
class SplashRoute extends PageRouteInfo<void> {
  const SplashRoute({List<PageRouteInfo>? children})
    : super(SplashRoute.name, initialChildren: children);

  static const String name = 'SplashRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const SplashScreen();
    },
  );
}
