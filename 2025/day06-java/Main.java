/* I DO NOT LIKE JAVA!!! */

import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Scanner;
import java.util.stream.Collectors;

public class Day06 {
    public static List<List<Character>> readAllCharsForPart2(String filePath) throws IOException {
        try (var linesStream = Files.lines(Paths.get(filePath))) {
            return linesStream
                .map(line -> line.chars() // Convert each String line to an IntStream of character codepoints
                    .mapToObj(c -> (char) c) // Map each int codepoint to a Character object
                    .collect(Collectors.toList())) // Collect characters into a List<Character>
                .collect(Collectors.toList()); // Collect all lines into a List<List<Character>>
        }
    }

    public static void part1(List<List<Integer>> intIn, List<Character> symIn) {
        long result = 0;
        for (int i = 0; i < symIn.size(); ++i) {
            if('+' == symIn.get(i)) {
                long sum = 0;
                for(int j = 0; j < intIn.size(); ++j) {
                    sum += intIn.get(j).get(i);
                }
                result += sum;
            } else if ('*' == symIn.get(i)) {
                long product = 1;
                for(int j = 0; j < intIn.size(); ++j) {
                    product *= intIn.get(j).get(i);
                }
                result += product;
            }
        }
        System.out.println(result);
    }

    public static void part2(List<List<Character>> input, List<Character> symIn) {
        long result = 0;
        // transform the data
        String[] vals = new String[input.get(0).size()];
        Arrays.fill(vals, "");
        for(int i = 0; i < input.size(); ++i) {
            List<Character> line = input.get(i);
            for(int j = 0; j < line.size(); ++j) {
                if(Character.isDigit(line.get(j))) {
                    vals[j] += line.get(j);
                }
            }
        }
        
        int symIdx = 0;
        long sum = 0;
        long product = 1;
        for(String v : vals) {
            if(v.isEmpty()) {
                // update results
                if('+' == symIn.get(symIdx)) {
                    result += sum;
                    sum = 0;
                } else {
                    result += product;
                    product = 1;
                }
                symIdx += 1;
            } else {
                // do the operation
                if('+' == symIn.get(symIdx)) {
                    sum += Integer.parseInt(v);
                } else {
                    product *= Integer.parseInt(v);
                }
            }
        }
        // get the last value
        if('+' == symIn.get(symIdx)) {
            result += sum;
        } else {
            result += product;
        }
        System.out.println(result);
    }
    
    
    public static void main(String[] args) {
        String fileName = "./input.txt";
        List<List<Integer>> intInputs = new ArrayList<>();
        List<Character> symbols = new ArrayList<>();
        Integer lineCount = 0;

        try {
            Scanner scanner = new Scanner(new File(fileName));
            while (scanner.hasNextLine()) {
                String line = scanner.nextLine();
                if (line.trim().isEmpty()) {
                    continue;
                }
                
                Scanner lineScanner = new Scanner(line);
                if(lineCount < 4) {
                    List<Integer> currentLineInts = new ArrayList<>();
                    while (lineScanner.hasNextInt()) {
                        currentLineInts.add(lineScanner.nextInt());
                    }
                    intInputs.add(currentLineInts);
                } else {
                    while (lineScanner.hasNext()) {
                        String token = lineScanner.next();
                        if (token.length() == 1) {
                            symbols.add(token.charAt(0));
                        }
                    }
                }
                lineCount += 1;
                lineScanner.close();
            }
            scanner.close();

            part1(intInputs, symbols);
            List<List<Character>> inputs = readAllCharsForPart2(fileName);
            inputs.remove(inputs.size()-1);
            part2(inputs, symbols);

        } catch (Exception e) {
            System.err.println("File not found: " + fileName);
        }
    }
}