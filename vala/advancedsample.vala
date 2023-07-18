/* class derived from GObject */
public class AdvancedSample : Object {

    /* automatic property, data field is implicit */
    public string name { get; set; }

    /* signal */
    public signal void foo ();

    /* creation method */
    public AdvancedSample (string name) {
        this.name = name;
    }

    /* public instance method */
    public void run () {
        /* assigning anonymous function as signal handler */
        this.foo.connect ((s) => {
            stdout.printf ("Lambda expression %s!\n", this.name);
        });

        /* emitting the signal */
        this.foo ();
    }

    /* application entry point */
    public static int main (string[] args) {
        foreach (string arg in args) {
            var sample = new AdvancedSample (arg);
            sample.run ();
            /* "sample" is freed as block ends */
        }
        return 0;
    }
}
