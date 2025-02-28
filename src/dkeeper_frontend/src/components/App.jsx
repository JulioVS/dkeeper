import React, { useState, useEffect } from "react";
import Header from "./Header";
import Footer from "./Footer";
import Note from "./Note";
import CreateArea from "./CreateArea";

// Connect to Backend (i.e. Motoko code)
import { dkeeper_backend } from "declarations/dkeeper_backend";

function App() {
  const [notes, setNotes] = useState([]);

  // Get existing Notes from Backend
  useEffect(() => {
    console.log("useEffect triggered");

    async function getServerNotes() {
      var result = await dkeeper_backend.readNotes();
      setNotes(result);
    }

    getServerNotes();
  }, []); // '[]' argument prevents infinite rendering loop

  function addNote(newNote) {
    setNotes((prevNotes) => {
      // Send new Note to Backend (then update State)
      dkeeper_backend.createNote(newNote.title, newNote.content);
      return [newNote, ...prevNotes];
    });
  }

  function deleteNote(id) {
    setNotes((prevNotes) => {
      // Remove target Note from Backend (then update State)
      dkeeper_backend.removeNote(id);
      return prevNotes.filter((noteItem, index) => {
        return index !== id;
      });
    });
  }

  return (
    <div>
      <Header />
      <CreateArea onAdd={addNote} />
      {notes.map((noteItem, index) => {
        return (
          <Note
            key={index}
            id={index}
            title={noteItem.title}
            content={noteItem.content}
            onDelete={deleteNote}
          />
        );
      })}
      <Footer />
    </div>
  );
}

export default App;
