class PShapeContainerNode extends Shape
{
  PShape m_PShape;
  
  PShapeContainerNode(PShape shape)
  {
    super(shape.width, shape.height);
    m_PShape = shape;
  }
}
