# HaitiStream

## Crowd-sourced Twitter stream filtering

* Pulls tweets tagged with #haiti from Twitter.
* Presents them to anyone who visits.
* Visitors identify tweets from/about people in actionable crisis situations.
* Aid organizations can view the highest-voted (i.e. most critical) tweets from a given time slice.

## How the front end should look

See doc/crisisfilter2.jpg.

## TODO (in no particular order)

* twitter import
  * make sure we catch all tweets
  * improve geolocation and grab username (Anselm)
* firehose page
  * hotoronot one-at-a-time UI
  * can we link back to twitter for the username and/or individual tweet?
* filter page
  * "mark as handled" form and storage
  * sort by report count or date on filter page (currently it's report count)
  * make time frames / minimum reports work on filter page
* general
  * fix sidebar links
  * move to crisisfilter.org, or at least crisisfilter.heroku.com
  * performance
    * don't store all tweets forever
    * don't fetch tweets from Twitter in a user thread
