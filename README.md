The project follows a simple architecture of MVVM. It has two layers that help the ViewModel - PersistanceManager and NetworkMonitor. 
There is a ToastManager that is used when an error or offline case occurs. 
There is CoreData where we save data to show along with the selection. 
It uses SDWebImage to cache images. It refetches new matches everytime you reopen the app (in case you are online). You can email the list of matches too

I've tried to keep the code as simple as possible

https://github.com/user-attachments/assets/9a4c3cbb-be19-4110-95ae-7417378779b8

