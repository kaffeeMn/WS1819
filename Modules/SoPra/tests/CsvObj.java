import java.lang.Iterable;

import java.util.Iterator;
import java.util.HashMap;
import java.util.ArrayList;
import java.util.Set;

public class CsvObj<E> implements Iterable<ArrayList<String>>{
    /**
     * Iterator for the Hashmap of columns
     */
    private class CsvIter implements Iterator<ArrayList<String>>{
        // line position
        private int line;
        // headers
        private Set<String> keys;
        // hashmap of columns
        private final HashMap<String, ArrayList<E>> DICT;

        public CsvIter(HashMap<String, ArrayList<E>> dict){
            this.DICT = dict;
            this.keys = this.DICT.keySet();
        }

        public boolean hasNext(){
            // at least one column has to be not empty
            for(String key : this.keys){
                if(this.line < this.DICT.get(key).size())
                    return true;
            }
            return false;
        }

        public ArrayList<String> next(){
            // list of Strings at this.line
            ArrayList<String> list = new ArrayList<String>();
            // column
            ArrayList<E> column;

            if(this.line > 0){
                for(String k : this.keys){
                    column = this.DICT.get(k);
                    if(column.size() > this.line){
                        if(column.get(this.line) != null)
                            list.add(column.get(this.line).toString());
                        else
                            list.add(null);
                    }else{
                        list.add("");
                    }
                }
            }else{
                for(String k : this.keys){
                    list.add(k);
                }
            }
            ++this.line;
            return list;
        }

        public void remove(){
            throw new UnsupportedOperationException();
        }
    }
    private final char DELIMETER;
    // hashmap of columns
    private HashMap<String, ArrayList<E>> dict;


    public CsvObj(String[] headers, char delimeter){
        this.dict = new HashMap<String, ArrayList<E>>();
        this.DELIMETER = delimeter;
        for(String header : headers)
            this.dict.put(header, new ArrayList<E>());
    }

    public void add(String[] keys, E[] vals){
        if(vals.length > keys.length)
            throw new IllegalArgumentException(
                "more values than keys in CsvObj.add(keys, vals)"
            );
        int len = vals.length;
        for(int i=0; i<keys.length; ++i){
            if(len > i){
                this.dict.get(keys[i]).add(vals[i]);
            }else{
                this.dict.get(keys[i]).add(null);
            }
        }
    }

    public E get(String header, int line){
        return this.dict.get(header).get(line);
    }

    public ArrayList<E> getLine(int line){
        ArrayList<E> list = new ArrayList<E>();

        for(String key : this.dict.keySet())
            list.add(this.dict.get(key).get(line));
        return list;
    }

    public ArrayList<E> getColumn(String header){
        return this.dict.get(header);
    }

    public CsvIter iterator(){
        return new CsvIter(this.dict);
    }

    /**
     * A string representation of the csv-objekt
     */
    public String toString(){
        String str = "";
        CsvIter it = iterator();
        String tmp = "";

        for(ArrayList<String> line : this){
            for(int i=0; i<line.size(); ++i){
                if(line.get(i) == null)
                    line.set(i, "");
            }
            str += String.join(Character.toString(this.DELIMETER), line);
            str += "\n";
        }
        return str;
    }
}
