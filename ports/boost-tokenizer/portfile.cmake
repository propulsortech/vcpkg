# Automatically generated by scripts/boost/generate-ports.ps1

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO boostorg/tokenizer
    REF boost-1.81.0
    SHA512 e88ba7f22f028a0d96ee7dbc9ebd4385dfb188ef400a5fb267b60d6f847a25554d69403213b8a72c6c39d373ba27f27cb46c8a851562a1ea3685f7f1ed1acc5a
    HEAD_REF master
)

include(${CURRENT_INSTALLED_DIR}/share/boost-vcpkg-helpers/boost-modular-headers.cmake)
boost_modular_headers(SOURCE_PATH ${SOURCE_PATH})
