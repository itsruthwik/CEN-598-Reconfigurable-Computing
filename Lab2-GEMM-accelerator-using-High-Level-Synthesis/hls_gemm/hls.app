<project xmlns="com.autoesl.autopilot.project" top="matrix_mult" name="hls_gemm" projectType="C/C++">
    <includePaths/>
    <libraryPaths/>
    <Simulation>
        <SimFlow name="csim" csimMode="0" lastCsimMode="0"/>
    </Simulation>
    <files xmlns="">
        <file name="matrix_mult.cpp" sc="0" tb="false" cflags="" csimflags="" blackbox="false"/>
        <file name="matrix_mult.h" sc="0" tb="false" cflags="" csimflags="" blackbox="false"/>
        <file name="../../matrix_mult_tb.cpp" sc="0" tb="1" cflags="-Wno-unknown-pragmas" csimflags="" blackbox="false"/>
    </files>
    <solutions xmlns="">
        <solution name="solution1" status="active"/>
    </solutions>
</project>
