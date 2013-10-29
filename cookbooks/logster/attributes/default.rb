default[:logster][:static_files] = {
        "/usr/lib/python2.6/site-packages/logster-0.0.1-py2.6.egg/logster/parsers/ApacheLogster.py" => "ApacheLogster.py",
        "/usr/lib/python2.6/site-packages/logster-0.0.1-py2.6.egg/logster/parsers/Log4jIHR.py" => "Log4jIHR.py",
        "/usr/lib/python2.6/site-packages/logster-0.0.1-py2.6.egg/logster/parsers/TomcatLogster.py" => "TomcatLogster.py",
        "/usr/lib/python2.6/site-packages/logster-0.0.1-py2.6.egg/logster/parsers/NewsLogster.py" => "NewsLogster.py",
        "/usr/lib/python2.6/site-packages/logster-0.0.1-py2.6.egg/logster/parsers/ImgProxyLogster.py" => "ImgProxyLogster.py",
        "/usr/lib/python2.6/site-packages/logster-0.0.1-py2.6.egg/logster/parsers/ImgScaleLogster.py" => "ImgScaleLogster.py"
}

default[:logster]["statefile_cron"] = { "minute" => "1", "hour" => "0", "path" => nil}
