import Text "mo:base/Text";
import List "mo:base/List";
import Debug "mo:base/Debug";

actor DKeeper {
  // Custom Note object
  public type Note = {
    title : Text;
    content : Text;
  };

  var notes : List.List<Note> = List.nil<Note>();

  // Create new Note on Backend
  public func createNote(t : Text, c : Text) {
    let newNote : Note = {
      title = t;
      content = c;
    };

    notes := List.push(newNote, notes);
    Debug.print(debug_show(notes));
  };

  // Default dfx Greet function
  public query func greet(name : Text) : async Text {
    return "Hello, " # name # "!";
  };
};
