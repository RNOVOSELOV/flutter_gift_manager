import 'package:get_it/get_it.dart';
import 'package:gift_manager/data/http/authorization_interceptor.dart';
import 'package:gift_manager/data/http/authorized_api_service.dart';
import 'package:gift_manager/data/http/dio_builder.dart';
import 'package:gift_manager/data/http/unauthorized_api_service.dart';
import 'package:gift_manager/data/repository/refresh_token_provider.dart';
import 'package:gift_manager/data/repository/refresh_token_repository.dart';
import 'package:gift_manager/data/repository/settings_repository.dart';
import 'package:gift_manager/data/repository/token_repository.dart';
import 'package:gift_manager/data/repository/user_repository.dart';
import 'package:gift_manager/data/storage/shared_preference_data.dart';
import 'package:gift_manager/domain/logout_interactor.dart';
import 'package:gift_manager/presentation/gift/bloc/gift_bloc.dart';
import 'package:gift_manager/presentation/gifts/bloc/gifts_bloc.dart';
import 'package:gift_manager/presentation/home/bloc/home_bloc.dart';
import 'package:gift_manager/presentation/login/bloc/login_bloc.dart';
import 'package:gift_manager/presentation/registration/bloc/registration_bloc.dart';
import 'package:gift_manager/presentation/settings/bloc/settings_bloc.dart';
import 'package:gift_manager/presentation/splash/bloc/splash_bloc.dart';
import 'package:gift_manager/presentation/theme/custom_theme.dart';

final sl = GetIt.instance;

void initServiceLocator() {
  _setupDataProviders();
  _setupRepositories();
  _setupInteractors();
  _setupComplexInteractors();
  _setupApiRelatesClasses();
  _setupBlocks();
}

// ONLY SINGLETONS
void _setupDataProviders() {
  sl.registerLazySingleton(() => SharedPreferenceData());
  sl.registerLazySingleton<RefreshTokenProvider>(
    () => sl.get<SharedPreferenceData>(),
  );
}

// ONLY SINGLETONS
void _setupRepositories() {
  sl.registerLazySingleton(
    () => RefreshTokenRepository(sl.get<RefreshTokenProvider>()),
  );
  sl.registerLazySingleton(
    () => TokenRepository(sl.get<SharedPreferenceData>()),
  );
  sl.registerLazySingleton(
    () => UserRepository(sl.get<SharedPreferenceData>()),
  );
  sl.registerLazySingleton(
    () => SettingsRepository(sl.get<SharedPreferenceData>()),
  );
}

// ONLY SINGLETONS
void _setupInteractors() {
  sl.registerLazySingleton(() => LogoutInteractor(
        userRepository: sl.get<UserRepository>(),
        tokenRepository: sl.get<TokenRepository>(),
        refreshTokenRepository: sl.get<RefreshTokenRepository>(),
      ));
  sl.registerLazySingleton(
      () => CustomTheme(settingsRepository: sl.get<SettingsRepository>()));
}

// ONLY SINGLETONS
void _setupComplexInteractors() {}

void _setupApiRelatesClasses() {
  sl.registerFactory(() => DioBuilder());
  sl.registerLazySingleton(() => AuthorizationInterceptor(
      tokenRepository: sl.get<TokenRepository>(),
      logoutInteractor: sl.get<LogoutInteractor>()));
  sl.registerLazySingleton(
      () => UnauthorizedApiService(sl.get<DioBuilder>().build()));
  sl.registerLazySingleton(() => AuthorizedApiService(sl
      .get<DioBuilder>()
      .addAuthorizationInterceptor(sl.get<AuthorizationInterceptor>())
      .addHeaderPostmanParameters()
      .build()));
}

// ONLY FACTORIES
void _setupBlocks() {
  sl.registerFactory(() => LoginBloc(
        userRepository: sl.get<UserRepository>(),
        refreshTokenRepository: sl.get<RefreshTokenRepository>(),
        tokenRepository: sl.get<TokenRepository>(),
        unauthorizedApiService: sl.get<UnauthorizedApiService>(),
      ));
  sl.registerFactory(() => RegistrationBloc(
        userRepository: sl.get<UserRepository>(),
        refreshTokenRepository: sl.get<RefreshTokenRepository>(),
        tokenRepository: sl.get<TokenRepository>(),
        unauthorizedApiService: sl.get<UnauthorizedApiService>(),
      ));
  sl.registerFactory(
      () => SplashBloc(tokenRepository: sl.get<TokenRepository>()));
  sl.registerFactory(() => HomeBloc(
        userRepository: sl.get<UserRepository>(),
        logoutInteractor: sl.get<LogoutInteractor>(),
        authorizedApiService: sl.get<AuthorizedApiService>(),
        unauthorizedApiService: sl.get<UnauthorizedApiService>(),
        tokenRepository: sl.get<TokenRepository>(),
        refreshTokenRepository: sl.get<RefreshTokenRepository>(),
      ));
  sl.registerFactory(
      () => GiftsBloc(authorizedApiService: sl.get<AuthorizedApiService>()));
  sl.registerFactory(() => SettingsBloc(
        userRepository: sl.get<UserRepository>(),
        settingsRepository: sl.get<SettingsRepository>(),
        logoutInteractor: sl.get<LogoutInteractor>(),
        customTheme: sl.get<CustomTheme>(),
      ));
  sl.registerFactory(() => GiftBloc());
}
