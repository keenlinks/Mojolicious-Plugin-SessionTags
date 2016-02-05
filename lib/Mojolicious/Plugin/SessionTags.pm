package Mojolicious::Plugin::SessionTags;

use Mojo::Base 'Mojolicious::Plugin';
use Carp;

our $VERSION = '0.03';

sub register {
	my ( $self, $app, $conf ) = @_;

	has name => $conf->{name} // 'tag';

	has session_key => 'sstag_' . $self->name;

	has place_values => sub {
		my $place_values = {};
		my $place_value = 0.5;
		$place_values->{$_} = ( $place_value *= 2 ) for @{ $conf->{tags} };
		return $place_values
	};

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

	sub _check_input_tag {
		my $self = shift;
		my $tag = shift // '';

		croak '"' . $tag . '" is not a valid ' . $self->name . ' for ' . __PACKAGE__
			unless $self->place_values->{$tag};

		return $tag;
	}
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
