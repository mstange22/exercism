const COLORS = [
  'black', 'brown', 'red', 'orange', 'yellow',
  'green', 'blue', 'violet', 'grey', 'white'
];

export class ResistorColor {
  private colors: string[];

  constructor(colors: string[]) {
    if (colors.length < 2) {
      throw new Error("At least two colors need to be present");
    }
    this.colors = colors;
  }
  value = (): number => Number(COLORS.indexOf(this.colors[0]).toString() + COLORS.indexOf(this.colors[1].toString()));
}
