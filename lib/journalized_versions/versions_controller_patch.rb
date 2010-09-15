require_dependency 'versions_controller'

module JournalizedVersions
  module VersionsControllerPatch
    def self.included(base) # :nodoc:
      base.send(:include, InstanceMethods)
      
      base.class_eval do
        unloadable
        helper :journals
        include JournalsHelper
        alias_method_chain :edit, :journalized_versions        
      end
    end
  
    module InstanceMethods      
      def edit_with_journalized_versions
        return render_reply(@journal) if @journal
        if request.post? && params[:version]          
          attributes = params[:version].dup  
          @version.init_journal(User.current, params[:notes])
          attributes.delete('sharing') unless @version.allowed_sharings.include?(attributes['sharing'])
          if @version.update_attributes(attributes)
            flash[:notice] = l(:notice_successful_update)
            redirect_to :controller => 'versions', :action => 'show', :id => @version
          end
        end
      end
    end
  end
end

VersionsController.send(:include, JournalizedVersions::VersionsControllerPatch)
