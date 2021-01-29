

class MusicLibraryController

    def initialize(path='./db/mp3s')
        MusicImporter.new(path).import
    end

    def call

        puts "Welcome to your music library!"
        puts "To list all of your songs, enter 'list songs'."
        puts "To list all of the artists in your library, enter 'list artists'."
        puts "To list all of the genres in your library, enter 'list genres'."
        puts "To list all of the songs by a particular artist, enter 'list artist'."
        puts "To list all of the songs of a particular genre, enter 'list genre'."
        puts "To play a song, enter 'play song'."
        puts "To quit, type 'exit'."
        puts "What would you like to do?"

          user_input = gets.strip

        if user_input == 'list songs' then list_songs end
        if user_input == 'list artists' then list_artists end
        if user_input == 'list genres' then list_genres end
        if user_input == 'list artist' then list_songs_by_artist end
        if user_input == 'list genre' then list_songs_by_genre end
        if user_input == 'play song' then play_song end

        call unless user_input == "exit"
    end
         

    def list_songs
        sorted_array = Song.all.sort do |song_a, song_b|
          song_a.name <=> song_b.name
        end
        sorted_array.each do |song|
          puts "#{sorted_array.index(song) + 1}. #{song.artist.name} - #{song.name} - #{song.genre.name}"
      end
    end

    def list_artists
        sorted_array = Artist.all.sort do |artist_a, artist_b|
            artist_a.name <=> artist_b.name
          end
          sorted_array.each do |artist|
            puts "#{sorted_array.index(artist) + 1}. #{artist.name}"
        end
    end

    def list_genres
        sorted_array = Genre.all.sort do |genre_a, genre_b|
            genre_a.name <=> genre_b.name
          end
          sorted_array.each do |genre|
            puts "#{sorted_array.index(genre) + 1}. #{genre.name}"
        end
    end

    def list_songs_by_artist
        puts "Please enter the name of an artist:"
        user_artist = gets.strip
        
        if Artist.all.detect {|artist| @user_input_artist = artist if artist.name == user_artist}
        sorted_array = @user_input_artist.songs.sort do |song_a, song_b|
          song_a.name <=> song_b.name
        end
      sorted_array.each do |song|
        puts "#{sorted_array.index(song) + 1}. #{song.name} - #{song.genre.name}"
        end
      end
    end

    def list_songs_by_genre

      puts "Please enter the name of a genre:"
        user_genre = gets.strip
        
        if Genre.all.detect {|genre| @user_input_genre = genre if genre.name == user_genre}
          sorted_array = @user_input_genre.songs.sort do |song_a, song_b|
            song_a.name <=> song_b.name
          end
            sorted_array.each do |song|
              puts "#{sorted_array.index(song) + 1}. #{song.artist.name} - #{song.name}"
            end
        end
    end

    def play_song
      puts "Which song number would you like to play?"
      user_input = gets.strip.to_i
      if (1..Song.all.length).include?(user_input)
        song = Song.all.sort {|a,b| a.name <=> b.name}[user_input-1]
      end
      puts "Playing #{song.name} by #{song.artist.name}" if song
    end
end
