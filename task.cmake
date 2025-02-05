#!/usr/bin/env -S cmake -P
cmake_minimum_required(VERSION 3.30)

file(READ "./CMakeLists.txt" cmake_lists)
string(REGEX MATCH "project\\(.*\\)" project_line "${cmake_lists}")
string(REGEX MATCH "VERSION [0-9]+\\.[0-9]+\\.[0-9]+" version_line "${cmake_lists}")
string(REGEX MATCH "[0-9]+\\.[0-9]+\\.[0-9]+" llvm_version "${version_line}")
if(NOT llvm_version)
    message(FATAL_ERROR "Failed to extract LLVM version from CMakeLists.txt")
endif()

function(generate_llvm_src)
    if(EXISTS "./llvm-${llvm_version}.src.tar.xz")
        message("Using existing ./llvm-${llvm_version}.src.tar.xz")
    else()
        message("Downloading llvm/llvm-project llvm-${llvm_version}.src.tar.xz")
        set(url "https://github.com/llvm/llvm-project/releases/download/llvmorg-${llvm_version}/llvm-${llvm_version}.src.tar.xz")
        file(
            DOWNLOAD "${url}"
            "./llvm-${llvm_version}.src.tar.xz"
            STATUS status
            SHOW_PROGRESS
        )
        list(GET status 0 exit_status)
        list(GET status 1 error_message)
        if(NOT exit_status EQUAL 0)
            message(FATAL_ERROR "${error_message}")
            file(REMOVE "./llvm-${llvm_version}.src.tar.xz")
        endif()
        message("Downloaded ./llvm-${llvm_version}.src.tar.xz")
    endif()

    message("Extracting ./llvm-${llvm_version}.src.tar.xz")
    file(ARCHIVE_EXTRACT
        INPUT "./llvm-${llvm_version}.src.tar.xz"
        PATTERNS
            "llvm-${llvm_version}.src/lib/TargetParser/*"
            "llvm-${llvm_version}.src/lib/Support/*"
    )
    message("Extracted ./llvm-${llvm_version}.src.tar.xz")
    if(EXISTS "./llvm.src")
        message("Removing existing ./llvm.src")
        file(REMOVE_RECURSE "./llvm.src")
    endif()
    file(RENAME "./llvm-${llvm_version}.src" "./llvm.src")
    message("Renamed ./llvm-${llvm_version}.src to ./llvm.src")
endfunction()

function(generate_llvm_linux_x64)
    if(EXISTS "./LLVM-${llvm_version}-Linux-X64.tar.xz")
        message("Using existing ./LLVM-${llvm_version}-Linux-X64.tar.xz")
    else()
        message("Downloading llvm/llvm-project LLVM-${llvm_version}-Linux-X64.tar.xz")
        set(url "https://github.com/llvm/llvm-project/releases/download/llvmorg-${llvm_version}/LLVM-${llvm_version}-Linux-X64.tar.xz")
        file(
            DOWNLOAD "${url}"
            "./LLVM-${llvm_version}-Linux-X64.tar.xz"
            STATUS status
            SHOW_PROGRESS
        )
        list(GET status 0 exit_status)
        list(GET status 1 error_message)
        if(NOT exit_status EQUAL 0)
            message(FATAL_ERROR "${error_message}")
            file(REMOVE "./LLVM-${llvm_version}-Linux-X64.tar.xz")
        endif()
        message("Downloaded ./LLVM-${llvm_version}-Linux-X64.tar.xz")
    endif()

    message("Extracting ./LLVM-${llvm_version}-Linux-X64.tar.xz")
    file(ARCHIVE_EXTRACT
        INPUT "./LLVM-${llvm_version}-Linux-X64.tar.xz"
        PATTERNS
            "LLVM-${llvm_version}-Linux-X64/include/llvm/ADT/*"
            "LLVM-${llvm_version}-Linux-X64/include/llvm/Config/*"
            "LLVM-${llvm_version}-Linux-X64/include/llvm/Support/*"
            "LLVM-${llvm_version}-Linux-X64/include/llvm/Demangle/*"
            "LLVM-${llvm_version}-Linux-X64/include/llvm/TargetParser/*"
            "LLVM-${llvm_version}-Linux-X64/include/llvm-c/*"
    )
    message("Extracted ./LLVM-${llvm_version}-Linux-X64.tar.xz")
    if(EXISTS "./LLVM-Linux-X64")
        message("Removing existing ./LLVM-Linux-X64")
        file(REMOVE_RECURSE "./LLVM-Linux-X64")
    endif()
    file(RENAME "./LLVM-${llvm_version}-Linux-X64" "./LLVM-Linux-X64")
    message("Renamed ./LLVM-${llvm_version}-Linux-X64 to ./LLVM-Linux-X64")
endfunction()

function(generate)
    generate_llvm_src()
    generate_llvm_linux_x64()
endfunction()

# ./task.cmake <task_name> => cmake -P ./task.cmake <task_name>
# ["cmake", "-P", "./task.cmake", <task_name>]
set(task_name "${CMAKE_ARGV3}")
if(NOT task_name)
    message(FATAL_ERROR "No task name")
endif()
if(task_name STREQUAL "generate:llvm.src")
    generate_llvm_src()
elseif(task_name STREQUAL "generate:LLVM-Linux-X64")
    task_name()
elseif(task_name STREQUAL "generate")
    generate()
else()
    message(FATAL_ERROR "Unknown task name '${task_name}'")
endif()
