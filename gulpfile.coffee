gulp     = require('gulp')
coffee   = require('gulp-coffee')
uglify   = require('gulp-uglify')
clean    = require('gulp-clean')
sequence = require('run-sequence')
rename   = require('gulp-rename')

src  = './src/github_api.coffee'
dest = './dist'

gulp.task 'clean', ->
  gulp.src(dest + "/**/*", read: false)
    .pipe(clean())

gulp.task 'minify', ->
  gulp.src(src)
    .pipe(coffee(bare: true))
    .pipe(uglify())
    .pipe(rename("github_api.min.js"))
    .pipe(gulp.dest(dest))

gulp.task 'src', ->
  gulp.src(src)
    .pipe(coffee(bare: true))
    .pipe(rename("github_api.js"))
    .pipe(gulp.dest(dest))

gulp.task 'compile', ->
  sequence('clean', 'minify', 'src')

gulp.task 'watch-files', ->
  gulp.watch(src, ['compile'])

# run this command to compile for dist
gulp.task 'start', ['compile', 'watch-files']
