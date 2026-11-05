# ====================================================================
# Makefile for Custom wxWidgets MPD Client
# ====================================================================

# Compiler and standard
CXX      := g++
CXXFLAGS := -std=c++17 -Wall -Wextra -O2

# Target executable name
TARGET   := custom-mpd-client

# Directories
SRC_DIR  := src
OBJ_DIR  := obj

# Source files and Object files mapping
SRCS     := $(wildcard $(SRC_DIR)/*.cpp)
OBJS     := $(SRCS:$(SRC_DIR)/%.cpp=$(OBJ_DIR)/%.o)

# Dynamically gather wxWidgets flags and libraries
WX_CXXFLAGS := $(shell wx-config --cxxflags)
WX_LIBS     := $(shell wx-config --libs)

# Combine compilation flags
ALL_CXXFLAGS := $(CXXFLAGS) $(WX_CXXFLAGS)

# Phony targets declaration
.PHONY: all clean run

# Default rule: Build the executable
all: $(TARGET)

# Linking rule
$(TARGET): $(OBJS)
	@echo "Linking target executable: $@"
	$(CXX) $(OBJS) $(WX_LIBS) -o $@
	@echo "Build complete!"

# Compilation rule for object files
$(OBJ_DIR)/%.o: $(SRC_DIR)/%.cpp | $(OBJ_DIR)
	@echo "Compiling: $<"
	$(CXX) $(ALL_CXXFLAGS) -c $< -o $@

# Create object directory if it doesn't exist
$(OBJ_DIR):
	@mkdir -p $(OBJ_DIR)

# Run the compiled binary immediately
run: all
	./$(TARGET)

# Clean up build artifacts
clean:
	@echo "Cleaning project..."
	@rm -rf $(OBJ_DIR) $(TARGET)
	@echo "Clean complete!"
