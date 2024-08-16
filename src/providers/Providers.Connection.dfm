object ProvidersConnection: TProvidersConnection
  Height = 200
  Width = 126
  object FDConnection: TFDConnection
    Params.Strings = (
      'ConnectionDef=Curso_Pooled')
    LoginPrompt = False
    Left = 40
    Top = 48
  end
  object FDPhysPgDriverLink: TFDPhysPgDriverLink
    VendorLib = 'C:\Users\Clevsson\Documents\GitHub\APIPedidosHorse\lib\libpq.dll'
    Left = 32
    Top = 112
  end
end
