const MINUTES_IN_DAY = (60 * 24)

class Clock {
  minutes: number
  constructor(hours: number, minutes: number = 0) {
    this.minutes = ((((hours * 60) + minutes) % MINUTES_IN_DAY) + MINUTES_IN_DAY) % MINUTES_IN_DAY
  }

  plus = (minutes: number) => new Clock(0, this.minutes + minutes)

  minus = (minutes: number) => this.plus(-minutes)

  equals = (c: Clock) => this.minutes === c.minutes

  toString = () => {
    const hours = (Math.floor(this.minutes / 60) % 24).toString()
    const minutes = (this.minutes % 60).toString()
    return `${hours.padStart(2, '0')}:${minutes.padStart(2, '0')}`
  }
}

export default Clock
