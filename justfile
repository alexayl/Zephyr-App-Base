# ------------------
#  Configurables
# ------------------
APP_DIR         := "app"
BUILD_DIR_BASE  := "build"
CMAKE_ARGS      := "-- -DCMAKE_EXPORT_COMPILE_COMMANDS=ON"
ESP_BOARD       := "esp32s3_devkitc"
NUCLEO_BOARD    := "nucleo_f302r8"

# ------------------
#  Tasks
# ------------------

# --- ESP32-S3 Tasks ---
build-esp32:
    (cd .. && west build \
        -p always \
        -b "{{ESP_BOARD}}/esp32s3/procpu" \
        -d "example-application/{{BUILD_DIR_BASE}}-esp32" \
        example-application/{{APP_DIR}} \
        {{CMAKE_ARGS}} \
        -DEXTRA_DTC_OVERLAY_FILE={{justfile_directory()}}/{{APP_DIR}}/boards/{{ESP_BOARD}}.overlay)

clean-esp32:
    rm -rf "{{BUILD_DIR_BASE}}-esp32"

# --- Nucleo F302R8 Tasks ---
build-nucleo:
    (cd .. && west build \
        -p always \
        -b {{NUCLEO_BOARD}} \
        -d "example-application/{{BUILD_DIR_BASE}}-nucleo" \
        example-application/{{APP_DIR}} \
        {{CMAKE_ARGS}} \
        -DEXTRA_DTC_OVERLAY_FILE={{justfile_directory()}}/{{APP_DIR}}/boards/{{NUCLEO_BOARD}}.overlay)

clean-nucleo:
    rm -rf "{{BUILD_DIR_BASE}}-nucleo"

# --- Generic Tasks ---
all: build-esp32 build-nucleo

clean: clean-esp32 clean-nucleo