fetch('content/watch_later.json')
	.then(response => response.json())
	.then(videos => {
		const videoListElement = document.getElementById('video-list');

		videos.forEach(video => {
			const container = document.createElement('div');
			container.className = 'video-container';

			const title = document.createElement('h3');
			const titleLink = document.createElement('a');
			titleLink.href = video.url;
			titleLink.target = '_blank';
			titleLink.textContent = video.title;
			title.appendChild(titleLink);

			const thumbnailLink = document.createElement('a');
			thumbnailLink.href = video.url;
			thumbnailLink.target = '_blank';

			const thumbnail = document.createElement('img');
			thumbnail.src = video.thumbnail_url;
			thumbnail.className = 'thumbnail';

			thumbnailLink.appendChild(thumbnail);

			container.appendChild(title);
			container.appendChild(thumbnailLink);
			videoListElement.appendChild(container);
		});
	});
