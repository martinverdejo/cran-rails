# CRAN Daily Backend Index

This solution uses Sidekiq to read the CRAN packages document on a daily basis. For each package where a version was not previously indexed, a worker is created to extract and save the new version's information into the rails database.

Instrctions for use locally:
1. Install gems
```
bundle install
```

2. Run sidekiq
```
bundle exec sidekiq
```

3. Run redis
```
redis-server
```

4. Load the worker and Enqueue: http://localhost:3000/sidekiq/cron/index_reader_worker. Alternatively, run the `rails console` and execute IndexReaderWorker.perform_async

The current solution does not support packages where the DESCRIPTION file comes as a Unix Executable instead of a text document.

