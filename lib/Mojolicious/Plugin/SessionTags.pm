package Mojolicious::Plugin::SessionTags;

use Mojo::Base 'Mojolicious::Plugin';
use Carp;

our $VERSION = '0.05';

has session_key => 'sstag_tag';
has name => 'tag';
has place_values => sub { {} };

sub register {
	my ( $self, $app, $conf ) = @_;

	if ( $conf->{name} ) {
		$self->session_key( 'sstag_' . $conf->{name} );
		$self->name( $conf->{name} );
	}

	$self->place_values( $self->_set_place_values( $conf->{tags} ) );

	$app->helper(
		'sum_' . $self->name => sub {
			$_[0]->session->{ $self->session_key } = $_[0]->session->{ $self->session_key } // 0;
		}
	);

	$app->helper(
		'has_' . $self->name => sub {
			my $c = shift;
			my $tag = $self->_check_input_tag( shift );

			my $sum_helper = 'sum_' . $self->name;
			$c->$sum_helper & $self->place_values->{$tag} ? 1 : 0;
		}
	);

	$app->helper(
		'not_' . $self->name => sub {
			my $c = shift;
			my $tag = $self->_check_input_tag( shift );

			my $sum_helper = 'sum_' . $self->name;
			$c->$sum_helper & $self->place_values->{$tag} ? 0 : 1;
		}
	);

	$app->helper(
		'add_' . $self->name => sub {
			my $c = shift;
			my $tag = $self->_check_input_tag( shift );

			my $sum_helper = 'sum_' . $self->name;
			my $session_value = $c->$sum_helper;

			$c->session->{ $self->session_key } = $session_value & $self->place_values->{$tag} ? $session_value : $session_value + $self->place_values->{$tag};
		}
	);

	$app->helper(
		'nix_' . $self->name => sub {
			my $c = shift;
			my $tag = $self->_check_input_tag( shift );

			my $sum_helper = 'sum_' . $self->name;
			my $session_value = $c->$sum_helper;

			$c->session->{ $self->session_key } = $session_value & $self->place_values->{$tag} ? $session_value - $self->place_values->{$tag} : $session_value;
		}
	);
}

sub _check_input_tag {
	croak 'No input provided for ' . __PACKAGE__ unless $_[1];
	return $_[1] if $_[0]->place_values->{$_[1]};
	croak '"' . $_[1] . '" is not a valid ' . $_[0]->name . ' for ' . __PACKAGE__;
}

sub _set_place_values {
	my $pv = 0.5;
	return { map { $_ => $pv *= 2 } @{$_[1]} };
}

1;
__END__

=encoding utf-8

=head1 NAME

Mojolicious::Plugin::SessionTags - Blah blah blah

=head1 SYNOPSIS

  use Mojolicious::Plugin::SessionTags;

=head1 DESCRIPTION

Mojolicious::Plugin::SessionTags is

=head1 AUTHOR

Scott Kiehn E<lt>sk.keenlinks@gmail.comE<gt>

=head1 COPYRIGHT

Copyright 2015- Scott Kiehn

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 SEE ALSO

=cut
