module GoTranslateYourself
  module SiteTranslationsHelper
    def translation_text_field(locale, key, default_translation)
      key_parts = key.split('.').inject('') do |kp, key_part|
        kp << "[#{key_part}]"
      end
      text_field_tag("translations[#{locale}]#{key_parts}",
                     I18n.t(key, :locale => locale) || "",
                     :size => (default_translation.size + 20))
    end
  end
end
