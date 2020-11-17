
<style>
    .container {
        width: 100%;
        height: 400px;
        position: relative;
        box-shadow: 1px 3px 8px rgba(0, 0, 0, 0.3);
        border-radius: 16px;
    }

    .text-input {
        width: 100%;
        height: 50%;
        position: relative;
        border-radius: 16px;
        margin-bottom: -25%;
        z-index: 1000;
        color: black;
        box-shadow: 1px 3px 8px rgba(0, 0, 0, 0.3);
    }

    .text-input-area {
        width: 100%;
        height: 100%;
        position: relative;
        border-radius: 16px;
        resize: none;
        padding: 16px;
    }

    .translation-output-container {
        background-color: rgba(246, 246, 246, 1);
        position: absolute;
        top: 0;
        width: 100%;
        height: 100%;
        border-radius: 16px;
    }

    .translation-output {
        border: none;
        width: 100%;
        height: 50%;
        margin: 0;
        position: absolute;
        bottom: 0;
        padding: 16px;
        box-sizing: border-box;
        color: black;
    }

    .translate-button {
        position: absolute;
        height: 32px;
        border-radius: 16px;
        background-color: rgba(187, 127, 255, 1);
        box-shadow: 1px 3px 8px rgba(0, 0, 0, 0.3);
        border: none;
        color: white;
        right: 16px;
        bottom: 8px;
    }
</style>

<script lang="typescript">
    /** value of the input text for translation */
    let inputText: string = "";
    /** value of the last translated phrase */
    let translatedText: string = "";

    /**
     * Request a translation from the translation server
     */
    function requestTranslation(phrase: string) {
        // indicate loading
        translatedText = "loading translation...";

        // perform the translation by requesting the translation api
        fetch('/api/translate/en-to-de', {
            method: "POST",
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({
                phrase: inputText
            })
        })
        .then(response => response.json())
        .then(result => {
            // set the translated text
            translatedText = result.translation;
        })
        .catch(error => {
            // output error to console for developer
            console.error(error)

            // indicate error in the ui
            translatedText = `An error occurred with message: ${error.message}`
        })
    }
</script>

<div class="container">
    <div class="text-input">
        <textarea bind:value={inputText} placeholder="Type a phrase you would like to translate here..." class="text-input-area" maxlength="300"/>
        <button class="translate-button" on:click={()=>requestTranslation(inputText)}>Translate</button>
    </div>
    <div class="translation-output-container">
        <p class="translation-output">{translatedText}</p>
    </div>
</div>