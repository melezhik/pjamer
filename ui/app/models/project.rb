class Project < ActiveRecord::Base

    has_many  :sources
    has_many :builds

    validates :title, presence: true , length: { minimum: 2 }

    def sources_ordered
        sources.sort { |x, y| ( y[:sn] <=> x[:sn] ) || (y[:id] <=> x[:id])  }
    end

    def sources_enabled
        sources_ordered.select { |s| s[:state] == 't'  }
    end

end
