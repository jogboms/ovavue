xcode:
	open ios/Runner.xcworkspace

install:
	fvm flutter pub get

ci:
	make format && make analyze && make test_coverage

format:
	fvm dart format --set-exit-if-changed lib

analyze:
	fvm flutter analyze lib

test_coverage:
	fvm flutter test --no-pub --coverage --test-randomize-ordering-seed random

clean_coverage:
	lcov --remove coverage/lcov.info 'lib/**/*.g.dart' 'lib/**/*_mock_impl.dart' 'lib/presentation/theme/*' 'lib/presentation/constants/*' -o coverage/lcov.info

build_coverage:
	make test_coverage && make clean_coverage && genhtml -o coverage coverage/lcov.info

open_coverage:
	make build_coverage && open coverage/index.html

generate_intl:
	fvm flutter gen-l10n

build_runner_build:
	fvm dart run build_runner build -d

build_runner_watch:
	fvm dart run build_runner watch -d

# iOS
mock_ios:
	fvm flutter build ios --flavor mock

dev_ios:
	fvm flutter build ios --flavor dev

prod_ios:
	fvm flutter build ios --flavor prod

# Android
mock_android:
	fvm flutter build apk --flavor mock

dev_android:
	fvm flutter build apk --flavor dev

prod_android:
	fvm flutter build apk --flavor prod

prod_android_bundle:
	fvm flutter build appbundle --flavor prod

# Web
mock_web:
	fvm flutter build web --release

dev_web:
	fvm flutter build web --release

prod_web:
	fvm flutter build web --release

serve_web:
	python3 -m http.server 8000 -d ./build/web/
