package engine.graphics.drawing.shapes;

import engine.math.Vec2;
import engine.graphics.drawing.Color;

class Rectangle { 
    public var color(default, null): Color;

    private var ver1: Vec2;
    private var ver2: Vec2;
    private var ver3: Vec2;
    private var ver4: Vec2;

    public function new(coords: Vec2, width: Float, height: Float, color: Color) {
        this.color = color;
        this.ver1 = coords.add(new Vec2(0, height));        
        this.ver2 = coords;
        this.ver3 = coords.add(new Vec2(width, height));
        this.ver4 = coords.add(new Vec2(width, 0));
    }

    public function move(vec: Vec2) {
        this.ver1 = this.ver1.add(vec);
        this.ver2 = this.ver2.add(vec);
        this.ver3 = this.ver3.add(vec);
        this.ver4 = this.ver4.add(vec);
    }

    public function getVertices(): Array<Vec2> {
        return [
            this.ver1,
            this.ver2,
            this.ver3,
            this.ver4
        ];
    }
}