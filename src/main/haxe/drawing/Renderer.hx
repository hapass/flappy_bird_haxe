package drawing;

import js.html.webgl.RenderingContext;
import drawing.shapes.Triangle;
import drawing.utils.Vec2;

class Renderer {

    private static inline var DEFAULT_PROGRAM:String = "default_program";
    private var compiler: ProgramCompiler;
    private var context: RenderingContext;

    public function new(context: RenderingContext) {
        this.context = context;
        this.compiler = new ProgramCompiler(context);

        compiler.compileProgram(DEFAULT_PROGRAM, "VertexShader", "FragmentShader");
    }

    public function drawTriangle(triangle: Triangle) {
        var program = compiler.getProgram(DEFAULT_PROGRAM);
        context.useProgram(program);

        //bind buffer for vertices
        var positionAttributeLocation = context.getAttribLocation(program, "vertex_position");
        var positionBuffer = context.createBuffer();
        context.bindBuffer(RenderingContext.ARRAY_BUFFER, positionBuffer);
        context.bufferData(RenderingContext.ARRAY_BUFFER, triangle.getVertices(), RenderingContext.STATIC_DRAW);
        context.enableVertexAttribArray(positionAttributeLocation);
        context.vertexAttribPointer(positionAttributeLocation, Vec2.DIMENSIONS_NUMBER, RenderingContext.FLOAT, false, 0, 0);
        
        //set screen size
        var resolutionUniformLocation = context.getUniformLocation(program, "screen_size");
        context.uniform2f(resolutionUniformLocation, context.canvas.width, context.canvas.height);

        //set color
        var colorUniformLocation = context.getUniformLocation(program, "color");
        var r = (triangle.color.r / 255);
        var g = (triangle.color.g / 255);
        var b = (triangle.color.b / 255);
        context.uniform3f(colorUniformLocation, r, g, b);

        //clear screen
        context.viewport(0, 0, context.canvas.width, context.canvas.height);                
        context.clearColor(0, 0, 0, 1);
        context.clear(RenderingContext.COLOR_BUFFER_BIT);

        context.drawArrays(RenderingContext.LINE_LOOP, 0, Triangle.VERTICES_NUMBER);
    }
}