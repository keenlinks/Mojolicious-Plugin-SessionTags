use Mojo::Base -strict;

use Test::More;
use Mojolicious::Lite;
use Test::Mojo;
use Test::Exception;

plugin 'Mojolicious::Plugin::SessionTags' => { tags => [qw/ happy sad stupid smart goofy /] };

my $t = Test::Mojo->new;
my $c = $t->app->build_controller;

ok( $c->sum_tag == $c->session->{s_tags} );

throws_ok { $c->add_tag( 'dodo1' ) } qr/Cannot locate the tag for the SessionTags plugin helper\./, 'add_tag with non-existant tag input caught error ok';
throws_ok { $c->add_tag( 'dodo2' ) } qr/Cannot locate the tag for the SessionTags plugin helper\./, 'add_tag with non-existant tag input caught error ok';
throws_ok { $c->add_tag( 'dodo3' ) } qr/Cannot locate the tag for the SessionTags plugin helper\./, 'add_tag with non-existant tag input caught error ok';

throws_ok { $c->has_tag( 'dodo1' ) } qr/Cannot locate the tag for the SessionTags plugin helper\./, 'has_tag with non-existant tag input caught error ok';
throws_ok { $c->has_tag( 'dodo2' ) } qr/Cannot locate the tag for the SessionTags plugin helper\./, 'has_tag with non-existant tag input caught error ok';
throws_ok { $c->has_tag( 'dodo3' ) } qr/Cannot locate the tag for the SessionTags plugin helper\./, 'has_tag with non-existant tag input caught error ok';

throws_ok { $c->nix_tag( 'dodo1' ) } qr/Cannot locate the tag for the SessionTags plugin helper\./, 'nix_tag with non-existant tag input caught error ok';
throws_ok { $c->nix_tag( 'dodo2' ) } qr/Cannot locate the tag for the SessionTags plugin helper\./, 'nix_tag with non-existant tag input caught error ok';
throws_ok { $c->nix_tag( 'dodo3' ) } qr/Cannot locate the tag for the SessionTags plugin helper\./, 'nix_tag with non-existant tag input caught error ok';

throws_ok { $c->not_tag( 'dodo1' ) } qr/Cannot locate the tag for the SessionTags plugin helper\./, 'not_tag with non-existant tag input caught error ok';
throws_ok { $c->not_tag( 'dodo2' ) } qr/Cannot locate the tag for the SessionTags plugin helper\./, 'not_tag with non-existant tag input caught error ok';
throws_ok { $c->not_tag( 'dodo3' ) } qr/Cannot locate the tag for the SessionTags plugin helper\./, 'not_tag with non-existant tag input caught error ok';

throws_ok { $c->add_tag } qr/Cannot locate the tag for the SessionTags plugin helper\./, 'add_tag with no tag input caught error ok';
throws_ok { $c->has_tag } qr/Cannot locate the tag for the SessionTags plugin helper\./, 'has_tag with no tag input caught error ok';
throws_ok { $c->nix_tag } qr/Cannot locate the tag for the SessionTags plugin helper\./, 'nix_tag with no tag input caught error ok';
throws_ok { $c->not_tag } qr/Cannot locate the tag for the SessionTags plugin helper\./, 'not_tag with no tag input caught error ok';

ok( $c->sum_tag == $c->session->{s_tags} );

done_testing();
