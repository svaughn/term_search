# term_search
Powershell Script that compares google seach frequence of terms in a list 

I wanted to know what the most frequently cited MQ commands, IIB commands and IIB nodes are.
This script:
* reads a list of terms in from a file
* does a goole search on each term
* records the result count for each turn
* sorts the items by count
* creates csv file with the results

Note: Google will throw up a CAPTCH test every so often. The script gives you 10 minutes to solve it so that the script can continue

Also Note: This script uses Selenium 1.2 module. You can get it from the PowerShell Gallery using this command:
  Install-Module -Name Selenium -RequiredVersion 1.2
