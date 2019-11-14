class SunNode extends EllipseNode
{
   SunNode(float radius)
   {
      super(radius, new PVector(255, 103, 0), new PVector(255, 103, 0));
      m_Fill = true;
      m_Stroke = true;
   }
   
   Shape Copy()
   {
      return new SunNode(m_Width/2); 
   }
}
