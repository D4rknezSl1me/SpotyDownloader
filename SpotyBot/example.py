#!/usr/bin/env python3
"""
Simple example script demonstrating how to use SpotyBot
"""

from spotybot import SpotyBot, Config
from rich.console import Console

console = Console()

def main():
    """Example usage of SpotyBot"""
    
    # Initialize configuration from .env file
    console.print("[bold cyan]🔧 Loading configuration...[/bold cyan]")
    config = Config.from_env()
    
    # Create SpotyBot instance
    console.print("[bold cyan]🚀 Initializing SpotyBot...[/bold cyan]")
    bot = SpotyBot(config)
    
    # Example playlist URL (Spotify's Today's Top Hits)
    playlist_url = "https://open.spotify.com/playlist/37i9dQZF1DXcBWIGoYBM5M"
    
    console.print(f"\n[bold green]📋 Example: Downloading playlist[/bold green]")
    console.print(f"URL: {playlist_url}")
    
    # Get playlist info first
    try:
        info = bot.get_playlist_info(playlist_url)
        console.print(f"📝 Playlist: {info['name']}")
        console.print(f"👤 Owner: {info['owner']}")
        console.print(f"🎵 Total tracks: {info['total_tracks']}")
        
        # Ask user if they want to proceed
        proceed = input("\nDo you want to download this playlist? (y/N): ").lower().strip()
        
        if proceed == 'y':
            # Download only first 3 tracks for demo
            console.print("\n[yellow]📥 Downloading first 3 tracks (demo limit)...[/yellow]")
            success = bot.download_playlist(playlist_url, max_tracks=3)
            
            if success:
                console.print("\n[bold green]✅ Download completed successfully![/bold green]")
                console.print(f"📁 Check your downloads in: {config.output_directory}")
            else:
                console.print("\n[bold red]❌ Download failed![/bold red]")
        else:
            console.print("\n[yellow]⏭️ Skipping download[/yellow]")
            
    except Exception as e:
        console.print(f"\n[bold red]❌ Error: {e}[/bold red]")
        console.print("\n[yellow]💡 Make sure you've configured your Spotify API credentials in .env[/yellow]")
        console.print("Run: spotybot setup")

    # Example search
    console.print(f"\n[bold green]🔍 Example: Search and download[/bold green]")
    search_query = "The Beatles Hey Jude"
    console.print(f"Query: {search_query}")
    
    proceed = input("\nDo you want to search and download this song? (y/N): ").lower().strip()
    
    if proceed == 'y':
        try:
            success = bot.search_and_download(search_query, limit=1)
            if success:
                console.print("\n[bold green]✅ Search and download completed![/bold green]")
            else:
                console.print("\n[bold red]❌ Search and download failed![/bold red]")
        except Exception as e:
            console.print(f"\n[bold red]❌ Error: {e}[/bold red]")
    else:
        console.print("\n[yellow]⏭️ Skipping search[/yellow]")
    
    console.print(f"\n[bold cyan]🎉 Demo completed![/bold cyan]")
    console.print(f"💡 Try the interactive mode: spotybot interactive")

if __name__ == "__main__":
    main()