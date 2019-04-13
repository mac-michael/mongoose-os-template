#include "mgos.h"
#include <mgos_config.h>

int run();

static void my_timer_cb(void *arg) {
	double t = mgos_uptime();
	LOG(LL_INFO, ("uptime: %.2lf", t));

	(void) arg;
}

enum mgos_app_init_result mgos_app_init() {
	run();

	mgos_set_timer(1000, MGOS_TIMER_REPEAT, my_timer_cb, NULL);

	return MGOS_APP_INIT_SUCCESS;
}

int run() {
	LOG(LL_INFO, (("Hi from run()")));

	return 0;
}