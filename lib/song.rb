class Song

    attr_accessor :name
    attr_reader :artist, :genre

    @@all = []

    def initialize(name, artist=nil, genre=nil)
        @name = name
        self.artist = artist if artist
        self.genre = genre if genre
    end

    def self.all
        @@all
    end

    def self.destroy_all
        @@all.clear
    end

    def save
        @@all << self unless @@all.include?(self)
    end

    def self.create(name)
        Song.new(name).tap do |n|
            n.save
        end
    end

    def artist=(artist)
        @artist = artist
        artist.add_song(self)
    end

    def genre=(genre)
        @genre = genre
        genre.songs << self unless genre.songs.include?(self)
    end

    def self.find_by_name(name)
        self.all.detect {|song| song.name == name}
    end

    def self.find_or_create_by_name(name)
       find_by_name(name) || self.create(name)
    end

    def self.new_from_filename(filename)
        n = filename.chomp(".mp3").split(" - ")
        Song.new(n[1], Artist.find_or_create_by_name(n[0]), Genre.find_or_create_by_name(n[2]))
    end

    def self.create_from_filename(filename)
        @@all << self.new_from_filename(filename)
    end
end


# song scratch: 
#
# self.artist.songs << self unless self.artist == nil