import sync

__global (
	sem   sync.Semaphore // needs initialization in `init()`
	mtx   sync.RwMutex // needs initialization in `init()`
	f1    = f64(34.0625) // explicily initialized
	shmap shared map[string]f64 // initialized as empty `shared` map
	f2    f64 // initialized to `0.0`
)

fn init() {
	sem.init(0)
	mtx.init()
}
