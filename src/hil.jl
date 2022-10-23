
struct HILVersion
    major::UInt16
    minor::UInt16
    release::UInt16
    build::UInt16
end

function hil_version()
    # TODO: Fetch via ccall
    return HILVersion(0, 0, 0, 0)
end


mutable struct HILBoard{C <: AbstractVector{<:AbstractClock}, H <: AbstractVector{<:AbstractChannel}}
    handle::Ptr{Cvoid}
    card_type::String
    identifier::String

    # Capabilities
    clocks::C
    channels::H

    # Status
    open::Bool = false

    function HILBoard(card_type, identifier, clocks, channels)
        # TODO: Open via ccall
        board = new(C_NULL, card_type, identifier, clocks, channels, true)

        # Using the finalizer, the GC will automatically close the connection
        finalizer(unsafe_close!, board)
        
        return board
    end
end

HILBoard(card::Card, identifier) = HILBoard(card_type(card), identifier, clocks(card), channels(card))

function unsafe_close!(board::HILBoard)
    # TODO: Close via ccall
end

isopen(board::HILBoard) = board.open


function read(board::HILBoard, channels::H) where {H <: AbstractVector{<:AbstractChannel}}
    @assert all(isinput, channels)

    # TODO: Read via ccall
end

function write(board::HILBoard, channels::H, data::VD) where {H <: AbstractVector{<:AbstractChannel}, VD <: AbstractVector{<:Real}}
    @assert all(isoutput, channels)

end