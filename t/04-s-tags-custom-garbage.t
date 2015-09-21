use Mojo::Base -strict;

use Test::More;
use Mojolicious::Lite;
use Test::Mojo;
use Test::Exception;

plugin 'Mojolicious::Plugin::SessionTags' => { session_key => 'my_key', name => 'role', tags => [qw/ user admin super exec nobody sam_i_am /] };

my $t = Test::Mojo->new;
my $c = $t->app->build_controller;

ok( $c->sum_role == $c->session->{my_key} );

throws_ok { $c->add_role( 'dodo1' ) } qr/Cannot locate the role for the SessionTags plugin helper\./, 'add_role with non-existant role input caught error ok';
throws_ok { $c->add_role( 'dodo2' ) } qr/Cannot locate the role for the SessionTags plugin helper\./, 'add_role with non-existant role input caught error ok';
throws_ok { $c->add_role( 'dodo3' ) } qr/Cannot locate the role for the SessionTags plugin helper\./, 'add_role with non-existant role input caught error ok';

throws_ok { $c->has_role( 'dodo1' ) } qr/Cannot locate the role for the SessionTags plugin helper\./, 'has_role with non-existant role input caught error ok';
throws_ok { $c->has_role( 'dodo2' ) } qr/Cannot locate the role for the SessionTags plugin helper\./, 'has_role with non-existant role input caught error ok';
throws_ok { $c->has_role( 'dodo3' ) } qr/Cannot locate the role for the SessionTags plugin helper\./, 'has_role with non-existant role input caught error ok';

throws_ok { $c->nix_role( 'dodo1' ) } qr/Cannot locate the role for the SessionTags plugin helper\./, 'nix_role with non-existant role input caught error ok';
throws_ok { $c->nix_role( 'dodo2' ) } qr/Cannot locate the role for the SessionTags plugin helper\./, 'nix_role with non-existant role input caught error ok';
throws_ok { $c->nix_role( 'dodo3' ) } qr/Cannot locate the role for the SessionTags plugin helper\./, 'nix_role with non-existant role input caught error ok';

throws_ok { $c->not_role( 'dodo1' ) } qr/Cannot locate the role for the SessionTags plugin helper\./, 'not_role with non-existant role input caught error ok';
throws_ok { $c->not_role( 'dodo2' ) } qr/Cannot locate the role for the SessionTags plugin helper\./, 'not_role with non-existant role input caught error ok';
throws_ok { $c->not_role( 'dodo3' ) } qr/Cannot locate the role for the SessionTags plugin helper\./, 'not_role with non-existant role input caught error ok';

throws_ok { $c->add_role } qr/Cannot locate the role for the SessionTags plugin helper\./, 'add_role with no role input caught error ok';
throws_ok { $c->has_role } qr/Cannot locate the role for the SessionTags plugin helper\./, 'has_role with no role input caught error ok';
throws_ok { $c->nix_role } qr/Cannot locate the role for the SessionTags plugin helper\./, 'nix_role with no role input caught error ok';
throws_ok { $c->not_role } qr/Cannot locate the role for the SessionTags plugin helper\./, 'not_role with no role input caught error ok';

ok( $c->sum_role == $c->session->{my_key} );

done_testing();
