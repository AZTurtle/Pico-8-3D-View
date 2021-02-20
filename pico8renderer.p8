mousex=0
mousey=0
function _init()
 --ignore
	poke(0x5f2d,1)
end

function _update()
	mousex=stat(32)
	mousey=stat(33)
	cube.origin={mousex-64,mousey-64,-0.4}
end

function _draw()
 cls()
 render()
end

function viewpixel(face,origin,scale)
	viewrectangle({(((face[1][1]*scale[1])+origin[1])/((face[1][3]*scale[3])+origin[3]))+64,(((face[1][2]*scale[2])+origin[2])/((face[1][3]*scale[3])+origin[3]))+64},{(((face[2][1]*scale[1])+origin[1])/((face[2][3]*scale[3])+origin[3]))+64,(((face[2][2]*scale[2])+origin[2])/((face[2][3]*scale[3])+origin[3]))+64},{(((face[3][1]*scale[1])+origin[1])/((face[3][3]*scale[3])+origin[3]))+64,(((face[3][2]*scale[2])+origin[2])/((face[3][3]*scale[3])+origin[3])+64)},face[4])
end

function viewrectangle(topcorner,leftcorner,bottomcorner,col)
	if leftcorner[2]>bottomcorner[2] then
		flat=leftcorner
		leftcorner=bottomcorner
		bottomcorner=flat
	end
	if topcorner[2]>leftcorner[2] then
		reverse=topcorner
		topcorner=leftcorner
		leftcorner=reverse
	end
	for left=1,leftcorner[2]-topcorner[2] do
		line(topcorner[1]-(left/((leftcorner[2]-topcorner[2])/(topcorner[1]-leftcorner[1]))),topcorner[2]+left,topcorner[1]-(left/((bottomcorner[2]-topcorner[2])/(topcorner[1]-bottomcorner[1]))),topcorner[2]+left,col)
	end
	for left=1,bottomcorner[2]-leftcorner[2] do
		line(bottomcorner[1]+(left/((bottomcorner[2]-leftcorner[2])/(leftcorner[1]-bottomcorner[1]))),bottomcorner[2]-left,bottomcorner[1]+(left/((bottomcorner[2]-topcorner[2])/(topcorner[1]-bottomcorner[1]))),bottomcorner[2]-left,col)
	end
	line(topcorner[1],topcorner[2],bottomcorner[1],bottomcorner[2],col)
	line(topcorner[1],topcorner[2],leftcorner[1],leftcorner[2],col)
	line(leftcorner[1],leftcorner[2],bottomcorner[1],bottomcorner[2],col)
end

tris={geometry={},origin={},scale={}}

function tris:new(geometry,origin,scale)
 self={}
 self.geometry=geometry
 self.scale=scale
 self.origin=origin
 function self:render()
  for quad in all(self.geometry) do
		 viewpixel(quad,self.origin,self.scale)
	 end
 end
 return self
end

texture={size={},sheet={}}

function texture:new(size,sheet)
	
end

--temporary geometry
--[[
joystick={}
joystick[1]={{10,0,1.06},{20,10,1.06},{10,10,1},8}
joystick[2]={{10,0,1.06},{0,10,1.06},{10,10,1},2}
joystick[3]={{20,10,1.06},{10,10,1},{10,20,1.06},2}
joystick[4]={{0,10,1.06},{10,10,1},{10,20,1.06},1}
joystick[5]={{6,16,1.06},{10,16,1.02},{10,32,1.06},5}
joystick[6]={{14,16,1.06},{10,16,1.02},{10,32,1.06},6}
button={}
button[8]={{0,0,1.06},{-5,0,1},{5,0,1},7}
button[7]={{-5,0,1},{5,0,1},{0,0,0.94},7}
button[6]={{-5,0,1},{0,0,0.94},{0,2,0.94},13}
button[5]={{-5,0,1},{-5,2,1},{0,2,0.94},13}
button[4]={{5,0,1},{0,0,0.94},{0,2,0.94},6}
button[3]={{5,0,1},{5,2,1},{0,2,0.94},6}
button[2]={{0,2,1.06},{-5,2,1},{5,2,1},13}
button[1]={{-5,2,1},{5,2,1},{0,2,0.94},13}
game={}
game[6]={{-48,40,1},{-48,40,0.86},{48,40,0.86},13}
game[5]={{-48,40,1},{48,40,1},{48,40,0.86},13}
game[4]={{-48,-40,1},{-48,40,0.86},{-48,40,1},6}
game[3]={{48,-40,1},{48,40,0.86},{48,40,1},1}
game[2]={{-48,-40,1},{-48,40,1},{48,40,1},5}
game[1]={{-48,-40,1},{48,-40,1},{48,40,1},5}
tri={}
tri[1]={{5,0,1},{0,20,1},{10,20,1},6}
]]--
cube={}
cube[11]={{-5,-5,1},{5,-5,1},{-5,5,1},7}
cube[12]={{5,-5,1},{5,5,1},{-5,5,1},7}
cube[10]={{-5,-5,1},{-5,-5,1.08},{-5,5,1},5}
cube[9]={{-5,-5,1.08},{-5,5,1.08},{-5,5,1},5}
cube[8]={{5,-5,1},{5,-5,1.08},{5,5,1},5}
cube[7]={{5,-5,1.08},{5,5,1.08},{5,5,1},5}
cube[6]={{-5,5,1},{-5,5,1.08},{5,5,1},5}
cube[5]={{-5,5,1.08},{5,5,1.08},{5,5,1},5}
cube[4]={{-5,-5,1},{-5,-5,1.08},{5,-5,1},5}
cube[3]={{-5,-5,1.08},{5,-5,1.08},{5,-5,1},5}
cube[2]={{-5,-5,1.08},{5,-5,1.08},{-5,5,1.08},6}
cube[1]={{5,-5,1.08},{5,5,1.08},{-5,5,1.08},6}

--rendering
--joystick=tris:new(joystick,{-36,20,0},{0.4,0.4,0.64})
--game=tris:new(game,{0,0,-0.1},{1,1,1})
cube=tris:new(cube,{0,0,0},{1,1,1})
scene={cube}

function render()
 for geometry in all(scene) do
  geometry:render()
 end
end
