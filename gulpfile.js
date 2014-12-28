var gulp = require('gulp');
var less = require('gulp-less');
var path = require('path');
var minifyCSS = require('gulp-minify-css');
var serve = require('gulp-serve');

var publicDir = './public'

/* Tasks */

gulp.task('default', function() {
    gulp.src('./less/grayscale.less')
      .pipe(less())
      .pipe(minifyCSS())
      .pipe(gulp.dest(path.join(publicDir, 'css')));

});

gulp.task('serve', serve({root: 'public', port: 8000}));

gulp.task('watch', function() {
    gulp.watch('./less/*.less', ['default']);
});

gulp.task('watch-serve', ['watch', 'serve'], function() {});
