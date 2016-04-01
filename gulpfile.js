var elixir = require('laravel-elixir');

var vueify = require('laravel-elixir-vueify');

/*
 |--------------------------------------------------------------------------
 | Elixir Asset Management
 |--------------------------------------------------------------------------
 |
 | Elixir provides a clean, fluent API for defining some basic Gulp tasks
 | for your Laravel application. By default, we are compiling the Sass
 | file for our application, as well as publishing vendor resources.
 |
 */

elixir.config.js.browserify.watchify = {
  enabled: false,
  options: {
    poll: true
  }
};

elixir(function(mix) {

    // Lets copy external libs to the vendor folder. 
    // They will be imported appropriately by browserify using
    // ecma6 module system (import statements in main.js for example)

    mix.copy('node_modules/vuex/dist/vuex.js', 'resources/assets/js/vendor/vuex.js');
    mix.copy('node_modules/vue/dist/vue.js', 'resources/assets/js/vendor/vue.js');
    mix.copy('node_modules/vue-resource/dist/vue-resource.js', 'resources/assets/js/vendor/vue-resource.js');

    //Gibber seems to be fucked up by browserify using strict mode
    // mix.copy('node_modules/gibber.lib/build/gibber.lib.js', 'public/js/gibber.js');

    // mix.copy('node_modules/gibber.lib/build/gibber.lib.js', 'public/js/gibber.js');

    // mix.scripts(['vendor/gibber.lib.js'], 'public/js/gibber.js');

    mix.sass('app.scss');


    //OLD SHIT
    mix.scripts(['vendor/gibber.lib.min.js'], 'public/js/gibber.js');
    // mix.scriptsIn('resources/assets/js/vendor/', 'public/js/vendor.js');
    // mix.scripts([], 'public/js/vendor.js');

    // mix.vueify('main.js', {insertGlobals: true, transform: "vueify", output: "public/js"});
    // mix.browserify('main.js');
    // mix.browserify('home.js');

    // mix.scripts('soundengine.js', 'public/js/soundengine.js');
    mix.browserify('soundengine.js');

    mix.browserify('app.js');
    mix.browserify('settings.js');
});
