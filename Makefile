# Nom du programme à compiler
TARGET = algone

# Compilateur
CXX = g++

# Options du compilateur
CXXFLAGS = -std=c++20 -Wall

# Dossiers contenant les fichiers source
SRCDIR = src

# Récupérer tous les fichiers source dans les dossiers spécifiés
#SOURCES = $(wildcard $(SRCDIR)/**/*.cc) $(wildcard $(SRCDIR)/*.cc)
SOURCES = $(shell find $(SRCDIR) -name "*.cc")

# Générer les noms des fichiers objets correspondants
OBJECTS = $(SOURCES:$(SRCDIR)/%.cc=build/%.o)

# Nom du dossier de sortie des fichiers objets
BUILDDIR = build

# Nom du dossier de sortie de l'exécutable
BINDIR = bin

# Chemin complet du dossier de sortie de l'exécutable
OUTDIR = $(BINDIR)

# Commande pour créer les dossiers de sortie s'ils n'existent pas
MKDIR_P = mkdir -p

# Règle par défaut
all: $(OUTDIR)/$(TARGET)

# Règle pour générer le programme
$(OUTDIR)/$(TARGET): $(OBJECTS)
	@$(MKDIR_P) $(OUTDIR)
	@$(MKDIR_P) $(BINDIR)
	$(CXX) $(CXXFLAGS) $^ -o $@

# Règle générique pour la compilation des fichiers objets
build/%.o: $(SRCDIR)/%.cc
	@$(MKDIR_P) $(dir $@)
	$(CXX) $(CXXFLAGS) -c $< -o $@

# Nettoyer les fichiers objets et l'exécutable
clean:
	$(RM) -r $(BUILDDIR) $(BINDIR)

# Ne pas supprimer les fichiers objets intermédiaires
.PRECIOUS: build/%.o

# Indiquer les fichiers phony (non associés à des noms de fichiers)
.PHONY: all clean
