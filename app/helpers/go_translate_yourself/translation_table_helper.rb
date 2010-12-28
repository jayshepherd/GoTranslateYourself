module GoTranslateYourself
  module TranslationTableHelper
    def translation_table_for(translations, locales)
      render :partial => 'go_translate_yourself/site_translations/translation_table', :locals => { :translations => translations, :locales => locales }
    end

    def get_translations_under(child, translations)
      array_representation = translations.select{|k, v| child.values.include?(k)}
      hash_var = HashFromArray.hash_from_array(array_representation)
    end
  end
end
