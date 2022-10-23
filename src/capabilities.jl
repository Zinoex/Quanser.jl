# Clocks and channels
abstract type AbstractCapability end  
abstract type AbstractClock <: AbstractCapability end
abstract type AbstractChannel <: AbstractCapability end
abstract type AbstractWatchDog <: AbstractCapability end

@enum ChannelDirection Input Output Unconfigured

# Analog channels
abstract type AnalogChannel <: AbstractChannel end
resolution(channel::AnalogChannel) = channel.resolution
voltage_range(channel::AnalogChannel) = channel.voltage_range

struct AnalogInput <: AnalogChannel
    channel_num
    resolution::Int
    voltage_range::Tuple{Float32, Float32}
end
isinput(::AnalogInput) = true
isoutput(::AnalogInput) = false

struct AnalogOutput <: AnalogChannel
    channel_num
    resolution::Int
    voltage_range::Tuple{Float32, Float32}
end
isinput(::AnalogOutput) = false
isoutput(::AnalogOutput) = true

mutable struct AnalogInputOutput <: AnalogChannel
    channel_num
    resolution::Int
    voltage_range::Tuple{Float32, Float32}
    direction::ChannelDirection
end
AnalogInputOutput(channel_num, resolution, voltage_range) = AnalogInputOutput(channel_num, resolution, voltage_range, Unconfigured)
isinput(channel::AnalogInputOutput) = channel.direction == Input
isoutput(channel::AnalogInputOutput) = channel.direction == Output

# Digital channels
abstract type DigitalChannel <: AbstractChannel end

struct DigitalInput <: DigitalChannel
    channel_num
end
isinput(::DigitalInput) = true
isoutput(::DigitalInput) = false

struct DigitalOutput <: DigitalChannel
    channel_num
end
isinput(::DigitalOutput) = false
isoutput(::DigitalOutput) = true

mutable struct DigitalInputOutput <: DigitalChannel
    channel_num
    direction::ChannelDirection
end
DigitalInputOutput(channel_num) = DigitalInputOutput(channel_num, Unconfigured)
isinput(channel::DigitalInputOutput) = channel.direction == Input
isoutput(channel::DigitalInputOutput) = channel.direction == Output

# PWM channels
struct PWMOutput <: AnalogChannel  # Pseudo-analog
    channel_num
    resolution::Int
    voltage_range::Tuple{Float32, Float32}
    freq_range::Tuple{Float32, Float32}  # MHz
end
isinput(::PWMOutput) = false
isoutput(::PWMOutput) = true

# Encoder channels
struct EncoderInput <: AbstractChannel
    channel_num
    max_count_freq::Float32  # MHz
end
isinput(::EncoderInput) = true
isoutput(::EncoderInput) = false

# Clocks
struct SystemClock <: AbstractClock
    name::String
end

@enum HardwareClockMode Timebase PWM Encoder
mutable struct HardwardClock <: AbstractClock
    name::String
    mode::HardwareClockMode
end