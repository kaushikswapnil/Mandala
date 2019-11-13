class IGraphicNode
{
    float m_Scale;
    ArrayList<IEffect> m_Effects;
    
    IGraphicNode()
    {
       m_Scale = 1.0f;
       m_Effects = new ArrayList<IEffect>();
    }
    
    IGraphicNode(ArrayList<IEffect> effects)
    {
       m_Scale = 1.0f;
       m_Effects = effects;
    }
    
    IGraphicNode(float scale, ArrayList<IEffect> effects)
    {
       m_Scale = scale;
       m_Effects = effects;
    }
    
    void Display()
    {
      
    }
    
    void Update()
    {
      for(int iter = m_Effects.size() - 1; iter >= 0; --iter)
      {
         IEffect effect = m_Effects.get(iter);
         
         if (effect.IsStarted() == false)
         {
            effect.Start(); 
         }
         
         ApplyEffect(effect);
         
         if (effect.IsComplete())
         {
             m_Effects.remove(iter);
         }
      }
    }
    
    void ApplyEffect(IEffect effect)
    {
      effect.Apply(this);
    }
}
