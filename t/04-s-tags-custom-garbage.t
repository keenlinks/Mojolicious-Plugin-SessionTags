use Mojo::Base -strict;

use Test::More;
use Mojolicious::Lite;
use Test::Mojo;
use Test::Exception;

plugin 'Mojolicious::Plugin::SessionTags' => { key => 'role', tag => 'role', tags => [qw/ user admin super exec nobody sam_i_am /] };

my $t = Test::Mojo->new;
my $c = $t->app->build_controller;

ok( $c->sum_role == 0 );

ok( $c->sum_role == $c->session->{role} );

throws_ok { $c->add_role( 'dodo1' ) } qr/"dodo1" is not a valid session tag for Mojolicious\:\:Plugin\:\:SessionTags/, 'add_role with non-existant role input caught error ok';
throws_ok { $c->add_role( 'dodo2' ) } qr/"dodo2" is not a valid session tag for Mojolicious\:\:Plugin\:\:SessionTags/, 'add_role with non-existant role input caught error ok';
throws_ok { $c->add_role( 'dodo3' ) } qr/"dodo3" is not a valid session tag for Mojolicious\:\:Plugin\:\:SessionTags/, 'add_role with non-existant role input caught error ok';

throws_ok { $c->has_role( 'dodo1' ) } qr/"dodo1" is not a valid session tag for Mojolicious\:\:Plugin\:\:SessionTags/, 'has_role with non-existant role input caught error ok';
throws_ok { $c->has_role( 'dodo2' ) } qr/"dodo2" is not a valid session tag for Mojolicious\:\:Plugin\:\:SessionTags/, 'has_role with non-existant role input caught error ok';
throws_ok { $c->has_role( 'dodo3' ) } qr/"dodo3" is not a valid session tag for Mojolicious\:\:Plugin\:\:SessionTags/, 'has_role with non-existant role input caught error ok';

throws_ok { $c->nix_role( 'dodo1' ) } qr/"dodo1" is not a valid session tag for Mojolicious\:\:Plugin\:\:SessionTags/, 'nix_role with non-existant role input caught error ok';
throws_ok { $c->nix_role( 'dodo2' ) } qr/"dodo2" is not a valid session tag for Mojolicious\:\:Plugin\:\:SessionTags/, 'nix_role with non-existant role input caught error ok';
throws_ok { $c->nix_role( 'dodo3' ) } qr/"dodo3" is not a valid session tag for Mojolicious\:\:Plugin\:\:SessionTags/, 'nix_role with non-existant role input caught error ok';

throws_ok { $c->not_role( 'dodo1' ) } qr/"dodo1" is not a valid session tag for Mojolicious\:\:Plugin\:\:SessionTags/, 'not_role with non-existant role input caught error ok';
throws_ok { $c->not_role( 'dodo2' ) } qr/"dodo2" is not a valid session tag for Mojolicious\:\:Plugin\:\:SessionTags/, 'not_role with non-existant role input caught error ok';
throws_ok { $c->not_role( 'dodo3' ) } qr/"dodo3" is not a valid session tag for Mojolicious\:\:Plugin\:\:SessionTags/, 'not_role with non-existant role input caught error ok';

throws_ok { $c->add_role } qr/No input provided for Mojolicious\:\:Plugin\:\:SessionTags/, 'add_role with no role input caught error ok';
throws_ok { $c->has_role } qr/No input provided for Mojolicious\:\:Plugin\:\:SessionTags/, 'has_role with no role input caught error ok';
throws_ok { $c->nix_role } qr/No input provided for Mojolicious\:\:Plugin\:\:SessionTags/, 'nix_role with no role input caught error ok';
throws_ok { $c->not_role } qr/No input provided for Mojolicious\:\:Plugin\:\:SessionTags/, 'not_role with no role input caught error ok';

ok( $c->sum_role == $c->session->{role} );

done_testing();
