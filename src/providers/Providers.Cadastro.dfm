inherited ProvidersCadastro: TProvidersCadastro
  Width = 347
  inherited FDConnection: TFDConnection
    Left = 24
    Top = 8
  end
  inherited FDPhysPgDriverLink: TFDPhysPgDriverLink
    Left = 24
    Top = 96
  end
  object qryPesquisa: TFDQuery
    CachedUpdates = True
    Connection = FDConnection
    Left = 168
    Top = 8
  end
  object qryRecordCount: TFDQuery
    CachedUpdates = True
    Connection = FDConnection
    Left = 256
    Top = 8
    object qryRecordCountCOUNT: TLargeintField
      FieldName = 'COUNT'
    end
  end
  object qryCadastro: TFDQuery
    CachedUpdates = True
    Connection = FDConnection
    Left = 208
    Top = 80
  end
end
