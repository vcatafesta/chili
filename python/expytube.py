#pip3 install pytube3

from pytube import YouTube

def list_stream():
    youtube_video_url = 'https://www.youtube.com/watch?v=DkU9WFj8sYo'
    yt_obj = YouTube(youtube_video_url)

    for stream in yt_obj.streams:
        print(stream)
    filters = yt_obj.streams.filter(progressive=True, file_extension='mp4')
    for mp4_filter in filters:
        print(mp4_filter)

def get_info(url):
    try:
        yt_obj = YouTube(url)

        print(f'Video Title is {yt_obj.title}')
        print(f'Video Length is {yt_obj.length} seconds')
        print(f'Video Description is {yt_obj.description}')
        print(f'Video Rating is {yt_obj.rating}')
        print(f'Video Views Count is {yt_obj.views}')
        print(f'Video Author is {yt_obj.author}')

    except Exception as e:
        print(e)


def get_video():
    #youtube_video_url = 'https://www.youtube.com/watch?v=DkU9WFj8sYo'
    youtube_video_url = input('Entre a url do video Youtube para download: ')

    try:
        get_info(youtube_video_url)
        yt_obj = YouTube(youtube_video_url)
        filters = yt_obj.streams.filter(progressive=True, file_extension='mp4')
        filters.get_highest_resolution().download()
        print('Video Downloaded Successfully')
    except Exception as e:
        print(e)

def get_audio_only():
#   youtube_video_url = 'https://www.youtube.com/watch?v=DkU9WFj8sYo'
    youtube_video_url = input('Entre a url do video Youtube para download do audio: ')

    try:
        get_info(youtube_video_url)
        yt_obj = YouTube(youtube_video_url)
        yt_obj.streams.get_audio_only().download(output_path='/Users/pankaj/temp', filename='audio')
        print('YouTube video audio downloaded successfully')
    except Exception as e:
        print(e)

if __name__ == '__main__':
    get_video()
