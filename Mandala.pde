ArrayList<Pattern> g_Mandala;

PVector g_Center;
void setup()
{
  size(800, 800);
  
  g_Center = new PVector(width/2, height/2);

  GenerateMandala();
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

void GenerateMandala()
{
  g_Mandala = new ArrayList<Pattern>();
  
  SunNode sNode = new SunNode(30);
  Pattern p = new Pattern(sNode);
  g_Mandala.add(p);
  
  Shape node = new EllipseNode(20, new PVector(30, 50, 70), new PVector(70, 90, 110));
  Pattern p1 = new Pattern(node, p.m_OuterRadius);
  p1.m_Effects.add(new RotateEffect(TWO_PI*2, 800));
  p1.m_Effects.get(0).SetLoopable(true);
  
  g_Mandala.add(p1);
  
  ArrayList<IEffect> effects = new ArrayList<IEffect>();
  //effects.add(new RotateEffect(TWO_PI*2, 800));
  //effects.add(new PulseScaleEffect(3, 80));
  
  //effects.get(0).SetLoopable(true);
  //effects.get(1).SetLoopable(true);
  
  Shape sqNode = new RectNode(15, 15, true, new PVector(110, 130, 150), true, new PVector(150, 180, 210), effects);
  Pattern p2 = new Pattern(sqNode, p1.m_OuterRadius, new PVector(0, 0, 80), new PVector(250, 255, 255));
  g_Mandala.add(p2);
  
  Shape trNode = new TriangleNode(30, true, new PVector(110, 130, 150), true, new PVector(150, 180, 210), effects);
  Pattern p3 = new Pattern(trNode, p2.m_OuterRadius, new PVector(0, 0, 80), new PVector(250, 255, 255));
  g_Mandala.add(p3);
}
