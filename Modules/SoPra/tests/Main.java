import java.io.IOException;

public class Main{

    public static void main(String[] args){
        CsvReader reader = new CsvReader();
        CsvWriter writer = new CsvWriter();
        try{
            CsvObj csvO = reader.load("test.csv", ',');
            writer.write(csvO, "out.csv");
        }catch(IOException e){
        }
    }
}
