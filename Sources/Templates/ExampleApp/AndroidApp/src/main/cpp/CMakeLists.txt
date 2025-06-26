cmake_minimum_required(VERSION 3.22.1)
project(native_lib)

# Créer la bibliothèque partagée
add_library(native_lib SHARED
    native_lib.c)

# Trouver et lier la bibliothèque log d'Android
find_library(log-lib log)
target_link_libraries(native_lib ${log-lib}) 