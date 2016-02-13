# greenhouse_io changelog

This project follows [semantic versioning](http://semver.org/).  This changelog follows suggestions from [keepachangelog.com](http://keepachangelog.com/).

## Version 2.3.0
Released 2016-02-13.

##### Added
- Added support for listing all scorecards belonging to an organization: `all_scorecards`.  Thanks, [@bcoppersmith](https://github.com/bcoppersmith)!

## Version 2.2.0
Released 2016-02-03.

##### Added
- Added support for listing Offers and retrieving them by ID
- Added support for filtering with `job_id` parameter

##### Changed
- Upgraded dependencies: `multi_json` (now ~>1.11.2), and development gems
- Added version dependency for `httmultiparty`: ``'~> 0.3.16'``