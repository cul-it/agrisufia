module Qa::Authorities
  class Agrovoc::Skosmos < Base
    include WebServiceBase

    def search q
      Rails.logger.info "AUTHORITY URL = " + build_query_url(q)
      @raw_response = get_json(build_query_url(q))
      Rails.logger.info "THE RESPONSE = " + @raw_response.to_s
      parse_authority_response(q)
    end

    def build_query_url q
      escaped_q = URI.escape(q)
      return "http://aims.fao.org/skosmos/rest/v1/search/?query=*#{escaped_q}*&lang=en"
    end

    def parse_authority_response q
      escaped_q = URI.escape(q)
      
      if @raw_response != nil
        if escaped_q.include?('%20')
          @raw_response['results'].map { |result| 
            if result['altLabel'].presence
              { 'label' => result['prefLabel'] + ' (' + result['altLabel'].to_s + ')' }
            else
              { 'label' => result['prefLabel'] }
            end
          }
        else
          @raw_response['results'].reject { |result| !( result['prefLabel'] =~ %r{\b#{escaped_q}\b}i || result['altLabel'] =~ %r{\b#{escaped_q}\b}i )}.map { |result|
              if result['altLabel'].presence  
                { 'label' => result['prefLabel'] + ' (' + result['altLabel'].to_s + ')' }
              else
                { 'label' => result['prefLabel'] }
              end
            }
          end
        end
      end
    end
end
