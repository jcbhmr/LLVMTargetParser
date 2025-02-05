cmake_minimum_required(VERSION 3.30)

project(LLVMTargerParser LANGUAGES C CXX)

add_library(LLVMSupportBlake3)
target_sources(LLVMSupportBlake3 PRIVATE
    ./llvm.src/lib/Support/BLAKE3/blake3.c
    ./llvm.src/lib/Support/BLAKE3/blake3_dispatch.c
    ./llvm.src/lib/Support/BLAKE3/blake3_portable.c
    ./llvm.src/lib/Support/BLAKE3/blake3_neon.c
)
target_compile_definitions(LLVMSupportBlake3 PUBLIC BLAKE3_NO_AVX512 BLAKE3_NO_AVX2 BLAKE3_NO_SSE41 BLAKE3_NO_SSE2)
target_include_directories(LLVMSupportBlake3 PRIVATE ./LLVM-Linux-X64/include)
target_compile_features(LLVMSupportBlake3 PUBLIC c_std_17)

add_library(LLVMSupport)
target_sources(LLVMSupport PRIVATE
    ./llvm.src/lib/Support/ABIBreak.cpp
    ./llvm.src/lib/Support/AMDGPUMetadata.cpp
    ./llvm.src/lib/Support/APFixedPoint.cpp
    ./llvm.src/lib/Support/APFloat.cpp
    ./llvm.src/lib/Support/APInt.cpp
    ./llvm.src/lib/Support/APSInt.cpp
    ./llvm.src/lib/Support/ARMBuildAttrs.cpp
    ./llvm.src/lib/Support/ARMAttributeParser.cpp
    ./llvm.src/lib/Support/ARMWinEH.cpp
    ./llvm.src/lib/Support/Allocator.cpp
    ./llvm.src/lib/Support/AutoConvert.cpp
    ./llvm.src/lib/Support/Base64.cpp
    ./llvm.src/lib/Support/BalancedPartitioning.cpp
    ./llvm.src/lib/Support/BinaryStreamError.cpp
    ./llvm.src/lib/Support/BinaryStreamReader.cpp
    ./llvm.src/lib/Support/BinaryStreamRef.cpp
    ./llvm.src/lib/Support/BinaryStreamWriter.cpp
    ./llvm.src/lib/Support/BlockFrequency.cpp
    ./llvm.src/lib/Support/BranchProbability.cpp
    ./llvm.src/lib/Support/BuryPointer.cpp
    ./llvm.src/lib/Support/CachePruning.cpp
    ./llvm.src/lib/Support/Caching.cpp
    ./llvm.src/lib/Support/circular_raw_ostream.cpp
    ./llvm.src/lib/Support/Chrono.cpp
    ./llvm.src/lib/Support/COM.cpp
    ./llvm.src/lib/Support/CodeGenCoverage.cpp
    ./llvm.src/lib/Support/CommandLine.cpp
    ./llvm.src/lib/Support/Compression.cpp
    ./llvm.src/lib/Support/CRC.cpp
    ./llvm.src/lib/Support/ConvertUTF.cpp
    ./llvm.src/lib/Support/ConvertEBCDIC.cpp
    ./llvm.src/lib/Support/ConvertUTFWrapper.cpp
    ./llvm.src/lib/Support/CrashRecoveryContext.cpp
    ./llvm.src/lib/Support/CSKYAttributes.cpp
    ./llvm.src/lib/Support/CSKYAttributeParser.cpp
    ./llvm.src/lib/Support/DataExtractor.cpp
    ./llvm.src/lib/Support/Debug.cpp
    ./llvm.src/lib/Support/DebugCounter.cpp
    ./llvm.src/lib/Support/DeltaAlgorithm.cpp
    ./llvm.src/lib/Support/DivisionByConstantInfo.cpp
    ./llvm.src/lib/Support/DAGDeltaAlgorithm.cpp
    ./llvm.src/lib/Support/DJB.cpp
    ./llvm.src/lib/Support/DynamicAPInt.cpp
    ./llvm.src/lib/Support/ELFAttributeParser.cpp
    ./llvm.src/lib/Support/ELFAttributes.cpp
    ./llvm.src/lib/Support/Error.cpp
    ./llvm.src/lib/Support/ErrorHandling.cpp
    ./llvm.src/lib/Support/ExponentialBackoff.cpp
    ./llvm.src/lib/Support/ExtensibleRTTI.cpp
    ./llvm.src/lib/Support/FileCollector.cpp
    ./llvm.src/lib/Support/FileUtilities.cpp
    ./llvm.src/lib/Support/FileOutputBuffer.cpp
    ./llvm.src/lib/Support/FloatingPointMode.cpp
    ./llvm.src/lib/Support/FoldingSet.cpp
    ./llvm.src/lib/Support/FormattedStream.cpp
    ./llvm.src/lib/Support/FormatVariadic.cpp
    ./llvm.src/lib/Support/GlobPattern.cpp
    ./llvm.src/lib/Support/GraphWriter.cpp
    ./llvm.src/lib/Support/HexagonAttributeParser.cpp
    ./llvm.src/lib/Support/HexagonAttributes.cpp
    ./llvm.src/lib/Support/InitLLVM.cpp
    ./llvm.src/lib/Support/InstructionCost.cpp
    ./llvm.src/lib/Support/IntEqClasses.cpp
    ./llvm.src/lib/Support/IntervalMap.cpp
    ./llvm.src/lib/Support/JSON.cpp
    ./llvm.src/lib/Support/KnownBits.cpp
    ./llvm.src/lib/Support/LEB128.cpp
    ./llvm.src/lib/Support/LineIterator.cpp
    ./llvm.src/lib/Support/Locale.cpp
    ./llvm.src/lib/Support/LockFileManager.cpp
    ./llvm.src/lib/Support/ManagedStatic.cpp
    ./llvm.src/lib/Support/MathExtras.cpp
    ./llvm.src/lib/Support/MemAlloc.cpp
    ./llvm.src/lib/Support/MemoryBuffer.cpp
    ./llvm.src/lib/Support/MemoryBufferRef.cpp
    ./llvm.src/lib/Support/MD5.cpp
    ./llvm.src/lib/Support/MSP430Attributes.cpp
    ./llvm.src/lib/Support/MSP430AttributeParser.cpp
    ./llvm.src/lib/Support/NativeFormatting.cpp
    ./llvm.src/lib/Support/OptimizedStructLayout.cpp
    ./llvm.src/lib/Support/Optional.cpp
    ./llvm.src/lib/Support/PGOOptions.cpp
    ./llvm.src/lib/Support/Parallel.cpp
    ./llvm.src/lib/Support/PluginLoader.cpp
    ./llvm.src/lib/Support/PrettyStackTrace.cpp
    ./llvm.src/lib/Support/RandomNumberGenerator.cpp
    ./llvm.src/lib/Support/Regex.cpp
    ./llvm.src/lib/Support/RISCVAttributes.cpp
    ./llvm.src/lib/Support/RISCVAttributeParser.cpp
    ./llvm.src/lib/Support/RISCVISAUtils.cpp
    ./llvm.src/lib/Support/ScaledNumber.cpp
    ./llvm.src/lib/Support/ScopedPrinter.cpp
    ./llvm.src/lib/Support/SHA1.cpp
    ./llvm.src/lib/Support/SHA256.cpp
    ./llvm.src/lib/Support/Signposts.cpp
    ./llvm.src/lib/Support/SipHash.cpp
    ./llvm.src/lib/Support/SlowDynamicAPInt.cpp
    ./llvm.src/lib/Support/SmallPtrSet.cpp
    ./llvm.src/lib/Support/SmallVector.cpp
    ./llvm.src/lib/Support/SourceMgr.cpp
    ./llvm.src/lib/Support/SpecialCaseList.cpp
    ./llvm.src/lib/Support/Statistic.cpp
    ./llvm.src/lib/Support/StringExtras.cpp
    ./llvm.src/lib/Support/StringMap.cpp
    ./llvm.src/lib/Support/StringSaver.cpp
    ./llvm.src/lib/Support/StringRef.cpp
    ./llvm.src/lib/Support/SuffixTreeNode.cpp
    ./llvm.src/lib/Support/SuffixTree.cpp
    ./llvm.src/lib/Support/SystemUtils.cpp
    ./llvm.src/lib/Support/TarWriter.cpp
    ./llvm.src/lib/Support/ThreadPool.cpp
    ./llvm.src/lib/Support/TimeProfiler.cpp
    ./llvm.src/lib/Support/Timer.cpp
    ./llvm.src/lib/Support/ToolOutputFile.cpp
    ./llvm.src/lib/Support/Twine.cpp
    ./llvm.src/lib/Support/TypeSize.cpp
    ./llvm.src/lib/Support/Unicode.cpp
    ./llvm.src/lib/Support/UnicodeCaseFold.cpp
    ./llvm.src/lib/Support/UnicodeNameToCodepoint.cpp
    ./llvm.src/lib/Support/UnicodeNameToCodepointGenerated.cpp
    ./llvm.src/lib/Support/VersionTuple.cpp
    ./llvm.src/lib/Support/VirtualFileSystem.cpp
    ./llvm.src/lib/Support/WithColor.cpp
    ./llvm.src/lib/Support/YAMLParser.cpp
    ./llvm.src/lib/Support/YAMLTraits.cpp
    ./llvm.src/lib/Support/raw_os_ostream.cpp
    ./llvm.src/lib/Support/raw_ostream.cpp
    ./llvm.src/lib/Support/raw_socket_stream.cpp
    ./llvm.src/lib/Support/regcomp.c
    ./llvm.src/lib/Support/regerror.c
    ./llvm.src/lib/Support/regexec.c
    ./llvm.src/lib/Support/regfree.c
    ./llvm.src/lib/Support/regstrlcpy.c
    ./llvm.src/lib/Support/xxhash.cpp
    ./llvm.src/lib/Support/Z3Solver.cpp

    $<TARGET_OBJECTS:LLVMSupportBlake3>
    
    ./llvm.src/lib/Support/Atomic.cpp
    ./llvm.src/lib/Support/DynamicLibrary.cpp
    ./llvm.src/lib/Support/Errno.cpp
    ./llvm.src/lib/Support/Memory.cpp
    ./llvm.src/lib/Support/Path.cpp
    ./llvm.src/lib/Support/Process.cpp
    ./llvm.src/lib/Support/Program.cpp
    ./llvm.src/lib/Support/RWMutex.cpp
    ./llvm.src/lib/Support/Signals.cpp
    ./llvm.src/lib/Support/Threading.cpp
    ./llvm.src/lib/Support/Valgrind.cpp
    ./llvm.src/lib/Support/Watchdog.cpp
)
target_include_directories(LLVMSupport
    PUBLIC ./LLVM-Linux-X64/include
    PRIVATE ./llvm.src/lib/Support/Unix ./llvm.src/lib/Support/Windows ./LLVM-Linux-X64/include/llvm/ADT ./LLVM-Linux-X64/include/llvm/Support
)
target_compile_features(LLVMSupport PUBLIC cxx_std_20)

add_library(LLVMTargerParser)
target_sources(LLVMTargerParser PRIVATE
    ./llvm.src/lib/TargetParser/AArch64TargetParser.cpp
    ./llvm.src/lib/TargetParser/ARMTargetParserCommon.cpp
    ./llvm.src/lib/TargetParser/ARMTargetParser.cpp
    ./llvm.src/lib/TargetParser/CSKYTargetParser.cpp
    ./llvm.src/lib/TargetParser/Host.cpp
    ./llvm.src/lib/TargetParser/LoongArchTargetParser.cpp
    ./llvm.src/lib/TargetParser/RISCVISAInfo.cpp
    ./llvm.src/lib/TargetParser/RISCVTargetParser.cpp
    ./llvm.src/lib/TargetParser/SubtargetFeature.cpp
    ./llvm.src/lib/TargetParser/TargetParser.cpp
    ./llvm.src/lib/TargetParser/Triple.cpp
    ./llvm.src/lib/TargetParser/X86TargetParser.cpp
)
target_include_directories(LLVMTargerParser
    PUBLIC ./LLVM-Linux-X64/include
    PRIVATE ./llvm.src/lib/TargetParser/Unix ./llvm.src/lib/TargetParser/Windows
)
target_link_libraries(LLVMTargerParser PUBLIC LLVMSupport)
target_compile_features(LLVMTargerParser PUBLIC cxx_std_20)
