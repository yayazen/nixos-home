{
  config,
  pkgs,
  lib,
  ...
}:
let
  colorscheme = (import ./colors.nix).colorscheme;

  mkVirtualBoxes =
    boxes:
    "${builtins.concatStringsSep "\n" (
      map (
        {
          name,
          query,
        }:
        ''virtual-mailboxes "${name}" "notmuch://?query=${lib.escapeURL query}"''
      ) boxes
    )}";
in
{
  programs.neomutt = {
    enable = true;
    package = pkgs.neomutt;

    editor = config.home.sessionVariables.EDITOR;
    vimKeys = true;

    sidebar.width = 40;
    sidebar.enable = true;
    sidebar.shortPath = true;
    sidebar.format = "%D%> %?N?%N/?%S";

    extraConfig = ''
      # general

      # Enable thread display
      set sort = threads       # Sort by threads
      set sort_aux = reverse-last-date-received

      set index_format="%4C %Z %{%b %d} %-15.15L (%<l?%4l&%4c>) %s [%g]"
      set hidden_tags = "unread,draft,flagged,passed,replied,attachment,signed,encrypted"
      color index_tags green default

      # neomutt bindings
      bind pager ,g group-reply

      # notmuch settings
      set nm_exclude_tags = "deleted,killed"
      set nm_record = yes
      set nm_record_tags = "sent"
      set nm_unread_tag = "unread"

      # notmuch virtual mailboxes
      ${mkVirtualBoxes [
        {
          name = "Inbox";
          query = "tag:inbox and NOT tag:archive";
        }
        {
          name = "Unread";
          query = "tag:unread";
        }
        {
          name = "Sent";
          query = "tag:sent";
        }
        {
          name = "Junk";
          query = "tag:junk or tag:spam or tag:deleted";
        }
      ]}

      # notmuch bindings
      macro index \\\\ "<vfolder-from-query>"              # looks up a hand made query
      macro index dd "<modify-labels-then-hide>+deleted<enter>" # tag as deleted
      macro index u "<modify-tags-then-hide>-deleted<enter><sync-mailbox>" # remove deleted tag

      macro index A "<modify-labels-then-hide>+archive -unread -inbox<enter><sync-mailbox>"  # tag as Archived
      macro index S "<modify-labels-then-hide>-inbox -unread +junk<enter><sync-mailbox>" # tag as Junk
      macro index + "<modify-labels>+*<enter><sync-mailbox>"               # tag as starred
      macro index - "<modify-labels>-*<enter><sync-mailbox>"               # tag as unstarred

      # sidebar config
      set sidebar_delim_chars="/"             # Delete everything up to the last / character
      set sidebar_folder_indent               # Indent folders whose names we've shortened
      set sidebar_indent_string="  "          # Indent with two spaces
      set mail_check_stats=yes
      set sidebar_component_depth="1"
      set sidebar_sort_method = "path"
      set sidebar_new_mail_only = no
      set sidebar_non_empty_mailbox_only = no
      color sidebar_new yellow default
      # sidebar bindings
      bind index,pager K sidebar-prev       
      bind index,pager J sidebar-next       
      bind index,pager \CO sidebar-open       # Ctrl-Shift-O - Open Highlighted Mailbox
      bind index,pager B sidebar-toggle-visible

      # mailcap
      set header_cache_backend='lmdb'
      set header_cache='~/mail/hcache'
      set header_cache_compress_method = "zstd"
      set header_cache_compress_level = 10

      alternative_order text/plain text/html image/jpeg image/png
      set mailcap_path = ~/.config/mailcap

      set mime_forward = no
      set forward_attachments = yes
      macro pager \cb "<pipe-message> ${pkgs.urlscan}/bin/urlscan<Enter>" "call urlscan to extract URLs out of a message"
      macro index,pager O "<shell-escape>mbsync -a<enter>" "run mbsync to sync all emails"
      macro attach 'V' "<pipe-entry>iconv -c --to-code=UTF8 > ~/.cache/mutt/mail.html<enter><shell-escape>$BROWSER ~/.cache/mutt/mail.html<enter>"

      auto_view text/html image/*
      ${colorscheme}
    '';
  };
}
