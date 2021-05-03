class Song < ActiveRecord::Base
  belongs_to :artist
  belongs_to :genre
  has_many :notes

  def artist_name
    if self.artist
      self.artist.name
    end
  end

  def artist_name=(artist)
    self.artist = Artist.find_or_create_by(name: artist)
    self.save
  end

  def note_contents
    self.notes.collect(&:content)
  end

  def note_contents=(note_contents)
    note_contents.each do |text|
      unless text.empty?
        self.notes << Note.create(content: text)
        self.save
      end
    end
  end
end
