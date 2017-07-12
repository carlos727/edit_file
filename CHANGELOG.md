# CHANGELOG

##### Changelog v1.1.1 01/07/2017:

- New variable `done` added in `default.rb` recipe to know if the file was edited already.

##### Changelog v1.1.0 21/03/2017:

- New `ruby_block 'Verify task'` resource added to `default.rb` recipe.

- New `fetch` and `count_diff` methods added to `Tools` module.

##### Changelog v1.0.0 16/03/2017:

- Improve code of recipes and helpers according to Ruby Style Guide.

- New attributes `default["file"]["path"]`, `default["search"]["pattern"]` and `default["replace"]["text"]` to avoid change the code's structure.

- New variables were added in `default.rb` recipe to store the values of new attributes.

- Resource `service 'Zabbix Agent'` was deleted and `ruby_block 'Send Email Zabbix'` changed to `ruby_block 'Send Email Edit'` in `default.rb` recipe.
