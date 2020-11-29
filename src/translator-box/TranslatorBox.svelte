<style>
    .container {
        width: 100%;
        box-shadow: 1px 3px 8px rgba(0, 0, 0, 0.3);
        border-radius: 16px;
        background-color: rgba(246, 246, 246, 1);
        margin-bottom: 32px;
    }

    .input-container {
        display: flex;
        flex-direction: column;

        padding: 16px;
        box-shadow: 1px 3px 8px rgba(0, 0, 0, 0.3);
        background-color: white;
        border-radius: 16px;
    }

    .text-input-area {
        width: 100%;
        height: 100%;
        box-sizing: border-box;
        margin-bottom: 6px;

        color: black;
        border-radius: 16px;
        background-color: rgba(0, 0, 0, 0);
        border: none;
    }

    .flex-row {
        display: flex;
        justify-content: space-between;
        align-items: flex-end;
    }

    .translate-button {
        height: 32px;
        margin: 0;
        border-radius: 16px;
        background-color: #526dff;
        box-shadow: 1px 3px 8px rgba(0, 0, 0, 0.3);
        border: none;
        color: white;
    }

    .output-container {
        border-bottom-left-radius: 16px;
        border-bottom-right-radius: 16px;
        padding: 16px;
    }

    .translation-output {
        border: none;
        width: 100%;
        margin: 0;
        box-sizing: border-box;
        color: black;
    }

    [contenteditable]:active,
    [contenteditable]:focus {
        border:none;
        outline:none;
    }

    .text-input-area:empty::before {
        content: attr(placeholder);
        color: gray;
    }

    .text-input-area:empty:focus::before {
        content: "";
    }

    .char-count {
        color: black;
    }

    .alert {
        color: red;
    }
</style>

<script lang="typescript">
    import { slide } from 'svelte/transition';

    const maxInputLength = 300;

    /** value of the input text for translation */
    let inputText: string = "";
    /** value of the last translated phrase */
    let translatedText: string = "";

    /**
     * Request a translation from the translation server
     */
    function requestTranslation(phrase: string) {
        if (inputText.length > maxInputLength) {
            alert(`The max input length is ${maxInputLength} characters`);
            return;
        }

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
    <div class="input-container">
        <div contenteditable bind:textContent={inputText} placeholder="Type a phrase you would like to translate here..." class="text-input-area">
            {inputText}
        </div>
        <div class="flex-row">
            <div class="char-count {inputText.length > maxInputLength && "alert"}">{inputText.length || 0}/{maxInputLength}</div>
            <button class="translate-button" on:click={()=>requestTranslation(inputText)}>Translate</button>
        </div>
    </div>
    {#if translatedText !== ""}
        {#key translatedText}
            <div transition:slide class="output-container">
                <p class="translation-output">{translatedText}</p>
            </div>
        {/key}
    {/if}
</div>