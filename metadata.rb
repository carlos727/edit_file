name 'edit_file'
maintainer 'Carlos Beleño'
maintainer_email 'cbeleno@redsis.com'
license 'all_rights'
description 'Installs/Configures edit_file'
version '1.1.1'
long_description <<-DSCPT
#### Cookbook to edit files of remote nodes.

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
DSCPT

# If you upload to Supermarket you should set this so your cookbook
# gets a `View Issues` link
# issues_url 'https://github.com/<insert_org_here>/edit_file/issues' if respond_to?(:issues_url)

# If you upload to Supermarket you should set this so your cookbook
# gets a `View Source` link
# source_url 'https://github.com/<insert_org_here>/edit_file' if respond_to?(:source_url)
