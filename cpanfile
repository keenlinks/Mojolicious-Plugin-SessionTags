requires 'perl', '5.008001';
requires 'Mojolicious', '6.20';

on 'configure' => sub {
    requires 'Module::Build::Tiny', '0.039';
};

on 'test' => sub {
    requires 'Test::More', '1.302175';
    requires 'Test::Exception', '0.43';
};
