program blink;

type
  Tgpio_config = record
    pin_bit_mask: uint32;  // Pin mask of pins to configure
    mode: integer;         // 0 = disabled, 1 = input, 2 = output, 6 = output open drain
    pull_up_en: integer;   // 0 = disabled, 1 = enabled
    pull_down_en: integer; // 0 = disabled, 1 = enabled
    intr_type: integer;    // 0 = disabled, 1 = positive edge, 2 = negative edge, 3 = any edge, 4 = low level, 5 = high level
  end;

const
  // GPIO pin number for pin connected to LED
  LED = 2;  // NodeMCU LED on ESP-12E module

// Return value is error code, 0 = success
function gpio_config(constref gpio_cfg: Tgpio_config): integer; external;

// mode: GPIO_MODE_DISABLE = 0, GPIO_MODE_INPUT = 1, GPIO_MODE_OUTPUT = 2, GPIO_MODE_OUTPUT_OD = 6
function gpio_set_direction(gpio_num: integer; mode: integer): integer; external;

// level: Low = 0, High = 1
function gpio_set_level(gpio_num: integer; level: uint32): integer; external;

procedure vTaskDelay(xTicksToDelay: uint32); external;

var
  cfg: Tgpio_config;

begin
  cfg.pin_bit_mask := 1 shl ord(LED);
  cfg.mode := 1;
  cfg.pull_up_en := 0;
  cfg.pull_down_en := 0;
  cfg.intr_type := 0;
  gpio_config(cfg);

  gpio_set_direction(LED, 2);
  repeat
    writeln('.');
    gpio_set_level(LED, 0);
    vTaskDelay(100);
//    writeln('*');
    gpio_set_level(LED, 1);
    vTaskDelay(100);
  until false;
end.
