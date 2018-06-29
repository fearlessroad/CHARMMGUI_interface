#!/usr/bin/env python
# encoding: utf-8

import smtplib
from datetime import datetime


def noticeEMail(starttime, email, message, subj):
    """
    Sends an email message through GMail once the script is completed.  
    Developed to be used with AWS so that instances can be terminated 
    once a long job is done. Only works for those with GMail accounts.
    
    starttime : a datetime() object for when to start run time clock
    usr : the GMail username, as a string
    psw : the GMail password, as a string 
    
    fromaddr : the email address the message will be from, as a string
    
    toaddr : a email address, or a list of addresses, to send the 
             message to
    """
    # Start time of script
    #starttime=datetime.now()

    # Some long job...we'll count to 100,000,000
    count=0
    for i in range(100000000):
        count+=1
        
    # Fill these in with the appropriate info...
    usr='ssamonolayerteam@gmail.com'
    psw='we<3SSA2017'
    fromaddr='ssamonolayerteam@gmail.com'
    toaddr= email
    
    # Calculate run time
    runtime=datetime.now() - starttime
    
    # Initialize SMTP server
    server=smtplib.SMTP('smtp.gmail.com:587')
    server.starttls()
    server.login(usr,psw)
    
    # Send email
    senddate=datetime.strftime(datetime.now(), '%Y-%m-%d')
    subject=subj
    m="Date: %s\r\nFrom: %s\r\nTo: %s\r\nSubject: %s\r\nX-Mailer: My-Mail\r\n\r\n" % (senddate, fromaddr, toaddr, subject)
    msg = message
    
    server.sendmail(fromaddr, toaddr, m+msg)
    server.quit()


if __name__ == '__main__':
    # Start time of script
    starttime=datetime.now()

    # Some long job...we'll count to 100,000,000
    count=0
    for i in range(100000000):
        count+=1
        
    # Fill these in with the appropriate info...
    usr='ssamonolayerteam@gmail.com'
    psw='we<3SSA2017'
    fromaddr='ssamonolayerteam@gmail.com'
    toaddr= email

    # Send notification email
    noticeEMail(starttime, email)
