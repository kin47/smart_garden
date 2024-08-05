.PHONY: all run_dev_web run_dev_mobile run_unit clean upgrade lint format build_dev_mobile help watch gen run_stg_mobile run_prd_mobile build_apk_dev build_apk_stg build_apk_prd purge build build_apk_dev build_apk_stg build_apk_prod export_index create_build version_change_logs build_runner_with_filter build_assets rename_files auto_fix create_test_report fix_import translate copy_test_to_integration

all: lint format run_dev_mobile

# Adding a help file: https://gist.github.com/prwhite/8168133#gistcomment-1313022
help: ## This help dialog.
	@IFS=$$'\n' ; \
	help_lines=(`fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//'`); \
	for help_line in $${help_lines[@]}; do \
		IFS=$$'#' ; \
		help_split=($$help_line) ; \
		help_command=`echo $${help_split[0]} | sed -e 's/^ *//' -e 's/ *$$//'` ; \
		help_info=`echo $${help_split[2]} | sed -e 's/^ *//' -e 's/ *$$//'` ; \
		printf "%-30s %s\n" $$help_command $$help_info ; \
	done

run_unit: ## Runs unit tests
	@echo "╠ Running the tests"
	@fvm flutter test || (echo "Error while running tests"; exit 1)

clean: ## Cleans the environment
	@echo "╠ Cleaning the project..."
	@rm -rf pubspec.lock
	@fvm flutter clean
	@fvm flutter pub get

watch: ## Watches the files for changes
	@echo "╠ Watching the project..."
	@fvm dart run build_runner watch --delete-conflicting-outputs

build: ## Build the files for changes
	@echo "╠ Building the project..."
	@echo "╠ Type: $(type)"
	@echo "╠ Flavor: $(flavor)"
	@fvm flutter build $(type) --dart-define flavor=$(flavor) --flavor $(flavor)

gen: ## Generates the assets
	@echo "╠ Generating code..."
	@fvm flutter pub get
	@fvm dart run build_runner build --delete-conflicting-outputs

format: ## Formats the code
	@echo "╠ Formatting the code"
	@dart format lib .
	@dart format test .
	@dart format integration_test .

lint: ## Lints the code
	@echo "╠ Verifying code..."
	@dart analyze . || (echo "Error in project"; exit 1)

upgrade: clean ## Upgrades dependencies
	@echo "╠ Upgrading dependencies..."
	@fvm flutter pub upgrade

commit: format lint run_unit
	@echo "╠ Committing..."
	git add .
	git commit

run_dev_mobile: ## Runs the mobile application in dev
	@echo "╠ Running the app with development flavor"
	@fvm flutter run --flavor dev -t lib/main.dart --dart-define=flavor=dev

run_stg_mobile: ## Runs the mobile application in stg
	@echo "╠ Running the app with staging flavor"
	@fvm flutter run --flavor staging -t lib/main.dart --dart-define=flavor=staging

run_prd_mobile: ## Runs the mobile application in product
	@echo "╠ Running the app with production flavor"
	@fvm flutter run --flavor production -t lib/main.dart --dart-define=flavor=production

build_apk_dev: ## Build the mobile application in dev
	@fvm flutter build apk --dart-define flavor=dev --flavor dev

build_ipa_dev: ## Build the mobile application in dev
	@fvm flutter build ipa --dart-define flavor=dev --flavor dev

build_apk_stg: ## Build the mobile application in staging
	@fvm flutter build apk --flavor staging --dart-define flavor=staging

build_apk_prod: ## Build the mobile application in prod
	@fvm flutter build apk --dart-define flavor=production --flavor production
build_ipa_prod: ## Build the mobile application in prod
	@fvm flutter build ipa --dart-define flavor=production --flavor production

purge: ## Purges the Flutter
	@pod deintegrate
	@fvm flutter clean
	@fvm flutter pub get

build_runner_with_filter: ## Build runner for specific folder
	@echo "╠ Running build_runner with filter for folder: $(folder)"
	@fvm dart run build_runner build --delete-conflicting-outputs --build-filter "$(folder)/**.dart"

build_runner_specific_file: ## Build runner for specific file
	@echo "╠ Running build_runner with filter for file: $(file)"
	@fvm dart run build_runner build --delete-conflicting-outputs --build-filter "$(file)"

build_assets: ## Build assets
	@echo "╠ Running build_runner for assets"
	@fvm flutter pub run build_runner build --delete-conflicting-outputs --build-filter "lib/gen/*.dart"
#you must update the version in pubspec.yaml then run this command (current branch usually is develop,...)
#example: make create_build version=1.2.44
create_build: ## Auto create build by ci/cd
	@echo "╠ Creating build staging for version $(version)"
	@git checkout -b "release/staging/$(version)"
	@git add .
	@git commit -m "release staging $(version)"
	@git tag "build_$(version)"
	@git push
	@git push origin "build_$(version)" -f
#example: make version_change_logs current_version=1.2.64 previous_version=1.2.63
version_change_logs: ## Show change logs for version from previous version to current version
	@echo "Change logs for version $(current_version):"
	@git log "origin/release/staging/$(current_version)" --not "origin/release/staging/$(previous_version)" --pretty=format:"- %s" | tail -n +2

#rename every file example_* to $FileDirName_*
#example: make rename_files folder=lib/gen/example old_prefix=example new_prefix=new_prefix
rename_files: ## Rename files in folder with old_prefix to new_prefix
	@sh ./scripts/rename_files.sh $(folder)

auto_fix: ## Auto fix dart code
	@fvm dart fix --apply

create_test_report: ###Create test report for project, open it in browser
	@echo "╠ Creating test report"
	@fvm flutter test --coverage
	@lcov --remove coverage/lcov.info '**.g.dart' -o coverage/new_lcov.info
	@genhtml coverage/new_lcov.info -o coverage/html
	@open coverage/html/index.html

create_test_report_for_this_file: ###Create test report for specific file, open it in browser
	@echo "╠ Creating test report for file: $(file)"
	@fvm flutter test --coverage $(file)
	@lcov --remove coverage/lcov.info '**.g.dart' -o coverage/new_lcov.info
	@genhtml coverage/new_lcov.info -o coverage/html
	@open coverage/html/index.html

export_coverage: ###Export existing coverage to html, open it in browser (after running tests)
	@echo "╠ Creating test report from coverage/lcov.info"
	@lcov --remove coverage/lcov.info '**.g.dart'   -o coverage/new_lcov.info
	@genhtml coverage/new_lcov.info -o coverage/html
	@open coverage/html/index.html
fix_import:
	@sh ./scripts/import.sh $(folder)
slang:
	@fvm dart run slang
copy_test_to_integration: ### Copy test file in ./test folder to ./integration folder
	@sh ./scripts/copy_test_to_integration.sh $(file)
