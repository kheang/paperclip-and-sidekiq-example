require 'tempfile'

class RingtoneCropWorker
  include Sidekiq::Worker

  def perform(id)
    ringtone = Ringtone.find(id)
    source = ringtone.source
    outfile = Paperclip::Tempfile.new(['ringtone', '.mp3'])
    Paperclip.run("ffmpeg", "-i #{source.path} -y -ss #{ringtone.start_time} -t #{ringtone.length} -acodec copy #{outfile.path}" )
    ringtone.ringtone = outfile
    ringtone.processing = false
    ringtone.save
    outfile.close
  end
end
