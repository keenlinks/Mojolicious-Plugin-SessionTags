use Mojo::Base -strict;

use Test::More;
use Mojolicious::Lite;
use Test::Mojo;

plugin 'Mojolicious::Plugin::SessionTags' => { name => 'role', tags => [qw/ user admin super exec nobody sam_i_am /] };

my $t = Test::Mojo->new;
my $c = $t->app->build_controller;

ok( $c->sum_role == $c->session->{st_role} );

ok( $c->add_role( 'user' )->add_role( 'exec' )->add_role( 'nobody' )->sum_role == $c->session->{st_role} );
ok( $c->sum_role == 25 );

ok( $c->has_role( 'user' ) == 1 );
ok( $c->has_role( 'admin' ) == 0 );
ok( $c->has_role( 'super' ) == 0 );
ok( $c->has_role( 'exec' ) == 1 );
ok( $c->has_role( 'nobody' ) == 1 );

ok( $c->not_role( 'user' ) == 0 );
ok( $c->not_role( 'admin' ) == 1 );
ok( $c->not_role( 'super' ) == 1 );
ok( $c->not_role( 'exec' ) == 0 );
ok( $c->not_role( 'nobody' ) == 0 );

ok( $c->nix_role( 'nobody' )->nix_role( 'exec' )->sum_role == $c->session->{st_role} );
ok( $c->sum_role== 1 );

ok( $c->has_role( 'user' ) == 1 );
ok( $c->has_role( 'admin' ) == 0 );
ok( $c->has_role( 'super' ) == 0 );
ok( $c->has_role( 'exec' ) == 0 );
ok( $c->has_role( 'nobody' ) == 0 );

ok( $c->not_role( 'user' ) == 0 );
ok( $c->not_role( 'admin' ) == 1 );
ok( $c->not_role( 'super' ) == 1 );
ok( $c->not_role( 'exec' ) == 1 );
ok( $c->not_role( 'nobody' ) == 1 );


ok( $c->sum_role(0) == 0 );
ok( $c->sum_role == $c->session->{st_role} );
ok( $c->has_role( 'user' ) == 0 );
ok( $c->has_role( 'admin' ) == 0 );
ok( $c->has_role( 'super' ) == 0 );
ok( $c->has_role( 'exec' ) == 0 );
ok( $c->has_role( 'nobody' ) == 0 );

ok( $c->not_role( 'user' ) == 1 );
ok( $c->not_role( 'admin' ) == 1 );
ok( $c->not_role( 'super' ) == 1 );
ok( $c->not_role( 'exec' ) == 1 );
ok( $c->not_role( 'nobody' ) == 1 );

done_testing();
