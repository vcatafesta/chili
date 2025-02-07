using GLib;
using DBus;

// Define a estrutura que representa uma unidade retornada pelo método ListUnits.
// A anotação DBus (signature="(ssssssosos)") indica o formato (tuple) esperado:
[DBus (signature="(ssssssosos)")]
public struct UnitInfo {
    public string name;
    public string description;
    public string load_state;
    public string active_state;
    public string sub_state;
    public string followed;
    public ObjectPath object_path;
    public int job_id;
    public string job_type;
    public ObjectPath job_path;
}

// Define a interface DBus para o Manager do systemd
[DBus (name="org.freedesktop.systemd1", default_path="/org/freedesktop/systemd1")]
public interface Manager : Object {
    // O método ListUnits retorna um array de UnitInfo
    public abstract UnitInfo[] ListUnits () throws DBus.Error;
}

public static int main (string[] args) {
    try {
        // Conecta ao barramento do sistema usando a API correta de GDBus
        DBusConnection connection = Bus.get_sync(BusType.SYSTEM);
        
        // Cria um proxy para a interface Manager do systemd
        Manager manager = connection.get_object("org.freedesktop.systemd1", "/org/freedesktop/systemd1") as Manager;

        // Chama o método ListUnits para obter todas as unidades
        UnitInfo[] units = manager.ListUnits();

        // Itera sobre as unidades filtrando aquelas que terminam com ".service"
        foreach (UnitInfo unit in units) {
            if (unit.name.ends_with(".service")) {
                stdout.printf("%s - %s [%s / %s]\n",
                    unit.name,
                    unit.description,
                    unit.active_state,
                    unit.sub_state
                );
            }
        }
    } catch (GLib.Error e) {
        stderr.printf("Erro GLib: %s\n", e.message);
        return 1;
    } catch (DBus.Error e) {
        stderr.printf("Erro DBus: %s\n", e.message);
        return 1;
    }
    return 0;
}

