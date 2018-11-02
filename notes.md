# Notes

## Next steps (jQuery app)
[] add dynamic form for scraps on bowl show page

## Bugs

- ~~Omniauth doesn't take you to Google sign in page, automatically signs you in with primary Google account~~ resolved on own

## Next steps (from Rails-only app)

* priority input for bowl_scraps is being created without a scrap, which doesn't make sense
* fix this somehow, maybe by changing the models to be Bowl, Activity, Scrap?

scrap belongs_to bowl
bowl has_many scraps

scrap belongs_to activity
activity has_many scraps

bowl has_many activities, through: :scraps

scrap.priority

???
