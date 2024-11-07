# pages/tests.py
from django.test import SimpleTestCase

class PageTests(SimpleTestCase):

    def test_home_page_status_code(self):
        #get request to get status_code 200, which is a successful status code (ex. 404 file not found)
        response = self.client.get('/')
        self.assertEqual(response.status_code, 200)

    def test_about_page_status_code(self):
        response = self.client.get('/about/')
        self.assertEqual(response.status_code, 200)