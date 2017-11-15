package Trac::RPC::Ticket;
{
  $Trac::RPC::Ticket::VERSION = '1.0.0';
}



use strict;
use warnings;

use base qw(Trac::RPC::Base);

sub get {
    my ($self, $ticket) = @_;

    return $self->call(
        'ticket.get',
        RPC::XML::int->new($ticket)
    );
}

sub create {
    my ($self, $summary, $description, $struct) = @_;

    my $rpc_struct = RPC::XML::struct->new(
        type      => RPC::XML::string->new($struct->{type}),  
        owner     => RPC::XML::string->new($struct->{owner}),  
        component => RPC::XML::string->new($struct->{component}),  
    );

    return $self->call(
        'ticket.create',
        RPC::XML::string->new($summary),
        RPC::XML::string->new($description),
        $rpc_struct,
    );
}


1;

__END__

=pod

=head1 NAME

Trac::RPC::Ticket

=head1 VERSION

version 1.0.0

=encoding UTF-8

=head1 NAME

Trac::RPC::Ticket - access to Trac Ticket methods via Trac XML-RPC Plugin

In the current version, only get() and create() are implemented.

=head1 USAGE

  use Trac::RPC::Ticket;
  use Data::Dumper;
  
  my $params = {
      realm    => "somerealm",
      user     => "someuser",
      password => "somepassword",
      host     => "http://somewhere.com.au/trac/login/xmlrpc",
  };
  
  my $trac = Trac::RPC::Ticket->new($params);
  
  print Dumper($trac->get(123)) . "\n";

=head1 GENERAL FUNCTIONS

=head2 get

Fetch a ticket. Returns [id, time_created, time_changed, attributes]

  my $trac = Trac::RPC::Ticket->new($params);
  
  print Dumper($trac->get(123)) . "\n";


=head2 create

Create a new ticket, returning the ticket ID.

  my $trac = Trac::RPC::Ticket->new($params);
  
  my $summary     = "Ticket created from Perl";
  my $description = "Via the XML RPC";
  my $data = {
      type      => 'defect',
      owner     => 'someone',
      component => 'Somecomponent',
  };
  
  my $ticket = $trac->create($summary, $description, $data);
  print "ticket: $ticket\n";

=head1 AUTHOR

Simon Taylor <simon@unisolve.com.au>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2017 by Simon Taylor, (c) 2011 by Ivan Bessarabov.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
