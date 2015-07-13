require 'uri'

module Qa::Authorities
  module Agrovoc
    require 'qa/authorities/agrovoc/skosmos'
    extend AuthorityWithSubAuthority

    def self.subauthorities
      puts "HELP ME IF YOU CAN!"
      [ "skosmos" ]
    end

    def self.subauthority_class(_)
      puts "I'M FEELING DOW OW OW OW N"
      Skosmos
    end
  end
end
