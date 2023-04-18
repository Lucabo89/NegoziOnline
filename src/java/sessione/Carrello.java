
package sessione;

import javax.servlet.http.*;
import java.util.Vector;
import blogics.*;

public class Carrello implements java.io.Serializable{
    
    Vector<Item> listaSpesa = new Vector();
    
    String item = null;

    public void addItem(Item i) {
        listaSpesa.add(i);
    }
    
//    ritorna un CLONE del carrello!!
    public Item[] getItems() {
	Item[] lista = new Item[listaSpesa.size()];
	listaSpesa.copyInto(lista);
        return lista;
    }
    
    public void deleteItem(int i){
        listaSpesa.removeElementAt(i);
    }
    
    public void svuotaCarrello(){
        listaSpesa.clear();
        System.out.println("carrello svuotato!!");
    }
    
    public void reset(){

	listaSpesa = null;
    }
    
//	// null value for submit - user hit enter instead of clicking on  "add" or "remove"
//    public void processRequest(HttpServletRequest request){
//        if (submit == null)
////            addItem(Item);
//
//	if (submit.equals("add"))
////	    addItem(dettaglio);
//        
////        if (submit.equals("remove")) 
////	    removeItem(dettaglio);
//	
//	// reset at the end of the request
//	reset();
//    }

    // reset
}