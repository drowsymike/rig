#ifndef __MAIN_H
#define __MAIN_H

#ifdef __cplusplus
extern "C" {
#endif

#include "stm32f4xx_hal.h"

void spi_init(void);
void SystemClock_Config();
void dc_res_blk_init(void);

#ifdef __cplusplus
}
#endif

#endif
