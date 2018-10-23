import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;

class CsvWriter{
    private BufferedWriter buffWriter;

    public CsvWriter(){
        //
    }

    public void write(CsvObj csvO, String file) throws IOException{
        setFile(file);
        this.buffWriter.write(csvO.toString());
        this.buffWriter.flush();
        this.buffWriter.close();
    }

    private void setFile(String path) throws IOException{
        this.buffWriter = new BufferedWriter(new FileWriter(new File(path)));
    }
}
