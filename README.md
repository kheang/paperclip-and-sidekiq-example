# Mobilz

This application is an example of how you can use Paperclip and Sidekiq for
file processing, both in- and out-of-band.

## Setup

This application requires Redis, ffmpeg, and ImageMagick. On OS X, install these
like so:

```
brew install redis ffmpeg imagemagick
```

Once you have those installed, you will need to install the required gems and
create the database:

```
bundle install
./bin/rake db:create
```

You will need the Redis server running. Run `brew info redis` to find out how.†

Lastly, you can start both Rails and the Sidekiq server by running:

```
bundle exec foreman
```

## Homework tasks

* The ringtone show page is broken after uploading a new ringtone. First, check
to see if a ringtone is still being processed, and if so, show a different
page.
* Then, use JavaScript to check on the status of the ringtone and update the
page when ready.
* Currently, we only allow you to take the first 30 seconds of a song for your
ringtone. Change this so you can start at any point and take as many seconds as
you want. (Even better, make it a maximum of 30 seconds.)
* Generating all the formats we need for wallpaper takes a long time. Can we
process some of these out-of-band? If so, set that up.