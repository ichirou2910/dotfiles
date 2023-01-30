#!/usr/bin/perl

# obmenu-generator - schema file

=for comment

    item:      add an item inside the menu               {item => ["command", "label", "icon"]},
    cat:       add a category inside the menu             {cat => ["name", "label", "icon"]},
    sep:       horizontal line separator                  {sep => undef}, {sep => "label"},
    pipe:      a pipe menu entry                         {pipe => ["command", "label", "icon"]},
    file:      include the content of an XML file        {file => "/path/to/file.xml"},
    raw:       any XML data supported by Openbox          {raw => q(...)},
    beg:       begin of a category                        {beg => ["name", "icon"]},
    end:       end of a category                          {end => undef},
    obgenmenu: generic menu settings                {obgenmenu => ["label", "icon"]},
    exit:      default "Exit" action                     {exit => ["label", "icon"]},

=cut

# NOTE:
#    * Keys and values are case sensitive. Keep all keys lowercase.
#    * ICON can be a either a direct path to an icon or a valid icon name
#    * Category names are case insensitive. (X-XFCE and x_xfce are equivalent)

require "$ENV{HOME}/.config/obmenu-generator/config.pl";

## Text editor
my $editor = $CONFIG->{editor};

our $SCHEMA = [
    {sep => "QUICK START"},

    #         COMMAND                                                     LABEL                     ICON
    {beg  => ["Launch Apps",                                                                        "$ENV{HOME}/.icons/gladient/search.png"]},
    {cat  => ["utility",                                                  "Accessories",            "applications-utilities"]},
    {sep  => undef},
    {cat  => ["development",                                              "Development",            "applications-development"]},
    {sep  => undef},
    {cat  => ["education",                                                "Education",              "applications-science"]},
    {sep  => undef},
    {cat  => ["game",                                                     "Games",                  "applications-games"]},
    {sep  => undef},
    {cat  => ["graphics",                                                 "Graphics",               "applications-graphics"]},
    {sep  => undef},
    {cat  => ["audiovideo",                                               "Multimedia",             "applications-multimedia"]},
    {sep  => undef},
    {cat  => ["network",                                                  "Network",                "applications-internet"]},
    {sep  => undef},
    {cat  => ["office",                                                   "Office",                 "applications-office"]},
    {sep  => undef},
    {cat  => ["other",                                                    "Other",                  "applications-other"]},
    {sep  => undef},
    {cat  => ["settings",                                                 "Settings",               "applications-accessories"]},
    {sep  => undef},
    {cat  => ["system",                                                   "System",                 "applications-system"]},
    {end  => undef},

    {sep  => undef},

    {item => ["~/.scripts/default-apps/launch terminal",                  "Open Terminal",          "$ENV{HOME}/.icons/gladient/term.png"]},

    {sep  => undef},

    {item => ["~/.scripts/default-apps/launch filemanager",               "Open File Manager",      "$ENV{HOME}/.icons/gladient/file-manager.png"]},

    {sep  => undef},

    {pipe => ["~/.config/openbox/pipe-menu/ob-randr.py",                  "Monitor Settings",       "$ENV{HOME}/.icons/gladient/mon-settings.png"]},

    {sep  => undef},

    {sep => "SESSIONS"},

    {sep  => undef},

    {beg  => ["Power Menu",                                                                        "$ENV{HOME}/.icons/gladient/logout.png"]},
    {item => ["poweroff",                      "Shut down"]},
    {sep  => undef},
    {item => ["reboot",                      "Restart"]},
    {sep  => undef},
    {item => ["pkull -KILL -u $(whoami)",                      "Logout"]},
    {end  => undef},
]
