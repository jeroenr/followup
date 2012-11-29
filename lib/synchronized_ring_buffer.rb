class SynchronizedRingBuffer < Array
  include MonitorMixin

  attr_accessor :max

  def initialize(max)
    super(max)
    @max = max
  end

  alias :old_shift :shift
  alias :old_unshift :unshift
  alias :old_push :push

  def shift(n=1)
    self.synchronize do
      self.old_shift(n)
    end
  end

  def unshift(item)
    self.synchronize do
      self.old_unshift(item)
    end
  end

  def push(obj)
    self.synchronize do
      shift unless self.length < @max
      self.old_push obj
    end
  end
  
  alias << push

end