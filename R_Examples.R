library(dplyr)
library(tidyr)
library(ggvis)
library(DBI)
library(RMySQL)
setwd("E:/Projects/Visual_Assistant_for_R_Data_Wrangling_Packages")
getwd()
library(nycflights13)
library(EDAWR)

tbl_df_example<-tbl_df(iris)
class(iris)
class(tbl_df_example)

is.tbl(iris)

glimpse(iris)

x <- c(-4:4, NA)
if_else(x < 0, NA_integer_, x)

case_when(
  x == -4 ~ 4,
  x == -3 ~ 3,
  x == -2 ~ 2,
  x == -1 ~ 1
)

coalesce(x,0L)

na_if(x,4)

near(x,sqrt(2) ^ 2)

y <- c(5:1)
order_by(y, cumsum(y))

scramble <- function(x) x[sample(nrow(x)), sample(ncol(x))]
all_equal(iris, scramble(iris),  ignore_col_order=FALSE)

glimpse(iris)

View(iris)
iris %>% group_by(Species) %>% summarise(n = n())

group_by_exp <- iris %>% group_by(Species) %>% mutate(specal_Width_mean = mean(Sepal.Width))
View(group_by_exp)

gba_exp <- group_by_all(iris)
groups(gba_exp)

gbat_exp <- group_by_at(iris,vars(Species))
groups(gbat_exp)

group_by_if(iris, is.factor)

group_vars(gbat_exp)

select(iris, Species)

select(iris, -Species)

select(iris, Sepal.Width:Petal.Width)

select(iris, contains("al"))

select(iris, ends_with("Width"))

select(iris, Species, everything())

select(iris, matches("Length"))

df_x <- data.frame(x1=c(1,2,3),x2=c(2,4,6),x3=c(5,6,7),x4=c(2,9,7))
select(df_x, num_range("x",1:3))

select(iris, one_of(c("Species", "Sepal.Length")))

select(iris, starts_with("Petal"))

select_all(iris)

View(flights)
filter_exp8 <- filter(flights, !is.na(arr_delay))

filter_exp9 <- filter(iris, Sepal.Length == 5.2 & Species == "versicolor")

filter_exp10 <- filter(iris, Sepal.Length == 5.2 | Species == "versicolor")

View(mtcars)
filter_all_exp <- filter_all(mtcars, any_vars(. > 150))

filter_if_exp <- filter_if(mtcars, ~ all(floor(.) == .), all_vars(. != 0))

filter_at_exp <- filter_at(mtcars, vars(starts_with("d")), any_vars((. %% 2) == 0))

df_y <- data.frame(x1=c(1,2,1),x2=c(2,3,2),x3=c(3,9,3),x4=c(4,8,4))
distinct_exp <- distinct(df_y)

sample_frac(mtcars, 0.1)

sample_n(mtcars, 10)

slice(mtcars, 1:4)

top_n_exp <- top_n(mtcars, -7)

mutate(df_x, x5 = x1 * x3)

mtcars %>%
  transmute(displ_l = disp / 61.0237)

between(y, -2, 2)

z <- c(TRUE, TRUE, TRUE, FALSE, FALSE, TRUE)
cumall(z)

cumany(z)

cummean(y)

lead(y,1)

lag(y,2)

row_number(x)

ntile(y, 3)

m <- c(5,1,7,9,3,2,4,2)
min_rank(m)

dense_rank(m)

percent_rank(m)

cume_dist(m)

desc(x)

recode(x, '2' = 20L, '4' = 40L)

recode_factor(x, '1' = "z", '2' = "y", .default = "D", .missing = "M")

mtcars %>% summarise(mean = mean(disp), n = n())

mutate_all_exp <- iris %>% group_by(Species)  %>% mutate_all(funs(inches = . / 2.54))

iris %>% as_tibble()

iris %>% mutate_at(vars(matches("Sepal")), log)

transmute_all_exp <- iris %>% group_by(Species)  %>% transmute_all(funs(inches = . / 2.54))

transmute_if_exp <- iris %>% as_tibble() %>% transmute_if(is.factor, as.character)

transmute_at_exp <- iris %>% transmute_at(vars(matches("Sepal")), log)

summarise_all_exp <- iris %>% group_by(Species) %>% summarise_all(funs(min, max))

iris %>% summarise_if(is.numeric, mean)

iris %>% summarise_at(vars(Sepal.Length), mean)

mtcars %>% tally()

mtcars %>% count(cyl)

View(mtcars %>% add_tally())

View(mtcars %>% add_count(cyl))

first(x)

last(y)

nth(x,-2)

carriers <- group_by(flights, carrier)
summarise(carriers, n())

n_distinct(x, is.na = TRUE)

View(arrange(mtcars, cyl, disp))

View(arrange(mtcars, desc(disp)))

View(arrange_all(mtcars))

View(arrange_at(mtcars, 'wt'))

View(arrange_if(iris, is.numeric))

View(rename(iris, petal_length = Petal.Length))

rename_all(iris, SL, SW, PL, PW, Cate)

gather_iris <- gather(iris, key = flower_att, value = measurement, -Species)

View(unite_(mtcars, "vs_am", c("vs","am")))

df_sep <- data.frame(
  x = 1:3,
  y = c("a", "d,e,f", "g,h"),
  z = c("1", "2,3,4", "5,6"),
  stringsAsFactors = FALSE
)
separate_rows(df_sep, y, z, convert = TRUE)

View(expand(mtcars, vs, cyl))

View(expand(mtcars, nesting(vs, cyl)))

View(expand(mtcars, crossing(vs, cyl)))

df_comp <- tibble(
  group = c(1:2, 1),
  item_id = c(1:2, 2),
  item_name = c("a", "b", "b"),
  value1 = 1:3,
  value2 = 4:6
)
View(df_comp %>% complete(group, nesting(item_id, item_name), fill = list(value1 = 0)))


df_extract <- data.frame(x = c(NA, "a-b", "a-d", "b-c", "d-e"))
df_extract %>% extract(x, c("A", "B"), "([[:alnum:]]+)-([[:alnum:]]+)")

mtcars$model <- rownames(mtcars)
first <- mtcars[1:20, ]
second <- mtcars[10:32, ]

union(first, second)

union_all(first, second)

setequal(mtcars, mtcars[32:1, ])

iris %>%  nest(-Species)

df_sep %>% transform(y = strsplit(y, ",")) %>% unnest(y)

uncount(df_x, x4)

full_seq(m,1)

df_fill <- data.frame(Month = 1:12, Year = c(2000, rep(NA, 11)))
df_fill %>% fill(Year)

df_fill %>% drop_na()

pollution %>% spread(size, amount)

separate(storms, date, c("year", "month", "day"), sep = "-")

replace_na(x,5)

View(songs %>% left_join(artists, by = "name"))

View(songs %>% right_join(artists, by = "name"))

View(songs %>% inner_join(artists, by = "name"))

View(songs %>% full_join(artists, by = "name"))

View(songs %>% semi_join(artists, by = "name"))

View(songs %>% anti_join(artists, by = "name"))

df_x1 <- data.frame(x1 = c("A", "B", "C"), x2 = c(1,2,3))
df_x2 <- data.frame(x1 = c("B", "C", "D"), x2 = c(2,3,4))

View(bind_rows(df_x1, df_x2))

View(bind_cols(df_x1, df_x2))

View(combine(x,y))

View(union(df_x1, df_x2))

View(union_all(df_x1, df_x2))

setequal(df_x1, df_x2)

View(intersect(df_x1, df_x2))

View(setdiff(df_x1, df_x2))

plot1 <- mtcars %>% ggvis(~mpg, ~wt)
ggvisControlOutput("plot1")

explain(plot1)

mtcars %>% ggvis(~mpg, ~wt) %>% layer_points() %>% layer_smooths(span =  waggle(0.2, 1))

get_data(plot1)

show_spec(plot1)

prop("fill", ~cyl)

plot1 %>% set_options(width = 300, height = 200, padding = padding(10, 10, 10, 10))

mtcars %>% ggvis(~mpg, ~wt, size := left_right(1, 801, value = 51, step = 50))

mtcars %>% ggvis(~mpg, ~wt, opacity :=  up_down(0, 1, value = 0.9, step = 0.05))

plot1 %>% set_options(padding = padding(10, 10, 10, 10))

mtcars %>% ggvis(~mpg, ~wt) %>% layer_text(text := plot_width())
mtcars %>% ggvis(~mpg, ~wt) %>% layer_text(text := plot_height())

mtcars %>% ggvis(x = ~wt, y = ~mpg, fill = ~cyl) %>%
  layer_points() %>%
  add_axis("x", title = "Weight", orient = "top")

mtcars %>% ggvis(x = ~wt, y = ~mpg, fill = ~cyl) %>% layer_points() %>% hide_axis("x") %>% hide_axis("y")

mtcars %>% ggvis(x = ~wt, y = ~mpg, fill = ~cyl) %>% layer_points() %>% add_legend("fill", title = "Cylinders")

mtcars %>% ggvis(x = ~wt, y = ~mpg, fill = ~cyl) %>% layer_points() %>% hide_legend("fill")

mtcars %>% ggvis(x = ~wt, y = ~mpg, size.brush := 400) %>% layer_points() %>% handle_brush(function(items, page_loc, session, ...) { show_tooltip(session, page_loc$r + 5, page_loc$t, html = nrow(items))})

location <- function(location, ...) cat(location$x, "x", location$y, "\n") 
mtcars %>% ggvis(~mpg, ~wt) %>% layer_points() %>% handle_click(location)

mtcars %>% ggvis(~mpg, ~wt) %>% layer_points() %>% handle_hover(function(...) cat("over\n"), function(...) cat("off\n"))

mtcars %>% ggvis(~mpg, ~wt) %>% layer_points()

mtcars %>% ggvis(~mpg, ~wt) %>% layer_arcs(innerRadius=3,outerRadius=6, startAngle=0,endAngle=0.25 * pi, stroke:="white")

mtcars %>% ggvis(~mpg, ~wt) %>% layer_paths()

mtcars %>% ggvis(~mpg, ~wt) %>% layer_ribbons()

hec <- as.data.frame(xtabs(Freq ~ Hair + Eye, HairEyeColor))

hec %>% ggvis(~Hair, ~Eye, fill = ~Freq) %>% layer_rects(width = band(), height = band()) %>% scale_nominal("x", padding = 0, points = FALSE) %>% scale_nominal("y", padding = 0, points = FALSE)

mtcars %>% ggvis(~mpg, ~wt) %>% layer_text(text:=~mpg)

flights %>% ggvis(~dest) %>% layer_bars()

mtcars %>% ggvis(~wt, ~mpg, stroke = ~factor(cyl)) %>% layer_lines()

mtcars %>% ggvis(~factor(cyl), ~mpg) %>% layer_boxplots()

mtcars %>% ggvis(~mpg) %>% layer_densities()

mtcars %>% ggvis(~mpg) %>% layer_histograms()

mtcars %>% ggvis(~mpg) %>% layer_freqpolys(width = 2)

mtcars %>% ggvis(~wt, ~mpg) %>% layer_points() %>% layer_model_predictions(model = "lm", domain = c(0, 8))

mtcars %>% ggvis(~wt, ~mpg) %>% layer_points() %>% layer_smooths(span = 0.2)

mtcars %>% ggvis(~mpg, ~wt) %>% layer_guess()

NULL %>% ggvis(~mpg, ~wt) %>% add_data(mtcars) %>% layer_points()

mtcars %>% ggvis() %>% add_props(~wt, ~mpg) %>% layer_points()

mtcars %>% ggvis(x = ~wt, y = ~mpg, fill = ~cyl) %>% layer_points() %>% add_relative_scales()

mtcars %>% ggvis(~wt, ~mpg) %>% layer_smooths(se = input_checkbox(label = "Confidence interval"))

input_slider(0, 100, value = 50)

mtcars %>% ggvis(~wt, ~mpg, fill := input_text(label = "Point color", value = "red")) %>% layer_bars()

mtcars %>% ggvis(~wt, ~mpg, size :=  input_numeric(label = "Point size", value = 25)) %>% layer_points()

mtcars %>% ggvis(~wt, ~mpg) %>% layer_model_predictions(model = input_select(choices = c("Linear" = "lm", "LOESS" = "loess"), selected = "loess", label = "Model type"))

mtcars %>% ggvis(~wt, ~mpg) %>% layer_model_predictions(model = input_radiobuttons(choices = c("Linear" = "lm", "LOESS" = "loess"), selected = "loess", label = "Model type"))

mtcars %>% ggvis(x = ~wt, y = ~mpg) %>%
  layer_points(
    fill := input_checkboxgroup(
      choices = c("Red" = "r", "Green" = "g", "Blue" = "b"),
      label = "Point color components",
      map = function(val) {
        rgb(0.8 * "r" %in% val, 0.8 * "g" %in% val, 0.8 * "b" %in% val)
      }
    )
  )
mtcars %>% ggvis(~wt, ~mpg, fill = ~hp) %>% layer_points()%>% scale_numeric("x", domain = c(NA, 3), clamp = TRUE, nice = FALSE)

mtcars %>% ggvis(x = ~wt, y = ~mpg, opacity = ~factor(cyl)) %>%
  layer_points() %>%
  scale_ordinal("opacity", range = c(0.2, 1))

storms %>% ggvis(~date, ~storm) %>% layer_points() %>%  scale_datetime("x", nice = "year")

lb <- linked_brush(keys = 1:nrow(mtcars), "red")
mtcars %>%
  ggvis(~disp, ~mpg) %>%
  layer_points(size.brush := 400) %>%
  lb$input() %>%
  layer_points(fill := "red", data = reactive(mtcars[lb$selected(), ]))

sidebarBottomPage(sidebarBottomPanel(), mainTopPanel())

mtcars %>% ggvis(~wt, ~mpg) %>% layer_points() %>% group_by(cyl) %>% layer_paths()

mtcars %>% ggvis(~disp, ~mpg, stroke = ~factor(cyl)) %>% auto_group() %>% layer_paths()

mtcars %>% ggvis(singular(), ~mpg) %>% layer_points()

vector_type(x)

resolution(y, FALSE)

mtcars %>% compute_count(~cyl, ~wt)

mtcars %>% compute_tabulate(~factor(cyl))

mtcars %>% compute_count(~mpg) %>% compute_align(~x_)

mtcars %>% group_by(cyl) %>% compute_bin(~mpg, width = 10)

View(mtcars %>% cbind(count = 1) %>% compute_stack(~count, ~cyl))

mtcars %>% compute_density(~mpg, n = 5)

mtcars %>% group_by(cyl) %>% compute_boxplot(~mpg)

mtcars %>% compute_model_prediction(mpg ~ wt, n = 10, se = TRUE)

View(mtcars %>% compute_smooth(mpg ~ wt))
