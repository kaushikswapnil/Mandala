class PShapeContainerNode extends SimpleShape
{
  PShape m_PShape;
  
  PShapeContainerNode()
  {
     super(0, 0, false, false);
     m_PShape = null;
  }
  
  PShapeContainerNode(PShape shape)
  {
    super(shape.width, shape.height, true, true);
    m_PShape = shape;
  }
  
  void CalculatePShape()
  {
    
  }
  
  void Display()
  {
    super.Display();
    shape(m_PShape, m_Position.x, m_Position.y, m_Width, m_Height);
  }
  
  Shape Copy()
  {
     return new PShapeContainerNode(m_PShape); 
  }
}

class PShapeTriangle extends PShapeContainerNode
{
  
}
