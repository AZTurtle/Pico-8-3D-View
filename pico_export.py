import bpy
import os

bl_info = {
    "name": "Pico-8 Geometry",
    "category": "Import-Export",
}

class PicoGeometry(bpy.types.Operator):
    """Pico-8 Geometry"""
    bl_label = "Pico-8 Export"
    bl_idname = "object.export_pico_geometry"
    
    def execute(self, context):
        geometry = ""
        export_object = context.selected_objects[0].data
        vertices = export_object.vertices
        geometry += export_object.name + "=" + "{"
        for edge in export_object.edges:
            geometry += "{"
            edge_vertex = 0
            if edge.index > 0:
                edge_vertex = vertices[export_object.edges[edge.index - 1].vertices[1]]
                geometry += "{" + str(edge_vertex.co[0]) + "," + str(edge_vertex.co[1]) + "," + str(edge_vertex.co[2]) + "}"
            else:
                edge_vertex = vertices[export_object.edges[len(export_object.edges) - 1].vertices[1]]
                geometry += "{" + str(edge_vertex.co[0]) + "," + str(edge_vertex.co[1]) + "," + str(edge_vertex.co[2]) + "}"
            for vertex in edge.vertices:
                geometry += "{" + str(vertices[vertex].co[0]) + "," + str(vertices[vertex].co[1]) + "," + str(vertices[vertex].co[2]) + "}"
            if edge.index < len(export_object.edges) - 1:
                geometry += "},\n"
            else:
                geometry += "}"
        geometry += "}"
        
        bpy.data.texts.new("Pico Export").write(geometry)
        return {"FINISHED"}
    
class PicoExport(bpy.types.Panel):
    bl_label = "Pico-8 Export"
    bl_context = "object"
    bl_space_type = "PROPERTIES"
    bl_idname = "OBJECT_PT_pico_export"
    bl_region_type = "WINDOW"
    
    def draw(self, context):
        pico_export_button = self.layout.row()
        pico_export_button.label(text="Pico-8 Export")
        pico_export_button.operator("object.export_pico_geometry")
    

if __name__ == "__main__":
    bpy.utils.register_class(PicoGeometry)
    bpy.utils.register_class(PicoExport)