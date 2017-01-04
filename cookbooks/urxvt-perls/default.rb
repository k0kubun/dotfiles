git '/tmp/urxvt-perls' do
  repository 'https://github.com/muennich/urxvt-perls'
  revision '2.2'
  not_if 'test -f /usr/lib/urxvt/perl/clipboard'
end

execute 'cp /tmp/urxvt-perls/clipboard /usr/lib/urxvt/perl/clipboard' do
  not_if 'test -f /usr/lib/urxvt/perl/clipboard'
end
