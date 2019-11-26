class PShapeContainerNode extends SimpleShape
{
  PShape m_Shape;
  
  PShapeContainerNode()
  {
     super(0, 0, true, true);
     m_Shape = null;
  }
  
  PShapeContainerNode(PShape shape)
  {
    super(shape.width, shape.height, true, true);
    m_Shape = shape;
  }
  
  void CreateShape()
  {
    
  }
  
  void Display()
  {
    pushMatrix();
    
    translate(m_Position.x, m_Position.y);
    rotate(m_Angle);
    shape(m_Shape, 0, 0);
    
    popMatrix();
  }
  
  Shape Copy()
  {
     return new PShapeContainerNode(m_Shape); 
  }
}
