package engine.input;

import js.Browser;
import js.html.KeyboardEvent;
import engine.input.Key;
import lang.Debug;

class Keyboard {
    private static inline var KEY_DOWN = "KEY_DOWN";
    private static inline var KEY_UP = "KEY_UP";
    private static inline var KEY_PRESSED = "KEY_PRESSED";

    private var trackedKeys: Array<Key>;

    public function new (trackedKeys: Array<Key>) {
        Browser.window.addEventListener("keydown", onKeyDown);
        Browser.window.addEventListener("keyup", onKeyUp);
        this.trackedKeys = new Array<Key>();
        for(key in trackedKeys) {
            Debug.assert(this.trackedKeys[key.code] == null, "Tracked keys cannot repeat in keyboard."); 
            key.setState(KEY_UP);      
            this.trackedKeys[key.code] = key;
        }
    }

    private function onKeyDown(event: KeyboardEvent) {
        var key = trackedKeys[event.keyCode];

        //key is not being tracked
        if(key == null)
            return;
        
        key.setState(KEY_DOWN);
    }

    private function onKeyUp(event: KeyboardEvent) {
        var key = trackedKeys[event.keyCode];

        //key is not being tracked
        if(key == null)
            return;
        
        key.setState(KEY_UP);
    }

    public function isKeyDown(key: Key) {
        return key.currentState == KEY_DOWN;
    }

    public function hasBeenPressed(key: Key) {
        var pressed = key.currentState == KEY_DOWN && key.previousState == KEY_UP;
        if(pressed)
            key.setState(KEY_PRESSED);
        return pressed;
    }
}