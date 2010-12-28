module GoTranslateYourself
  class SiteTranslationsController < ApplicationController
    before_filter :auth
    helper 'go_translate_yourself/translation_tabs'
    helper 'go_translate_yourself/translation_table'

    def edit
      @translations = hash_class[
        *GoTranslateYourself.current_store.keys_without_prefix.collect do |key| 
          [key, GoTranslateYourself.current_store.default_translation("dev.#{key}")]
        end.flatten
      ]
      # NOTE: This is not your typical ruby-esque way to do things, what with the passing by reference,
      # but it totally works.  I'm getting a nested hash of the namespaces.
      @translations_split = {}
      @translations.each do |key, default_translation|
        tran_parts = key.split('.')
        current_position = @translations_split
        while tran_parts.length > 1
          next_part = tran_parts.shift
          unless current_position[next_part]
            current_position[next_part] = {}
          end
          current_position = current_position[next_part]
        end
        current_position[tran_parts.first] = key
      end
      @locales = GoTranslateYourself.locales
      render :layout => GoTranslateYourself.layout_name
    end

    def update
      if params[:translations] && !params[:translations].empty?
        params[:translations].each do |key, value|
          I18n.backend.store_translations(key.to_sym, value)
        end
      end
      redirect_to site_translations_path
    end

    private

    def auth
      GoTranslateYourself.auth_handler.bind(self).call if GoTranslateYourself.auth_handler.is_a? Proc
    end

    def hash_class
      RUBY_VERSION < '1.9' ? ActiveSupport::OrderedHash : Hash
    end
  end
end

