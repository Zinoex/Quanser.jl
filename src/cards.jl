# TODO: Read this info from some config file
# Be careful with mutable structs

@enum Cards begin
    Q4
    Q8
    Q2_Usb
    Q8_Usb
    QPIDe
end

card_type(::Val{Q4}) = "q4"
clocks(::Val{Q4}) = []
channels(::Val{Q4}) = []

card_type(::Val{Q8}) = "q8"
clocks(::Val{Q8}) = []
channels(::Val{Q8}) = []

card_type(::Val{Q2_Usb}) = "q2_usb"
clocks(::Val{Q2_Usb}) = []
channels(::Val{Q2_Usb}) = [[AnalogInput(i, 12, (-10, 10)) for i in 1..2],
                           [AnalogOutput(i, 12, (-10, 10)) for i in 1..2],
                           [EncoderInput(i, 10) for i in 1..2],
                           [DigitalInput(i) for i in 1..8],
                           [DigitalOutput(i) for i in 1..8],
                           [PWMOutput(i, 16, (0.40, 2.40), (2.4, 40)) for i in 1..2]]

card_type(::Val{Q8_Usb}) = "q8_usb"
clocks(::Val{Q8_Usb}) = []
channels(::Val{Q8_Usb}) = [[AnalogInput(i, 16, (-10, 10)) for i in 1..8],  # TODO: Figure out what channels are up to 5V and what are up to 10V
                           [AnalogOutput(i, 16, (-10, 10)) for i in 1..8],
                           [EncoderInput(i, 99) for i in 1..8],
                           [DigitalInput(i) for i in 1..8],
                           [DigitalOutput(i) for i in 1..8],
                           [PWMOutput(i, 16, (0.55, 4.50), (24, 49)) for i in 1..8]]

card_type(::Val{QPIDe}) = "qpid_e"
clocks(::Val{QPIDe}) = []
channels(::Val{QPIDe}) = [[AnalogInput(i, 16, (-10, 10)) for i in 1..8],
                        [AnalogOutput(i, 16, (-10, 10)) for i in 1..8],
                        [EncoderInput(i, 40) for i in 1..8],
                        [DigitalInputOutput(i) for i in 1..56],
                        [PWMOutput(i, 16, (0.40, 2.40), (9.6, 20)) for i in 1..8]]
