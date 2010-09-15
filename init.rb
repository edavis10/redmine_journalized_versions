require 'redmine'

require 'dispatcher'
Dispatcher.to_prepare do
  # Model Patches
  require_dependency 'journalized_versions/version_patch'
  require_dependency 'journalized_versions/versions_controller_patch'
end

# Hooks
require 'journalized_versions/view_versions_show_bottom'

Redmine::Plugin.register :redmine_journalized_versions do
  name 'Redmine Journalized Versions plugin'
  author 'finnlabs'
  author_url 'http://finn.de/'
  description 'This plugin provides a journal and notifications for versions'
  version '0.0.1'

  requires_redmine :version_or_higher => '0.9'
end
