module GoTranslateYourself
  module SiteTranslationsHelper
    def translation_text_field(locale, key, default_translation)
      key_parts = key.split('.').inject('') do |kp, key_part|
        kp << "[#{key_part}]"
      end
      translation_text = begin
        I18n.t!(key, :locale => locale)
      rescue I18n::ArgumentError
        GoTranslateYourself.current_store.default_translation("dev.#{key}")[1..-2]
      end
      text_field_tag("translations[#{locale}]#{key_parts}",
                     translation_text || "",
                     :size => (default_translation.size + 20))
    end
  end
end
