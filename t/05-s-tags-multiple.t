use Mojo::Base -strict;

use Test::More;
use Mojolicious::Lite;
use Test::Mojo;

plugin 'Mojolicious::Plugin::SessionTags' => [
	{ name => 'role', tags => [qw/ user admin super exec nobody sam_i_am /] },
	{ name => 'done', tags => [qw/ dusting coding eating euphemism sleeping /] },
	{ name => 'meal', tags => [qw/ breakfast second_breakfast lunch tea dinner snack /] }
];

my $t = Test::Mojo->new;
my $c = $t->app->build_controller;

ok( $c->sum_role == $c->session->{st_role} );
ok( $c->sum_done == $c->session->{st_done} );
ok( $c->sum_meal == $c->session->{st_meal} );

my $ref = $c->add_role( 'sam_i_am' )
			->add_meal( 'breakfast' )
			->add_done( 'eating' )
			->add_meal( 'second_breakfast' )
			->add_meal( 'lunch' )
			->add_meal( 'tea' )
			->add_meal( 'dinner' )
			->add_done( 'euphemism' )
			->nix_meal( 'dinner' )
			->add_meal( 'snack' );

ok( ref $ref eq 'Mojolicious::Controller' );

ok( $c->sum_role == 32 );
ok( $c->sum_role == $c->session->{st_role} );
ok( $c->sum_meal == 47 );
ok( $c->sum_meal == $c->session->{st_meal} );
ok( $c->sum_done == 12 );
ok( $c->sum_done == $c->session->{st_done} );

ok( $c->has_role( 'sam_i_am' ) == 1 );
ok( $c->has_role( 'exec' ) == 0 );
ok( $c->has_done( 'euphemism' ) == 1 );
ok( $c->has_done( 'sleeping' ) == 0 );
ok( $c->has_meal( 'breakfast' ) == 1 );
ok( $c->has_meal( 'dinner' ) == 0 );

ok( $c->not_role( 'nobody' ) == 1 );
ok( $c->not_role( 'sam_i_am' ) == 0 );
ok( $c->not_done( 'dusting' ) == 1 );
ok( $c->not_done( 'euphemism' ) == 0 );
ok( $c->not_meal( 'dinner' ) == 1 );
ok( $c->not_meal( 'tea' ) == 0 );

done_testing();
