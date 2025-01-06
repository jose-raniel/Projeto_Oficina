-- Script de criação do banco de dados da oficina
CREATE DATABASE Oficina;
USE Oficina;

-- Tabela Cliente
CREATE TABLE Cliente (
    idCliente INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(45) NOT NULL,
    Telefone VARCHAR(20),
    Endereco VARCHAR(100)
);

-- Tabela Veículo
CREATE TABLE Veiculo (
    Placa VARCHAR(45) PRIMARY KEY,
    Modelo VARCHAR(45) NOT NULL,
    Marca VARCHAR(45) NOT NULL,
    Ano YEAR,
    Id_Cliente INT, -- FK para Cliente
    CONSTRAINT fk_veiculo_cliente FOREIGN KEY (Id_Cliente) REFERENCES Cliente(idCliente)
);

-- Tabela Ordem de Serviço
CREATE TABLE OrdemServico (
    Numero_OS INT AUTO_INCREMENT PRIMARY KEY,
    Data_Emissao DATE NOT NULL,
    Valor_Total DECIMAL(10,2),
    Status VARCHAR(45),
    Data_Conclusao DATE
);

-- Tabela Equipe
CREATE TABLE Equipe (
    idEquipe INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(45) NOT NULL
);

-- Tabela Mecânico
CREATE TABLE Mecanico (
    idMecanico INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(45) NOT NULL,
    Endereco VARCHAR(100),
    Especialidade VARCHAR(45),
    Equipe_idEquipe INT, -- FK para Equipe
    CONSTRAINT fk_mecanico_equipe FOREIGN KEY (Equipe_idEquipe) REFERENCES Equipe(idEquipe)
);

-- Tabela Serviço
CREATE TABLE Servico (
    idServico INT AUTO_INCREMENT PRIMARY KEY,
    Descricao VARCHAR(100) NOT NULL,
    Valor_Mao_de_Obra DECIMAL(10, 2) NOT NULL
);

-- Tabela Peça
CREATE TABLE Peca (
    idPeca INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(45) NOT NULL,
    Valor DECIMAL(10,2) NOT NULL
);

-- Tabela Peça_OS
CREATE TABLE Peca_OS (
    Peca_idPeca INT, -- FK para Peça
    Ordem_Servico_Numero_OS INT, -- FK para Ordem de Serviço
    Id_Item INT AUTO_INCREMENT PRIMARY KEY,
    Quantidade INT NOT NULL,
    Valor_Total_Item DECIMAL(10,2) NOT NULL,
    CONSTRAINT fk_pecaos_peca FOREIGN KEY (Peca_idPeca) REFERENCES Peca(idPeca),
    CONSTRAINT fk_pecaos_ordem_servico FOREIGN KEY (Ordem_Servico_Numero_OS) REFERENCES OrdemServico(Numero_OS)
);

-- Tabela Item_OS
CREATE TABLE Item_OS (
    Servico_idServico INT, -- FK para Serviço
    Ordem_Servico_Numero_OS INT, -- FK para Ordem de Serviço
    PRIMARY KEY (Servico_idServico, Ordem_Servico_Numero_OS),
    CONSTRAINT fk_itemos_servico FOREIGN KEY (Servico_idServico) REFERENCES Servico(idServico),
    CONSTRAINT fk_itemos_ordem_servico FOREIGN KEY (Ordem_Servico_Numero_OS) REFERENCES OrdemServico(Numero_OS)
);
