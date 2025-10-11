terraform { 
  cloud { 
    
    organization = "MattiTPersonalAccount" 

    workspaces { 
      name = "matti-project" 
    } 
  } 
}

provider "azurerm" {
    features {}
    use_oidc = true
}