#-----------------------------

#Load and format data

#set up sheets
pg1 <- read_excel("data/100 Day Tracker Data.xlsx", sheet = "Actions")
tbDays <- read_excel("data/100 Day Tracker Data.xlsx", sheet = "Days")
pg3 <- read_excel("data/100 Day Tracker Data.xlsx", sheet = "Committees")
pg4 <- read_excel("data/100 Day Tracker Data.xlsx", sheet = "Progress Updates")

# Read in text update files from updates folder
# Used https://wordtohtml.net/ to keep formatting from google doc where partners entered updates
updateText <- readChar("updates/2021-02-24-update.txt",nchars=1e6)

#Priorities table listing all actions, categorized into committee and level of completion
tbPriorities <- pg1 %>%
  mutate(Progress = factor(Progress, levels=c("Complete", "In Progress", "Not Yet Started"))) %>% 
  arrange(Committee, Progress)

#This table then nests all actions into a table of the committees to make it possible later
#to have an expand/contract table button for each committee
tbActionsNested <- tbPriorities %>% 
  mutate(ActionProgressParties = mapply(c, Action, 
                                        symbol(Progress),
                                        `Parties Responsible`, 
                                        SIMPLIFY = F)) %>% 
  select(c("Committee", "ActionProgressParties")) %>% 
  group_by(Committee) %>%
  summarise(ActionProgressParties = list(unique(ActionProgressParties))) 

#This then takes the nested table, adds formatting and icons, and arranges it so it's ready to
#be used to create the nested table with progress boxes.
tbCommittees <- pg3 %>% 
  rename("Priority Area" = Name) %>% 
  left_join(tbActionsNested, by = c("Priority Area" = "Committee")) %>%
  #here, enter the committees or other categories you used to group the actions and relate them
  #to the icons you created earlier in this file.
  mutate(.,"Icon" = with(.,case_when(
    (`Priority Area` == "Building Public Safety") ~ safety,
    (`Priority Area` == "Making Baltimore Equitable") ~ equity1,
    (`Priority Area` == "Prioritizing Our Youth") ~ education,
    (`Priority Area` == "Building Public Trust") ~ governance,
    (`Priority Area` == "COVID-19 Recovery") ~ health,
    T ~ as.character(finance)
  ))) %>% 
  mutate(Progress = lapply(ActionProgressParties, FUN=priorityAreaProgressBar))

tbCommittees <- tbCommittees %>% 
  select(-c(grep(pattern="_", x=colnames(tbCommittees)))) %>% 
  select(Icon, everything())

#------------------------------------

#Creating these calculations allows us to measure the number of actions by status, which lets us
#color the boxes according to status.
actionsTotal <- nrow(tbPriorities)
actionsComplete <- nrow(tbPriorities[ which(tbPriorities$Progress == "Complete"),])
actionsInProgress <- nrow(tbPriorities[ which(tbPriorities$Progress == "In Progress"),])
actionsRemaining <- actionsTotal - actionsComplete - actionsInProgress

# Dynamic title for progress bar
progressText <- paste0("There are ", actionsTotal, " actions planned in total. ",
                       actionsComplete, " are complete, and ", actionsInProgress, " are in progress.")