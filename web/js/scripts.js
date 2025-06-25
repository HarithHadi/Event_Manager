// gets the saerch input that is id search
const searchInput = document.getElementById('search');
// Selecting all the elements in the DOM that have the class 'card' and stores them in a list
const cards = document.querySelectorAll('.card');

// Attaches an event listener to the searchInput element. The event is triggered every time the user types into the search input field
searchInput.addEventListener('input', function() {
    // this.value refers to the current value of the search input field (what the user typed)
    const searchValue = this.value.toLowerCase();

    // This loop iterates over each .card element stored in the cards list. 
    // For each iteration, the card variable refers to the current card being processed.
    cards.forEach(card => {
        // For each card, we are looking for: 
        // The 'card_title' element (which holds the title of the event)
        const title = card.querySelector('.card__title').textContent.toLowerCase();
        // the 'card__category' element which holds the category of the event
        const category = card.querySelector('.card_category').textContent.toLowerCase();
        // textcontent gets the text inside those elements and 'toLowerCase()' ensures both the title and category are in lowercase.

        // checks if the searchvalue is included in the title or category of the card
        if (title.includes(searchValue) || category.includes(searchValue)) {
            // if either the title or the category contains the search value, the card will be displayed
            card.style.display = 'block'; // show matching card
        } else {
            card.style.display = 'none';  // hide non-matching card
        }
    });
});
