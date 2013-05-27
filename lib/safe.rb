class SafeState
  attr_accessor :display
  attr_accessor :input
  attr_reader :lock
  attr_reader :door

  def initialize(display_text: "", lock: :locked, door: :closed)
    @input = {}
    @input[:pin] = "PIN"
    @input[:key] = "KEY"
    @input[:lock] = "LOCK"

    @pin_length = 6

    self.lock = lock
    self.door = door
    @display = display_text
  end

  def lock=(lock_state)
    if not [:locked, :unlocked].include?(lock_state)
      raise "Bad lock state #{lock_state}"
    elsif lock_state == :lock and @door == :open then
      raise "Bad lock state #{lock_state} while door is #{@door}"
    end
    @lock = lock_state
    if @lock == :unlocked then
      @display = "OPEN"
    else
      @display = "CLOSED"
    end
  end

  def door=(door_state)
    if not [:opened, :closed].include?(door_state)
      raise "Bad door state #{door_state}"
    elsif door_state == :opened and @lock == :locked then
      raise "Bad door state #{door_state} while lock is #{@lock}"
    end
    @door = door_state
  end

  def transition(input)
    case input
    when @input[:pin]
      SafeStateNewPin.new
    when @input[:key]
      SafeStateUnlocking.new
    when @input[:lock]
      if @door == :closed
        self.lock = :locked
        self
      else
        SafeStateError.new
      end
    else
      SafeStateError.new
    end
  end
end

class SafeStateError < SafeState
  def initialize(display_text: "ERROR")
    super(display_text: display_text)
  end
end

class SafeStateNewPin < SafeState
  def initialize()
    super()
    @value = ""
  end

  def transition(input)
    case input
    when @input[:pin]
      if @value.length == @pin_length
        SafeState.new ""
      else
        SafeStateError.new
      end
    when 0..9
      @value << input
      self
    else
      SafeStateError.new
    end
  end
end

class SafeStateUnlocking < SafeState
  def initialize()
    super()
    @value = ""
  end

  def transition(input)
    case input
    when 0..9
      @value << input
      @display = input

      if @value.length == @pin_length
        SafeState.new display_text: "OPEN", lock: :unlocked
      else
        self
      end
    else
      SafeStateError.new
    end
  end
end

class Safe
  attr_accessor :pin

  def initialize(lock: :locked)
    @pin = "123456"
    @state = SafeState.new lock: lock
  end

  def lock()
    @state.lock = :locked
  end

  def unlock()
    @state.lock = :unlocked
  end

  def is_locked?()
    @state.lock == :locked
  end

  def close_door()
    @state.door = :closed
  end

  def open_door()
    @state.door = :opened
  end

  def is_door_open?()
    @state.door == :opened
  end

  def display
    @state.display
  end

  def press(button)
    @state = @state.transition button
  end
end

