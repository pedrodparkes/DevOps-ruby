class glash_ci::jenkins {
  include jenkins

  jenkins::plugin { 'ghprb':
    version => '1.33.1',
  }
  jenkins::plugin { 'git':
    version => '3.0.0',
  }
  jenkins::plugin { 'structs':
    version => '1.5',
  }
  jenkins::plugin { 'plain-credentials':
    version => '1.2',
  }
  jenkins::plugin { 'github-api':
    version => '1.77',
  }
  jenkins::plugin { 'github-oauth':
    version => '0.24',
  }
  jenkins::plugin { 'display-url-api':
    version => '0.3',
  }
  jenkins::plugin { 'bouncycastle-api':
    version => '1.648.3',
  }
  jenkins::plugin { 'token-macro':
    version => '1.12.1',
  }
  jenkins::plugin { 'ssh-credentials':
    version => '1.12',
  }
  jenkins::plugin { 'git-client':
    version => '2.0.0',
  }
  jenkins::plugin { 'mailer':
    version => '1.18',
  }
  jenkins::plugin { 'workflow-scm-step':
    version => '2.2',
  }
  jenkins::plugin { 'junit':
    version => '1.18',
  }
  jenkins::plugin { 'ssh-agent':
    version => '1.13',
  }
  jenkins::plugin { 'matrix-project':
    version => '1.7.1',
  }
  jenkins::plugin { 'workflow-step-api':
    version => '2.3',
  }
  jenkins::plugin { 'scm-api':
    version => '1.3',
  }
  jenkins::plugin { 'github':
    version => '1.21.1',
  }
  jenkins::plugin { 'script-security':
    version => '1.22',
  }
}