#!/usr/bin/env -S uv run --script
# /// script
# requires-python = ">=3.12"
# dependencies = [
#   "requests",
# ]
# ///
import sys
import requests
import subprocess
import tarfile
import os
import shutil
import functools

@functools.cache
def latest_llvm_version() -> str:
    response = requests.get("https://api.github.com/repos/llvm/llvm-project/releases/latest")
    response.raise_for_status()
    return response.json()["tag_name"].replace("llvmorg-", "")

def generate_llvm_src() -> None:
    if len(sys.argv) > 2:
        version = sys.argv[2]
    else:
        version = latest_llvm_version()

    if os.path.exists(f"llvm-{version}.src.tar.xz"):
        print(f"Using existing llvm-{version}.src.tar.xz")
    else:
        print(f"Downloading llvm-{version}.src.tar.xz")
        with requests.get(f"https://github.com/llvm/llvm-project/releases/download/llvmorg-{version}/llvm-{version}.src.tar.xz", stream=True) as response:
            response.raise_for_status()
            with open(f"llvm-{version}.src.tar.xz", "wb") as f:
                for chunk in response.iter_content(chunk_size=8192):
                    f.write(chunk)
        print(f"Downloaded llvm-{version}.src.tar.xz")
    
    print(f"Extracting llvm-{version}.src.tar.xz")
    with tarfile.open(f"llvm-{version}.src.tar.xz", "r") as tar:
        tar.extractall(".", [m for m in tar.getmembers() if m.name.startswith(f"llvm-{version}.src/lib/TargetParser/") or m.name.startswith(f"llvm-{version}.src/lib/Support/")])
    print(f"Extracted llvm-{version}.src.tar.xz")
    if os.path.exists("llvm.src"):
        print(f"Removing existing llvm.src")
        shutil.rmtree("llvm.src")
    os.rename(f"llvm-{version}.src", "llvm.src")
    print(f"Renamed llvm-{version}.src (extracted) to llvm.src")

    with open("llvm.src/VERSION", "w") as f:
        f.write(version)
    print(f"Created llvm.src/VERSION")

def generate_llvm_linux_x64() -> None:
    if len(sys.argv) > 2:
        version = sys.argv[2]
    else:
        version = latest_llvm_version()

    if os.path.exists(f"LLVM-{version}-Linux-X64.tar.xz"):
        print(f"Using existing LLVM-{version}-Linux-X64.tar.xz")
    else:
        print(f"Downloading LLVM-{version}-Linux-X64.tar.xz")
        with requests.get(f"https://github.com/llvm/llvm-project/releases/download/llvmorg-{version}/LLVM-{version}-Linux-X64.tar.xz", stream=True) as response:
            response.raise_for_status()
            with open(f"LLVM-{version}-Linux-X64.tar.xz", "wb") as f:
                for chunk in response.iter_content(chunk_size=8192):
                    f.write(chunk)
        print(f"Downloaded LLVM-{version}-Linux-X64.tar.xz")

    print(f"Extracting LLVM-{version}-Linux-X64.tar.xz")
    with tarfile.open(f"LLVM-{version}-Linux-X64.tar.xz", "r") as tar:
        tar.extractall(".", [m for m in tar.getmembers() if m.name.startswith(f"LLVM-{version}-Linux-X64/include/llvm/ADT/") or m.name.startswith(f"LLVM-{version}-Linux-X64/include/llvm/Config/") or m.name.startswith(f"LLVM-{version}-Linux-X64/include/llvm/Support/") or m.name.startswith(f"LLVM-{version}-Linux-X64/include/llvm/Demangle/") or m.name.startswith(f"LLVM-{version}-Linux-X64/include/llvm/TargetParser/") or m.name.startswith(f"LLVM-{version}-Linux-X64/include/llvm-c/")])
    print(f"Extracted LLVM-{version}-Linux-X64.tar.xz")
    if os.path.exists("LLVM-Linux-X64"):
        print(f"Removing existing LLVM-Linux-X64")
        shutil.rmtree("LLVM-Linux-X64")
    os.rename(f"LLVM-{version}-Linux-X64", "LLVM-Linux-X64")
    print(f"Renamed LLVM-{version}-Linux-X64 (extracted) to LLVM-Linux-X64")

    with open("LLVM-Linux-X64/VERSION", "w") as f:
        f.write(version)
    print(f"Created LLVM-Linux-X64/VERSION")
    
def generate() -> None:
    generate_llvm_src()
    generate_llvm_linux_x64()

def main() -> None:
    tasks = {
        "generate": generate,
        "generate:llvm.src": generate_llvm_src,
        "generate:LLVM-Linux-X64": generate_llvm_linux_x64,
    }
    task_name = sys.argv[1]
    task = tasks[task_name]
    task()

if __name__ == "__main__":
    main()