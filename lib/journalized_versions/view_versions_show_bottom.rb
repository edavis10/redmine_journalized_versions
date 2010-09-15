module JournalizedVersions
  class ViewVersionsShowBottom < Redmine::Hook::ViewListener
      render_on :view_versions_show_bottom, :partial => 'hooks/view_versions_show_bottom'
  end
end
