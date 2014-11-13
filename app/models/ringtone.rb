class Ringtone < ActiveRecord::Base
  has_paper_trail

  validates :song, presence: true

  has_attached_file :source
  validates_attachment_content_type :source, :content_type => /\Aaudio\/(x-)?(mpeg|mp3)/

  has_attached_file :ringtone,
                    :styles => { android: { format: :mp3 },
                                 iphone: { format: :m4r } },
                    :processors => [:audio]
  validates_attachment_content_type :ringtone, :content_type => /\Aaudio\/(x-)?(mpeg|mp3)/

  delegate :url, to: :ringtone

  after_commit :create_ringtone, on: :create


  def name
    [song, artist].compact.join(" - ")
  end

  def create_ringtone
    RingtoneCropWorker.perform_async(id)
  end

  rails_admin do
    list do
      field :artist
      field :song
      field :ringtone do
        pretty_value do
          bindings[:view].tag(:audio, { :controls => "", :src => bindings[:object].url(:android) })
        end
      end
      field :processing
    end
  end
end
