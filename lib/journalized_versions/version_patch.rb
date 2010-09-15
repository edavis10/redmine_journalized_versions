require_dependency 'version'

module JournalizedVersions
  module VersionPatch
    def self.included(base) # :nodoc:
      base.class_eval do
        unloadable
        acts_as_journalized :event_title => Proc.new {|o| "#{I18n.t(:label_version)}: #{o.name}" },
          :event_type => Proc.new {|o| 'version ' + (o.open? ? '' : o.status) },
          :event_type => Proc.new {|o| 'issue' + (o.closed? ? ' closed' : '') },
          :activity_permission => :view_issues

        register_on_journal_formatter(:plaintext, 'name', 'status', 'sharing', 'wiki_page_title', 'description')
        register_on_journal_formatter(:datetime, 'effective_date')
        register_on_journal_formatter(:named_association, 'project_id')
      end

      base.send(:include, InstanceMethods)
    end

    module InstanceMethods
      def journal_editable_by?(user)
        user.allowed_to? :manage_versions, project
      end
    end
  end
end

Version.send(:include, JournalizedVersions::VersionPatch)
