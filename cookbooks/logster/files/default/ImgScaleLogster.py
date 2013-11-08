###  A sample logster parser file that can be used to count the number
###  of response codes found in an nginx access log.
###
###  For example:
###  sudo ./logster --dry-run --output=ganglia SampleLogster /var/log/httpd/access_log
###
###
###  along with Logster. If not, see <http://www.gnu.org/licenses/>.
###

import time
import re
from socket import gethostname

from logster.logster_helper import MetricObject, LogsterParser
from logster.logster_helper import LogsterParsingException

# IHR Modifications
FULL_HOSTNAME=gethostname()
SHORT_HOSTNAME=FULL_HOSTNAME.split('.')[0]

class ImgScaleLogster(LogsterParser):

    def __init__(self, option_string=None):
        '''Initialize any data structures or variables needed for keeping track
        of the tasty bits we find in the log we are parsing.'''
        self.http_1xx = 0
        self.http_2xx = 0
        self.http_3xx = 0
        self.http_4xx = 0
        self.http_5xx = 0
        
        # Regular expression for matching lines we are interested in, and capturing
        # fields from the line (in this case, http_status_code).
        self.reg = re.compile('.*HTTP/1.\d (?P<http_status_code>\d{3}) .*')


    def parse_line(self, line):
        '''This function should digest the contents of one line at a time, updating
        object's state variables. Takes a single argument, the line to be parsed.'''

        try:
            # Apply regular expression to each line and extract interesting bits.
            regMatch = self.reg.match(line)

            if regMatch:
                linebits = regMatch.groupdict()
                status = int(linebits['http_status_code'])

                if (status < 200):
                    self.http_1xx += 1
                elif (status < 300):
                    self.http_2xx += 1
                elif (status < 400):
                    self.http_3xx += 1
                elif (status < 500):
                    self.http_4xx += 1
                else:
                    self.http_5xx += 1

            else:
                raise LogsterParsingException, "regmatch failed to match"

        except Exception, e:
            raise LogsterParsingException, "regmatch or contents failed with %s" % e


    def get_state(self, duration):
        '''Run any necessary calculations on the data collected from the logs
        and return a list of metric objects.'''
        self.duration = duration

        # Return a list of metrics objects
        return [
            MetricObject("imgscaler." + SHORT_HOSTNAME + ".http_1xx", (self.http_1xx / self.duration), "Responses per sec"),
            MetricObject("imgscaler." + SHORT_HOSTNAME + ".http_2xx", (self.http_2xx / self.duration), "Responses per sec"),
            MetricObject("imgscaler." + SHORT_HOSTNAME + ".http_3xx", (self.http_3xx / self.duration), "Responses per sec"),
            MetricObject("imgscaler." + SHORT_HOSTNAME + ".http_4xx", (self.http_4xx / self.duration), "Responses per sec"),
            MetricObject("imgscaler." + SHORT_HOSTNAME + ".http_5xx", (self.http_5xx / self.duration), "Responses per sec"),
        ]
