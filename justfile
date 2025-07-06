# ------------------
#  Configurables
# ------------------
APP_NAME         := "zephyr-app-base"
CMAKE_ARGS      := "-- -DCMAKE_EXPORT_COMPILE_COMMANDS=ON"
ESP_BOARD       := "esp32s3_devkitc"
NUCLEO_BOARD    := "nucleo_f302r8"

# ------------------
#  Tasks
# ------------------
init:
    sh ./scripts/setup.sh

# --- ESP32-S3 Tasks ---
build-esp32:
    (cd .. && west build \
        -p always \
        -b "{{ESP_BOARD}}/esp32s3/procpu" \
        -d "{{APP_NAME}}/build" \
        {{APP_NAME}}/app \
        {{CMAKE_ARGS}} \
        -DEXTRA_DTC_OVERLAY_FILE={{justfile_directory()}}/app/boards/{{ESP_BOARD}}.overlay)


# --- Nucleo F302R8 Tasks ---
build-nucleo:
    (cd .. && west build \
        -p always \
        -b {{NUCLEO_BOARD}} \
        -d "{{APP_NAME}}/build" \
        {{APP_NAME}}/app \
        {{CMAKE_ARGS}} \
        -DEXTRA_DTC_OVERLAY_FILE={{justfile_directory()}}/app/boards/{{NUCLEO_BOARD}}.overlay)

# --- Generic Tasks ---
all: build-esp32 build-nucleo

clean: 
    rm -rf "build"