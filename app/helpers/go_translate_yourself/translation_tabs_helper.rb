module GoTranslateYourself
  module TranslationTabsHelper
    def tabs_for(hash)
      render :partial => 'go_translate_yourself/site_translations/tabs', :locals => { :hash => hash }
    end

    def tabs_full_for(hash)
      render :partial => 'go_translate_yourself/site_translations/tabs_full', :locals => { :hash => hash }
    end
  end
end
