# R 环境自检脚本
# 运行方式（Windows）：Rscript r_env_check.R

cat("=== R Environment Check ===\n")
cat("Time: ", format(Sys.time()), "\n", sep = "")
cat("R version: ", R.version.string, "\n", sep = "")
cat("Platform: ", R.version$platform, "\n", sep = "")
cat("Locale: ", paste(Sys.getlocale(), collapse = " | "), "\n", sep = "")
cat("Working dir: ", getwd(), "\n\n", sep = "")

cat("--- Basic computation ---\n")
x <- 1:10
cat("sum(1:10) = ", sum(x), "\n", sep = "")
cat("mean(1:10) = ", mean(x), "\n", sep = "")
cat("sd(1:10) = ", sd(x), "\n\n", sep = "")

cat("--- Data frame + model ---\n")
df <- data.frame(
  a = x,
  b = x^2,
  grp = rep(c("甲", "乙"), length.out = length(x)),
  stringsAsFactors = FALSE
)
print(head(df, 3))
fit <- lm(b ~ a, data = df)
cat("lm(b ~ a) R^2 = ", summary(fit)$r.squared, "\n\n", sep = "")

cat("--- File I/O (tempdir) ---\n")
# 验证文件读写权限与 UTF-8 内容
out_path <- file.path(tempdir(), "r_env_check_output.txt")
text <- c("中文测试：自然语言处理", "English test", paste("sum=", sum(x)))
writeLines(text, out_path, useBytes = TRUE)
back <- readLines(out_path, warn = FALSE)
cat("Wrote and read back ", length(back), " lines at:\n  ", out_path, "\n", sep = "")
cat("First line: ", back[1], "\n\n", sep = "")

cat("--- Optional: check recommended packages ---\n")
# 不强制安装；仅检测是否可用
pkgs <- c("stats", "utils", "methods", "graphics")
ok <- vapply(pkgs, requireNamespace, FUN.VALUE = logical(1), quietly = TRUE)
cat("Recommended namespaces available:\n")
print(ok)

cat("\n=== Done. If you see this, R is working. ===\n")
# --- 饼图绘制示例 ---
cat("\n--- Pie Chart Example ---\n")
pie_data <- c(30, 20, 25, 25)
pie_labels <- c("A", "B", "C", "D")
pie(pie_data, labels = pie_labels, main = "简单饼图示例", col = rainbow(length(pie_data)))
cat("饼图已绘制（如在交互式环境或RStudio可见图形窗口）。\n")

