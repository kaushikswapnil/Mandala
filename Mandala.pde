ArrayList<Pattern> g_Mandala;

PVector g_Center;
void setup()
{
  size(800, 800);
  
  g_Center = new PVector(width/2, height/2);
  Shape node = new EllipseNode(20, new PVector(30, 50, 70), new PVector(70, 90, 110));
  Pattern p = new Pattern(node, 40);
  
  g_Mandala = new ArrayList<Pattern>();
  g_Mandala.add(p);
  
  ArrayList<IEffect> effects = new ArrayList<IEffect>();
  effects.add(new RotateEffect(TWO_PI*2, 800));
  //effects.add(new ScaleEffect(1.5, 800));
  
  Shape sqNode = new SquareNode(50, 50, true, new PVector(110, 130, 150), true, new PVector(150, 180, 210), new ArrayList<IEffect>());
  Pattern p1 = new Pattern(sqNode, p.m_OuterRadius, new PVector(0, 0, 80), new PVector(250, 255, 255));
  g_Mandala.add(p1);
  
  Shape trNode = new TriangleNode(30, true, new PVector(110, 130, 150), true, new PVector(150, 180, 210), new ArrayList<IEffect>());
  Pattern p3 = new Pattern(trNode, p1.m_OuterRadius, new PVector(0, 0, 80), new PVector(250, 255, 255), effects);
  g_Mandala.add(p3);
}

void draw()
{
  background(0);
  
  for(int pIter = g_Mandala.size() - 1; pIter >= 0; --pIter)
  {
     Pattern p = g_Mandala.get(pIter);
     p.Update();
     p.Display(); 
  }
}
