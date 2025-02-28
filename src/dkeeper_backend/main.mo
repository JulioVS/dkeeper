import Text "mo:base/Text";
import List "mo:base/List";
import Debug "mo:base/Debug";

actor DKeeper {
  // Custom Note object
  public type Note = {
    title : Text;
    content : Text;
  };

  // All the Notes are *persisted* in the app just by adding
  // the *stable* keyword to the variable declaration!!!
  stable var notes : List.List<Note> = List.nil<Note>();

  // Create new Note on Backend
  public func createNote(t : Text, c : Text) {
    let newNote : Note = {
      title = t;
      content = c;
    };

    notes := List.push(newNote, notes);
    Debug.print(debug_show (notes));
  };

  // Return all existing Notes
  public query func readNotes() : async [Note] {
    return List.toArray(notes);
  };

  // Delete a Note from Backend
  public func removeNote(id : Nat) {
    // Remove an existing Note by first getting the previous ones,
    // then the following ones and the stitching those two sections
    // of the List together, thus excluding just the target item
    // whose id we got as a parameter.-
    let previous = List.take(notes, id);
    let following = List.drop(notes, id + 1);

    notes := List.append(previous, following);
    Debug.print(debug_show (notes));
  };
};
