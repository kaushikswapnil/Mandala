class Pattern
{
   ArrayList<Node> m_Nodes;
   
   float m_InnerRadius, m_OuterRadius;
   float m_BorderSize;
   PVector m_BorderColor;
   
   PVector m_RegionColor;
   
   PVector m_Center;
   
   Pattern(Node nodePrototype, float innerR)
   {
       m_BorderSize = 5.0f;
       m_BorderColor = new PVector(255, 255, 255);
       m_RegionColor = new PVector(0, 0, 0);
       m_Center = new PVector(width/2, height/2);
       
       m_InnerRadius = innerR;
       m_OuterRadius = innerR + (2*m_BorderSize) + nodePrototype.GetRadialDimension();
       
       GenerateNodes(nodePrototype);
   }
   
   Pattern(Node nodePrototype, float innerR, PVector regionColor)
   {
       m_BorderSize = 5.0f;
       m_BorderColor = new PVector(255, 255, 255);
       m_RegionColor = regionColor;
       m_Center = new PVector(width/2, height/2);
       
       m_InnerRadius = innerR;
       m_OuterRadius = innerR + (2*m_BorderSize) + nodePrototype.GetRadialDimension();
       
       GenerateNodes(nodePrototype);
   }
   
   Pattern(Node nodePrototype, float innerR, PVector regionColor, PVector borderColor)
   {
       m_BorderSize = 5.0f;
       m_BorderColor = borderColor;
       m_RegionColor = regionColor;
       m_Center = new PVector(width/2, height/2);
       
       m_InnerRadius = innerR;
       m_OuterRadius = innerR + (2*m_BorderSize) + nodePrototype.GetRadialDimension();
       
       GenerateNodes(nodePrototype);
   }
   
   void Display()
   {          
      DrawRegion();
      DrawNodes();
      DrawBorders();
   }
   
   void DrawRegion()
   {
      noStroke();
      fill(m_RegionColor.x, m_RegionColor.y, m_RegionColor.z);
      float outerDiameter = 2*m_OuterRadius;
      ellipse(m_Center.x, m_Center.y, outerDiameter, outerDiameter);
   }
   
   void DrawNodes()
   {
      for (Node node : m_Nodes)
      {
         node.Display(); 
      }
   }
   
   void DrawBorders()
   {
      noFill();
      strokeWeight(m_BorderSize);
      stroke(m_BorderColor.x, m_BorderColor.y, m_BorderColor.z);
      float outerDiameter = 2*m_OuterRadius;
      float oBorderDiameter = outerDiameter - m_BorderSize;
      float iBorderDiameter = (2*m_InnerRadius) + m_BorderSize;
      ellipse(m_Center.x, m_Center.y, oBorderDiameter, oBorderDiameter);
      ellipse(m_Center.x, m_Center.y, iBorderDiameter, iBorderDiameter);
   }
   
   void GenerateNodes(Node nodePrototype)
   {
      m_Nodes = new ArrayList<Node>();
      
      float outerRadiusPerimiter = 2 * PI * (m_OuterRadius - m_BorderSize);
      int numShapes = (int)Math.floor(outerRadiusPerimiter/nodePrototype.GetFlatDimension());
      
      float shapeCenterCircleRadius = (m_InnerRadius + m_OuterRadius)/2;
      for (int shapeIter = 0; shapeIter < numShapes; ++shapeIter)
      {
         Node node = nodePrototype.Copy();
         float theta = (TWO_PI * shapeIter / numShapes);
         PVector positionVector = new PVector(sin(theta), cos(theta));
         PVector position = PVector.add(g_Center, PVector.mult(positionVector, shapeCenterCircleRadius));
         node.m_Position = position;
         node.m_Angle = (PVector.sub(position, g_Center)).heading();
         
         m_Nodes.add(node);
      }
   }
   
   
}
