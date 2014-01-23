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

    def last_build
        builds.last
    end

    def distribution_source
        sources.find distribution
    end

    def distribution_url
        begin
            distribution_source[:url]
        rescue ActiveRecord::RecordNotFound => ex
            nil
        end
    end

    def local_path
        "#{Rails.public_path}/projects/#{id}"
    end

    def pinto_repo_root
        "#{local_path}/repo"
    end

end
