var gulp = require('gulp');
var less = require('gulp-less');
var minifyCSS = require('gulp-minify-css');
var serve = require('gulp-serve');

var path = require('path');
var fs = require('fs');

var publicDir = './public'

/* Tasks */

gulp.task('build', function() {
    gulp.src('./less/grayscale.less')
      .pipe(less())
      .pipe(minifyCSS())
      .pipe(gulp.dest(path.join(publicDir, 'css')));

});

gulp.task('serve', serve({root: 'public', port: 8000}));

gulp.task('watch', function() {
    gulp.watch('./less/*.less', ['build']);
});

gulp.task('watch-serve', ['watch', 'serve'], function() {});

gulp.task('push', ['build'], function() {
    var s3 = require('gulp-s3');
    aws = JSON.parse(fs.readFileSync('./aws.json'));
    gulp.src(path.join(publicDir, '**'))
      .pipe(s3(aws));
});

gulp.task('default', ['build']);
