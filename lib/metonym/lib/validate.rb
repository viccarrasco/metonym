module Validate
    class Validator
         def is_key_present?(args)
            return !args.nil?
        end

        def is_language_valid?(args)
            if args['lang'].nil?
                true
            else
                return [
                    'af','ak','sq','am','ar','hy','az','eu','be','bem','bn','bs','bh','br','bg','km','ca','chr','ny','zh-CN',
                    'zh-TW','co','hr','cs','da','nl','en','eo','et','ee','fo','tl','fi','fr','fy','gl','ka','de','el','gn','gu',
                    'ht','ha','haw','iw','hi','hu','is','ig','id','ia','ga','it','ja','jw','kn','kk','rw','rn','kg','ko','kri',
                    'ku','ckb','ky','lo','la','lv','ln','lt','loz','lg','ach','mk','mg','ms','ml','mt','mi','mr','mfe','mo','mn',
                    'sr-ME','ne','nso','no','nn','oc','or','om','ps','fa','pl','pt-BR','pt-PT','pa','qu','ro','rm','nyn','ru','gd',
                    'sr','sh','st','tn','crs','sn','sd','si','sk','sl','so','es','sp-419','su','sw','sv','tg','ta','tt','te','th','ti',
                    'to','lua','tum','tr','tk','tw','ug','uk','ur','uz','vi','cy','wo','xh','yi','yo','zu'
                ].include?(args['lang'].downcase)
            end
        end

        def is_format_valid?(args)
            template = %w(json hash)
            
            if args.nil?
                true
            else
                template.include?(args.downcase)
            end
        end
    end

    class GnewsValidator < Validator
        COUNTRIES = [
            'af','al','dz','as','ad','ao','ai','aq','ag','ar','am','aw','au','at','az','bs','bh','bd','bb','by',
            'be','bz','bj','bm','bt','bo','ba','bw','bv','br','io','bn','bg','bf','bi','kh','cm','ca','cv','ky',
            'cf','td','cl','cn','cx','cc','co','km','cg','cd','ck','cr','ci','hr','cu','cy','cz','dk','dj','dm',
            'do','ec','eg','sv','gq','er','ee','et','fk','fo','fj','fi','fr','gf','pf','tf','ga','gm','ge','de',
            'gh','gi','gr','gl','gd','gp','gu','gt','gn','gw','gy','ht','hm','va','hn','hk','hu','is','in','id',
            'ir','iq','ie','il','it','jm','jp','jo','kz','ke','ki','kp','kr','kw','kg','la','lv','lb','ls','lr',
            'ly','li','lt','lu','mo','mk','mg','mw','my','mv','ml','mt','mh','mq','mr','mu','yt','mx','fm','md',
            'mc','mn','ms','ma','mz','mm','na','nr','np','nl','an','nc','nz','ni','ne','ng','nu','nf','mp','no',
            'om','pk','pw','ps','pa','pg','py','pe','ph','pn','pl','pt','pr','qa','re','ro','ru','rw','sh','kn',
            'lc','pm','vc','ws','sm','st','sa','sn','cs','sc','sl','sg','sk','si','sb','so','za','gs','sp','lk',
            'sd','sr','sj','sz','se','ch','sy','tw','tj','tz','th','tl','tg','tk','to','tt','tn','tr','tm','tc',
            'tv','ug','ua','ae','uk','us','um','uy','uz','vu','ve','vn','vg','vi','wf','eh','ye','zm','zw'
        ]

        def is_query_valid?(args)
            template = %w(q max lang country mindate maxdate in)
            return (args.keys - template).empty?
        end

        def is_country_valid?(args)
            if args['country'].nil?
                true
            else
                return COUNTRIES.include?(args['country'].downcase)
            end
        end

        def is_date_valid?(args)
            if (args['mindate'].nil? && args['maxdate'].nil?)
                true
            elsif (args['mindate'] && args['maxdate'])
                return (args['mindate'].respond_to?(:strftime) && args['maxdate'].respond_to?(:strftime))
            elsif (args['mindate'] && args['maxdate'].nil?)
                return args['mindate'].respond_to?(:strftime)
            elsif (args['mindate'].nil? && args['maxdate'])
                return args['maxdate'].respond_to?(:strftime)
            end
        end
    end

    class NewsApiValidator < Validator
        COUNTRIES   = %w(ar au at be br bg ca cn co cu cz eg fr de gr hk hu in id ie il it jp lv lt my mx ma nl nz ng no ph pl pt ro ru sa rs sg sk si za kr se ch tw th tr ae ua gb us ve)
        CATEGORIES  = %w(business entertainment general health science sports technology)

        def is_query_valid?(args, endpoint = 'top-headlines')
            case endpoint
            when 'top-headlines'
                template = %w(q country category sources page_size page)
            when 'everything'
                template = %w(q sources domains excludeDomains from to language sortBy pageSize page)
            when 'sources'
                template = %w(category language country)
            end

            if (endpoint == 'top-headlines' && (args.include?('sources') && (args.include?('country') || args.include?('category'))))
                false
            elsif (endpoint == "sources") && (args.has_key?("category")) && (CATEGORIES.include?(args["category"]) == false)
                false
            else
                (args.keys - template).empty?
            end
        end

        def is_country_valid?(args)
            if args['country'].nil?
                true
            else
                return COUNTRIES.include?(args['country'].downcase)
            end
        end

        def is_category_valid?(args)
            template = %w(business entertainment general health science sports technology)
            return template.include?(args['country'])
        end

        def is_date_valid?(args)
            if (args['from'].nil? && args['to'].nil?)
                true
            elsif (args['from'] && args['to'])
                return (args['from'].respond_to?(:strftime) && args['to'].respond_to?(:strftime))
            elsif (args['from'] && args['to'].nil?)
                return args['from'].respond_to?(:strftime)
            elsif (args['from'].nil? && args['to'])
                return args['from'].respond_to?(:strftime)
            end
        end
    end
end