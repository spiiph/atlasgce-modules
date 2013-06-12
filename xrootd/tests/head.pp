class { 'xrootd::head':
    fqdnRedirector => 'ohhead.c.atlasgce.internal',
    ossLocalRoot   => '/data/scratch',
    storagePath    => '/atlas',
}
