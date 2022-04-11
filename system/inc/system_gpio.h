/*!
 * @file      system_gpio.h
 *
 * @brief     MCU GPIO-related functions header file
 *
 * The Clear BSD License
 * Copyright Semtech Corporation 2021. All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted (subject to the limitations in the disclaimer
 * below) provided that the following conditions are met:
 *     * Redistributions of source code must retain the above copyright
 *       notice, this list of conditions and the following disclaimer.
 *     * Redistributions in binary form must reproduce the above copyright
 *       notice, this list of conditions and the following disclaimer in the
 *       documentation and/or other materials provided with the distribution.
 *     * Neither the name of the Semtech corporation nor the
 *       names of its contributors may be used to endorse or promote products
 *       derived from this software without specific prior written permission.
 *
 * NO EXPRESS OR IMPLIED LICENSES TO ANY PARTY'S PATENT RIGHTS ARE GRANTED BY
 * THIS LICENSE. THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND
 * CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT
 * NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
 * PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL SEMTECH CORPORATION BE
 * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
 * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
 * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
 * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
 * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
 * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
 * POSSIBILITY OF SUCH DAMAGE.
 */

#ifndef SYSTEM_GPIO_H
#define SYSTEM_GPIO_H

#ifdef __cplusplus
extern "C" {
#endif

/*
 * -----------------------------------------------------------------------------
 * --- DEPENDENCIES ------------------------------------------------------------
 */

#include "configuration.h"

/*
 * -----------------------------------------------------------------------------
 * --- PUBLIC MACROS -----------------------------------------------------------
 */

/*
 * -----------------------------------------------------------------------------
 * --- PUBLIC CONSTANTS --------------------------------------------------------
 */

/*
 * -----------------------------------------------------------------------------
 * --- PUBLIC TYPES ------------------------------------------------------------
 */

typedef enum
{
    SYSTEM_GPIO_NO_INTERRUPT = 0,
    SYSTEM_GPIO_RISING,
    SYSTEM_GPIO_FALLING,
    SYSTEM_GPIO_BOTH,
} system_gpio_interrupt_t;

typedef enum
{
    SYSTEM_GPIO_PIN_ANTENNA_SELECTOR_CTRL,
    SYSTEM_GPIO_PIN_ANTENNA_SELECTOR_N_CTRL,
    SYSTEM_GPIO_PIN_LED_SCAN,
} system_gpio_pin_t;

typedef enum
{
    SYSTEM_GPIO_PIN_STATE_LOW,
    SYSTEM_GPIO_PIN_STATE_HIGH,
} system_gpio_pin_state_t;

typedef enum
{
    SYSTEM_GPIO_PIN_DIRECTION_INPUT,
    SYSTEM_GPIO_PIN_DIRECTION_OUTPUT,
} system_gpio_pin_direction_t;

/*
 * -----------------------------------------------------------------------------
 * --- PUBLIC FUNCTIONS PROTOTYPES ---------------------------------------------
 */

/*!
 * @brief Initialize the MCU GPIO
 */
void system_gpio_init( void );

/*!
 * @brief Set the state of a GPIO configured as output
 *
 * @param [in] gpio GPIO to be set
 * @param [in] state State to apply to the GPIO
 */
void system_gpio_set_pin_state( gpio_t gpio, const system_gpio_pin_state_t state );

/*!
 * @brief Get the state of a GPIO configured as output
 *
 * @param [in] gpio GPIO to read the state from
 *
 * @returns State of the GPIO
 */
system_gpio_pin_state_t system_gpio_get_pin_state( gpio_t gpio );
void system_gpio_init_direction_state( const gpio_t gpio, const system_gpio_pin_direction_t direction,
                                       const system_gpio_pin_state_t state );
void system_gpio_wait_for_state( gpio_t io, uint8_t state );

#ifdef __cplusplus
}
#endif

#endif  // SYSTEM_GPIO_H

/* --- EOF ------------------------------------------------------------------ */
