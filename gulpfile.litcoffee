# OverTheMoon's Gulpfile

## Load dependencies

System deps

    path = require('path');
    fs   = require('fs');

Lodash for flavor


    _ = require('lodash');

And, all of the gulp magic

    gulp      = require('gulp');
    gutil     = require('gulp-util');
    less      = require('gulp-less');
    minifyCSS = require('gulp-minify-css');
    serve     = require('gulp-serve');
    expect    = require('gulp-expect-file');


## Variables


Files are served/pushed from `publicDir`. Source files are transpiled
into the `publicDir`.

    publicDir = 'public'

`less_files` are the less file to be built and watched.

    less_files = ['less/grayscale.less']

`aws_conf` is the path to the aws config file.

    aws_conf = './aws.json'

`port` is the integer port number to serve `public` from.

    port = 8000

## Tasks

### build

Build [transpile] the source files into their final, transpiled,
uglified versions.

Currently, only `less/grayscale.less` is transpiled.

    gulp.task 'build', ->
        gulp.src less_files
          .pipe less()
          # .pipe minifyCSS()
          .pipe gulp.dest(path.join(publicDir, 'css'))

### serve

Serve the public directory.

    gulp.task 'serve', serve({root: 'public', port: port})


### watch

Watch for and rebuild on changes in the less files.

    gulp.task 'watch', ->
        gulp.watch less_files, ['build']

### watch-serve

All together now: build, watch, and serve.

    gulp.task 'watch-serve', ['build', 'watch', 'serve']

### push

Push changes to S3.

    gulp.task 'push', ['build'], ->
        s3 = require('gulp-s3');
        aws = JSON.parse(fs.readFileSync(aws_conf))
        gulp.src path.join(publicDir, '**')
          .pipe s3(aws)

### default

The default task is to build the project.

    gulp.task 'default', ['build']

### docs

TODO: build the documentation using dokko docs.
