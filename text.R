#--------------------------------

#Document Text

# Add text for Brandon Scott's welcome
title <- "Title Here"
text1 <- div(HTML("<p>Enter text from your team describing the project here.</p>
      <p>Describe the process used to achieve these aims.</p>"))
text2 <- div(HTML("<p class=\"tab-header\">Intro text to the transition agenda.</p>"))
text4 <- div(HTML("<p class=\"tab-header\">Intro text to the resources and feedback page.</p>"))

# Add texts and links for the resources page
link1 <- HTML("<p><b><a href='https://www.baltimorecity.gov/'>Link 1</a></b>"
              ," - Action for this link.</p>")
link2 <- HTML("<p><b><a href='https://www.baltimorecity.gov/'>Link 2</a></b>"
              ," - Action for this link.</p>")
link3 <- HTML("<p><b><a href='https://www.baltimorecity.gov/'>Link 3</a></b>"
              ," - Action for this link.</p>")
link4 <- HTML("<p><b><a href='https://www.baltimorecity.gov/'>Link 4</a></b>"
              ," - Action for this link.</p>")
link5 <- HTML("<p><b><a href='https://www.baltimorecity.gov/'>Link 5</a></b>"
              ," - Action for this link.</p>")
link6 <- HTML("<p><b><a href='https://www.baltimorecity.gov/'>Link 6</a></b>"
              ," - Action for this link.</p>")

#create structure for links
links <- div(
  id = "links",
  fluidRow(column(6,link1),
           column(6,link2),
  ),
  fluidRow(column(6,link3),
           column(6,link4),
  ),
  fluidRow(column(6,link5),
           column(6,link6),
  ),
  hr()
)

# Create "about this initiative" page

aboutus <- {div(
  div(style="float:right;margin-top:8px;margin-left:48px;margin-bottom:24px;",
      img(src = "photos/citistat.jpg",
          height = 4096*.1,
          width = 3072*.1),
      h5("Description of Photo.", height = 150)
  ),
  h3("Hello"),
  p("First Paragraph"),
  p("Second Paragraph"),
  p("Third Paragraph"),
  p("Fourth Paragraph"),
  p("Fifth Paragraph"),
  p("Sixth Paragraph"),
  br(),
  p("Yours,"),
  img(src = "photos/signature.PNG",
      style="margin-left:-8px;",
      height = 176/4, width = 717/4),
  tags$b(p("Organization Lead")),
  p("Title"),
  hr(style="border-color: white;")
)}
