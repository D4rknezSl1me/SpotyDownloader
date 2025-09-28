"""
SpotyBot - A Spotify playlist downloader using spotDL
"""

__version__ = "1.0.0"
__author__ = "SpotyBot"
__email__ = "spotybot@example.com"
__description__ = "A Spotify playlist downloader bot using spotDL"

# Import main classes when dependencies are available
try:
    from .config import Config
    from .spotify_client import SpotifyClient
    from .downloader import SpotifyDownloader
    from .bot import SpotyBot
    
    __all__ = ["SpotyBot", "Config", "SpotifyClient", "SpotifyDownloader"]
    
except ImportError:
    # Allow import of package info even if dependencies aren't installed
    __all__ = []