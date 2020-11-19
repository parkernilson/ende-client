<style>
	:global(body) {
		padding: 0;
		font-family: Lato, sans-serif;
	}

	.main-container {
		background: linear-gradient(
			180deg, 
			rgb(29, 150, 163, 1) 0%, 
			rgba(68, 64, 177, 1) 60%, 
			rgba(254, 0, 255, 1) 100%
		);
		color: white;
		min-height: 100vh;
		box-sizing: border-box;
		padding-bottom: 64px;
		width: 100%;
		display: flex;
		justify-content: center;
	}

	.center-content-container {
		flex: 1;
		height: 100%;
		max-width: 600px;
		padding-left: 16px;
		padding-right: 16px;
		display: flex;
		flex-direction: column;
	}

	h1 {
		font-size: 70px;
	}

	.title {
		font-style: italic;
		font-weight: 700;
		-webkit-text-stroke: 1px black;
		margin-bottom: 0;
	}

	.subtitle {
		margin-top: 0;
	}

	.byline {
		align-self: flex-end;
	}
</style>

<script>
	import TranslatorBox from './translator-box/TranslatorBox.svelte';
</script>

<svelte:head>
	<link rel="preconnect" href="https://fonts.gstatic.com">
	<link href="https://fonts.googleapis.com/css2?family=Lato:ital,wght@0,400;1,700&display=swap" rel="stylesheet">
</svelte:head>

<div class="main-container">
	<div class="center-content-container">
		<h1 class="title">Translate</h1>
		<h2 class="subtitle">English to German</h2>
		<h3 class="byline">by, Parker Nilson</h3>
		<TranslatorBox />
	</div>
</div>