[DBus (name = "im.pidgin.purple.PurpleInterface")]
interface Purple : Object {
    public signal void received_im_msg (int account, string sender, string msg,
                                        int conv, uint flags);

    public abstract int[] purple_accounts_get_all_active () throws GLib.Error;
    public abstract string purple_account_get_username (int account) throws GLib.Error;
}

int main () {
    try {
        Purple purple = Bus.get_proxy_sync (BusType.SESSION,
                                            "im.pidgin.purple.PurpleService",
                                            "/im/pidgin/purple/PurpleObject");

        var accounts = purple.purple_accounts_get_all_active ();
        foreach (int account in accounts) {
            string username = purple.purple_account_get_username (account);
            stdout.printf ("Account %s\n", username);
        }

        purple.received_im_msg.connect ((account, sender, msg) => {
            stdout.printf (@"Message received $sender: $msg\n");
        });

        var loop = new MainLoop ();
        loop.run ();

    } catch (GLib.Error e) {
        stderr.printf ("%s\n", e.message);
        return 1;
    }

    return 0;
}
