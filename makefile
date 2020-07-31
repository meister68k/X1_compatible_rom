.PHONY : all clean cleanall

TARGET = IPLROM.x1
all : $(TARGET)

SRCS = X1_compatible_rom.z80
OBJS = $(SRCS:%.z80=%.bin)

AS     = pasmo
AOPT   = 


$(TARGET) : $(OBJS)
	cp $< $@

%.bin : %.z80
	$(AS) $(AOPT) $< $@ $(@:%.bin=%.lst)

clean :
	-rm $(OBJS) $(OBJS:%.bin=%.lst)

cleanall : clean
	-rm $(TARGET)
