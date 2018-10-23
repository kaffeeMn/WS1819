
import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;

import java.util.HashMap;
import java.util.ArrayList;


public class CsvReader{
    private BufferedReader buffReader;

    public CsvReader(){
        //
    }

    public CsvObj read(ArrayList<String[]> lines, char delimeter){
        if(lines.size() < 1)
            // empty file
            return null;

        String[] headers = lines.get(0);
        CsvObj csvO = new CsvObj(headers, delimeter);
        // adding lines to the object
        if(lines.size() > 2){
            for(int i=1; i<lines.size(); ++i)
                csvO.add(headers, lines.get(i));
        }
        return csvO;
    }

    public CsvObj load(String path, char delimeter) throws IOException{
        // setting this.buffReader
        setFile(path);
        // list of lines
        ArrayList<String[]> lines = new ArrayList<String[]>();
        String line;

        while((line = this.buffReader.readLine()) != null)
            lines.add(line.split(Character.toString(delimeter)));
        // parsing lines into an CsvObj
        return read(lines, delimeter);
    }

    private void setFile(String path) throws IOException{
        this.buffReader = new BufferedReader(new FileReader(new File(path)));
    }
}
