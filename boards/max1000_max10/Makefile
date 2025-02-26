DUT:=dut_icarus
SRC:=dut.v dut_tb.v
SRC+=sequencer.v
SRC+=spi_master.v
SRC+=lis3dh_stub.v
SRC+=_darksocv.v
SRC+=_darkio.v
SRC+=_darkram.v
SRC+=../../rtl/darkpll.v
SRC+=../../rtl/darkbridge.v
SRC+=../../rtl/darkriscv.v
SRC+=../../rtl/darkuart.v
IVOPT:=-DDUT_VCD=\"$(DUT).vcd\"
IVOPT+=-I..
IVOPT+=-DMAX1000_MAX10=1
IVOPT+=-DSIMULATION=1
ifdef SPI_LEDS
IVOPT+=-DSPI_LEDS=1
endif

all: $(DUT).vcd

output_files/max1000.sof:
	quartus_sh --flow compile max1000

synth: memory_init.mif output_files/max1000.sof

pgm: synth
	quartus_pgm -c Arrow-USB-Blaster max1000.cdf

memory_init.mem: ../../src/darksocv.mem
	cp -f $< $@

memory_init.bin: memory_init.mem
	./mem2bin.sh

memory_init.mif: memory_init.bin
	./bin2mif.sh

view: $(DUT).vcd
#	gtkwave $< &
	gtkwave $< $(DUT).gtkw &

.PRECIOUS:$(DUT).vcd
$(DUT).vcd: $(DUT).output
	vvp $<

$(DUT).output: memory_init.mem $(SRC)
	iverilog $(IVOPT) -o $@ $(SRC)

clean:
	rm -f memory_init.mem $(DUT).output $(DUT).vcd putty.log

clobber: clean
	rm -f memory_init.mif memory_init.bin
	rm -rf db incremental_db output_files
