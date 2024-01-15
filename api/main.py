from flask import Flask, request, jsonify
import urllib
import requests
from bs4 import BeautifulSoup

app = Flask(__name__)

def get_events(url: str):
    # header to work with google
    headers = {
        'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36',
    }

    response = requests.get(url, headers=headers) # get response from url
    html_content = response.text # get html content from response
    
    soup = BeautifulSoup(html_content, 'html.parser') # parse the html with bs4

    title_elements = soup.find_all('div', {'class': 'YOGjf'}) # get all the title elements
    titles = [title.get_text() for title in title_elements] # create array of titles

    date_elements = soup.find_all('div', {'class': 'cEZxRc'}) # get all the date elements
    dates = [] # initialize dates array
    for date in date_elements:
        # check if date element has a class
        if date.has_attr('class'):
            # check if the first class is 'cEZxRc'
            if date['class'][0] == 'cEZxRc':
                try: # if a second class exists within the date element continue without appending
                    date['class'][1]
                    continue
                except IndexError as e: # if second class doesn't exist then append the date text to array
                    del e
                    dates.append(date.get_text())
    
    location_elements = soup.find_all('div', {'class': 'cEZxRc zvDXNd'}) # get all elements with both specific class names 
    street_addresses = [location.get_text() for location in location_elements[::2]] # street address is the first element in locations
    city_states = [location.get_text() for location in location_elements[1::2]] # city and state address is the second element in locations
    
    events_info = [] # initialize empty dictionary
    for i in range(max(len(titles), len(dates), len(street_addresses), len(city_states))): # only itirate for the max of each arrays
        event_info = { # create events data dictionary
            'title': titles[i] if i < len(titles) else '',
            'date': dates[i] if i < len(dates) else '',
            'street_address': street_addresses[i] if i < len(street_addresses) else '',
            'city_state': city_states[i] if i < len(city_states) else '',
        }
        events_info.append(event_info) # assign number to each event
    
    return events_info # return events as data 

@app.route('/search', methods=['GET'])
def search_events():
    search_query = request.args.get('query', '') # get search query for google events
    
    # create url
    url = 'https://www.google.com/search?q=' + urllib.parse.quote(search_query) + '&oq=' + urllib.parse.quote(search_query) + '&ibp=htl;events&rciv=evn'
    
    # get events data from url
    data = get_events(url)
    
    # create response data
    response = {
        'events': data
    }
    
    return jsonify(response) # return json of response data

if __name__ == '__main__':
    app.run(debug=True, host="0.0.0.0")
