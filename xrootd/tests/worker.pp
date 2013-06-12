class { 'xrootd::worker':
    fqdnRedirector => 'ohhead.c.atlasgce.internal',
    ossLocalRoot   => '/data/scratch',
    storagePath    => '/atlas',
}
