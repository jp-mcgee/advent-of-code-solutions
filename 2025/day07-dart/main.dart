import 'dart:collection';
import 'dart:io';

void part1(int start, List<String> inputs) {
    int result = 0;
    Set<int> beams = {start};
    for (var line in inputs) {
        for (int i = 0; i < line.length; ++i) {
            if('^' == line[i] && beams.contains(i)) {
                beams.remove(i);
                beams.add(i-1);
                beams.add(i+1);
                ++result;
            }
        }
    }
    print(result);
}

void part2(int start, List<String> inputs) {
    List<int> paths = List<int>.filled(inputs[0].length, 0, growable: false);
    paths[start] = 1;
    for (var line in inputs) {
        for (int i = 0; i < line.length; ++i) {
            if('^' == line[i] && paths[i] > 0) {
                paths[i-1] += paths[i];                
                paths[i+1] += paths[i];
                paths[i] = 0;
            }
        }
    }
    print(paths.reduce((accum, x) => accum + x));
}

void main() async {
    final file = File("./input.txt");
    List<String> lines = await file.readAsLines();
    for(int i = lines.length-1; i >= 0; --i) {
        if(i % 2 != 0) {
            lines.removeAt(i);
        }
    }
    int startIdx = lines[0].indexOf('S');
    lines.removeAt(0);
    part1(startIdx, lines);
    part2(startIdx, lines);
}