#
# Copyright (c) 2025, Nicolas Sauzede <nicolas.sauzedegmail.com>
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:
#
# * Redistributions of source code must retain the above copyright notice, this
#   list of conditions and the following disclaimer.
#
# * Redistributions in binary form must reproduce the above copyright notice,
#   this list of conditions and the following disclaimer in the documentation
#   and/or other materials provided with the distribution.
#
# * Neither the name of the copyright holder nor the names of its
#   contributors may be used to endorse or promote products derived from
#   this software without specific prior written permission.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
# AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
# DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
# FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
# DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
# SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
# CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
# OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
# OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#
# ===8<--------------------------------------------------------- cut here!

BOARD:=max1000_max10

BRD:=../boards/$(BOARD)
RTL:=../rtl
SRC:=../src

RTLS:=
RTLS+=$(BRD)/_darksocv.v
RTLS+=$(BRD)/_darkio.v
RTLS+=$(BRD)/_darkram.v
RTLS+=$(BRD)/sequencer.v
RTLS+=$(BRD)/spi_master.v
RTLS+=$(RTL)/darkpll.v
RTLS+=$(RTL)/darkbridge.v
RTLS+=$(RTL)/darkriscv.v
RTLS+=$(RTL)/darkuart.v

BOOT:=$(BRD)/memory_init.mif

BIT:=$(BRD)/output_files/max1000.sof

default: all

$(BIT): $(RTLS) $(BOOT)
	(cd $(BRD) ; quartus_sh --flow compile max1000)

$(BRD)/memory_init.mem: $(SRC)/darksocv.mem
	cp $< $@

$(BRD)/memory_init.bin: $(BRD)/memory_init.mem
	(cd $(BRD) ; ./mem2bin.sh)

$(BOOT): $(BRD)/memory_init.bin
	(cd $(BRD) ; ./bin2mif.sh)

all: $(BIT)

install: $(BIT)
	(cd $(BRD) ; quartus_pgm -c Arrow-USB-Blaster max1000.cdf)

clean:
	rm -f $(BRD)/memory_init.mif $(BRD)/memory_init.mem $(BRD)/memory_init.bin
	rm -rf $(BRD)/db $(BRD)/incremental_db $(BRD)/output_files
