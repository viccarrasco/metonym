# frozen_string_literal: true

module Validate
  class BaseValidator
    protected

    def is_key_present?(args)
      !args.nil?
    end

    def is_language_valid?(args)
      return true if args['lang'].nil?
      [
        'af', 'ak', 'sq', 'am', 'ar', 'hy', 'az', 'eu', 'be', 'bem', 'bn', 'bs', 'bh', 'br', 'bg', 'km', 'ca', 'chr', 'ny', 'zh-CN',
        'zh-TW', 'co', 'hr', 'cs', 'da', 'nl', 'en', 'eo', 'et', 'ee', 'fo', 'tl', 'fi', 'fr', 'fy', 'gl', 'ka', 'de', 'el', 'gn', 'gu',
        'ht', 'ha', 'haw', 'iw', 'hi', 'hu', 'is', 'ig', 'id', 'ia', 'ga', 'it', 'ja', 'jw', 'kn', 'kk', 'rw', 'rn', 'kg', 'ko', 'kri',
        'ku', 'ckb', 'ky', 'lo', 'la', 'lv', 'ln', 'lt', 'loz', 'lg', 'ach', 'mk', 'mg', 'ms', 'ml', 'mt', 'mi', 'mr', 'mfe', 'mo', 'mn',
        'sr-ME', 'ne', 'nso', 'no', 'nn', 'oc', 'or', 'om', 'ps', 'fa', 'pl', 'pt-BR', 'pt-PT', 'pa', 'qu', 'ro', 'rm', 'nyn', 'ru', 'gd',
        'sr', 'sh', 'st', 'tn', 'crs', 'sn', 'sd', 'si', 'sk', 'sl', 'so', 'es', 'sp-419', 'su', 'sw', 'sv', 'tg', 'ta', 'tt', 'te', 'th', 'ti',
        'to', 'lua', 'tum', 'tr', 'tk', 'tw', 'ug', 'uk', 'ur', 'uz', 'vi', 'cy', 'wo', 'xh', 'yi', 'yo', 'zu'
      ].include?(args['lang'].downcase)
    end

    def is_format_valid?(args)
      template = %w(json hash)
      args.nil? ? true : template.include?(args.downcase)
    end
  end
end
