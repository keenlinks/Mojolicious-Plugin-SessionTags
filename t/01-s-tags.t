use Mojo::Base -strict;

use Test::More;
use Mojolicious::Lite;
use Test::Mojo;

plugin 'Mojolicious::Plugin::SessionTags' => { tags => [qw/ happy sad stupid smart goofy /] };

my $t = Test::Mojo->new;
my $c = $t->app->build_controller;

ok( $c->sum_tag == $c->session->{s_tags} );

ok( $c->add_tag( 'happy' ) == 1 );
ok( $c->add_tag( 'smart' ) == 9 );
ok( $c->add_tag( 'goofy' ) == 25 );

ok( $c->sum_tag == $c->session->{sstag_tag} );
ok( $c->sum_tag == 25 );

ok( $c->has_tag( 'happy' ) == 1 );
ok( $c->has_tag( 'sad' ) == 0 );
ok( $c->has_tag( 'stupid' ) == 0 );
ok( $c->has_tag( 'smart' ) == 1 );
ok( $c->has_tag( 'goofy' ) == 1 );

ok( $c->has_tag( 'happy' ) == 1 );
ok( $c->has_tag( 'sad' ) == 0 );
ok( $c->has_tag( 'stupid' ) == 0 );
ok( $c->has_tag( 'smart' ) == 1 );
ok( $c->has_tag( 'goofy' ) == 1 );

ok( $c->not_tag( 'happy' ) == 0 );
ok( $c->not_tag( 'sad' ) == 1 );
ok( $c->not_tag( 'stupid' ) == 1 );
ok( $c->not_tag( 'smart' ) == 0 );
ok( $c->not_tag( 'goofy' ) == 0 );

ok( $c->not_tag( 'happy' ) == 0 );
ok( $c->not_tag( 'sad' ) == 1 );
ok( $c->not_tag( 'stupid' ) == 1 );
ok( $c->not_tag( 'smart' ) == 0 );
ok( $c->not_tag( 'goofy' ) == 0 );

ok( $c->nix_tag( 'goofy' ) == 9 );
ok( $c->nix_tag( 'happy' ) == 8 );

ok( $c->sum_tag == $c->session->{sstag_tag} );
ok( $c->sum_tag == 8 );

ok( $c->has_tag( 'goofy' ) == 0 );
ok( $c->has_tag( 'happy' ) == 0 );

ok( $c->not_tag( 'goofy' ) == 1 );
ok( $c->not_tag( 'happy' ) == 1 );

done_testing();
