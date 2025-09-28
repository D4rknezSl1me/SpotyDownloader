#!/usr/bin/env python3
"""
Quick run script for SpotyBot - launches interactive mode
"""

import sys
import os

# Add the current directory to Python path
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))

try:
    from spotybot.cli import main
    main()
except ImportError as e:
    print("❌ Error: SpotyBot is not properly installed.")
    print("Please run: pip install -r requirements.txt")
    print("Then run: pip install -e .")
    sys.exit(1)
except Exception as e:
    print(f"❌ Error: {e}")
    sys.exit(1)