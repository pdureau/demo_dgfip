install:
	composer install
	vendor/bin/drush -y si --db-url=sqlite://./db.sqlite
	vendor/bin/drush upwd admin admin
	vendor/bin/drush -y en ui_patterns_library ui_styles_library ui_icons_library ui_icons_patterns ui_skins ui_examples inline_form_errors sdc_devel layout_builder
	vendor/bin/drush -y config-set system.performance css.preprocess 0
	vendor/bin/drush -y config-set system.performance js.preprocess 0
	vendor/bin/drush cr
	vendor/bin/drush theme:enable demo_dsfr
	vendor/bin/drush -y config-set system.theme default demo_dsfr
	vendor/bin/drush theme:uninstall olivero
	
up:
	vendor/bin/drush rs
	
lint:
	- vendor/bin/twig-cs-fixer lint --fix web/themes/custom/*/components
	- vendor/bin/twig-cs-fixer lint --fix web/themes/custom/*/templates
	- prettier --write web/themes/custom/*/*.yml
	- prettier --write web/themes/custom/*/components/*/*.yml
	- vendor/bin/drush sdcv demo_dsfr
