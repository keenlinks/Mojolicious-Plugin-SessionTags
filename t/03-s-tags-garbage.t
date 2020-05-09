use Mojo::Base -strict;

use Test::More;
use Mojolicious::Lite;
use Test::Mojo;
use Test::Exception;

plugin 'Mojolicious::Plugin::SessionTags' => { tags => [qw/ happy sad stupid smart goofy /] };

my $t = Test::Mojo->new;
my $c = $t->app->build_controller;

ok( $c->sum_tag == 0 );

ok( $c->sum_tag == $c->session->{tag} );

throws_ok { $c->add_tag( 'dodo1' ) } qr/"dodo1" is not a valid session tag for Mojolicious\:\:Plugin\:\:SessionTags/, 'add_tag with non-existant tag input caught error ok';
throws_ok { $c->add_tag( 'dodo2' ) } qr/"dodo2" is not a valid session tag for Mojolicious\:\:Plugin\:\:SessionTags/, 'add_tag with non-existant tag input caught error ok';
throws_ok { $c->add_tag( 'dodo3' ) } qr/"dodo3" is not a valid session tag for Mojolicious\:\:Plugin\:\:SessionTags/, 'add_tag with non-existant tag input caught error ok';

throws_ok { $c->has_tag( 'dodo1' ) } qr/"dodo1" is not a valid session tag for Mojolicious\:\:Plugin\:\:SessionTags/, 'has_tag with non-existant tag input caught error ok';
throws_ok { $c->has_tag( 'dodo2' ) } qr/"dodo2" is not a valid session tag for Mojolicious\:\:Plugin\:\:SessionTags/, 'has_tag with non-existant tag input caught error ok';
throws_ok { $c->has_tag( 'dodo3' ) } qr/"dodo3" is not a valid session tag for Mojolicious\:\:Plugin\:\:SessionTags/, 'has_tag with non-existant tag input caught error ok';

throws_ok { $c->nix_tag( 'dodo1' ) } qr/"dodo1" is not a valid session tag for Mojolicious\:\:Plugin\:\:SessionTags/, 'nix_tag with non-existant tag input caught error ok';
throws_ok { $c->nix_tag( 'dodo2' ) } qr/"dodo2" is not a valid session tag for Mojolicious\:\:Plugin\:\:SessionTags/, 'nix_tag with non-existant tag input caught error ok';
throws_ok { $c->nix_tag( 'dodo3' ) } qr/"dodo3" is not a valid session tag for Mojolicious\:\:Plugin\:\:SessionTags/, 'nix_tag with non-existant tag input caught error ok';

throws_ok { $c->not_tag( 'dodo1' ) } qr/"dodo1" is not a valid session tag for Mojolicious\:\:Plugin\:\:SessionTags/, 'not_tag with non-existant tag input caught error ok';
throws_ok { $c->not_tag( 'dodo2' ) } qr/"dodo2" is not a valid session tag for Mojolicious\:\:Plugin\:\:SessionTags/, 'not_tag with non-existant tag input caught error ok';
throws_ok { $c->not_tag( 'dodo3' ) } qr/"dodo3" is not a valid session tag for Mojolicious\:\:Plugin\:\:SessionTags/, 'not_tag with non-existant tag input caught error ok';

throws_ok { $c->add_tag } qr/No input provided for Mojolicious\:\:Plugin\:\:SessionTags/, 'add_tag with no tag input caught error ok';
throws_ok { $c->has_tag } qr/No input provided for Mojolicious\:\:Plugin\:\:SessionTags/, 'has_tag with no tag input caught error ok';
throws_ok { $c->nix_tag } qr/No input provided for Mojolicious\:\:Plugin\:\:SessionTags/, 'nix_tag with no tag input caught error ok';
throws_ok { $c->not_tag } qr/No input provided for Mojolicious\:\:Plugin\:\:SessionTags/, 'not_tag with no tag input caught error ok';

ok( $c->sum_tag == $c->session->{tag} );

done_testing();
