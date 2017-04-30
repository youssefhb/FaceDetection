package ma.semlalia.crawler;

import java.awt.image.BufferedImage;
import java.awt.image.Raster;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.io.UnsupportedEncodingException;
import java.io.Writer;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLDecoder;
import java.util.List;
import java.util.Scanner;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.imageio.ImageIO;

import org.openqa.selenium.By;
import org.openqa.selenium.JavascriptExecutor;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;

public class ImageCrawler {
	public static void main(String[] args) throws InterruptedException, UnsupportedEncodingException {

		System.setProperty("webdriver.chrome.driver", "./chromedriver");

		// Get file from resources folder
		ClassLoader classLoader = ImageCrawler.class.getClassLoader();
		File file = new File(classLoader.getResource("negativeImages.txt").getFile());

		try (Scanner scanner = new Scanner(file)) {

			while (scanner.hasNextLine()) {
				String line = scanner.nextLine();
				getQueryUrls(line);
			}

			scanner.close();

		} catch (IOException e) {
			e.printStackTrace();
		}

	}

	private static void getQueryUrls(String query) throws InterruptedException, IOException {

		String url;
		BufferedImage image = null;

		WebDriver driver = new ChromeDriver();
		// And now use this to visit Google
		driver.get(
				"https://www.google.fr/search?q=google+images&espv=2&biw=1920&bih=911&site=webhp&source=lnms&tbm=isch&sa=X&ved=0ahUKEwjPruKBme3JAhXKuhQKHfn-A4QQ_AUIBigB#tbs=ic:color,isz:l&tbm=isch&q="
						+ query);

		JavascriptExecutor jse = (JavascriptExecutor) driver;
		jse.executeScript("window.scrollBy(0,100000)", "");

		Thread.sleep(5000);

		List<WebElement> images = driver.findElements(By.className("rg_l"));

		String pattern = "(imgurl=)(.*)(&imgrefurl)";
		Pattern r = Pattern.compile(pattern);

		int count = 1;
		try (Writer writer = new BufferedWriter(new OutputStreamWriter(new FileOutputStream("results.txt"), "utf-8"))) {

			for (WebElement img : images) {

				url = img.getAttribute("href");
				url = URLDecoder.decode(url, "UTF-8");

				Matcher m = r.matcher(url);

				if (m.find()) {

					String urlStr = m.group(2);
					URL imgUrl;
					
					if(urlStr.contains(".jpg")){
						urlStr = urlStr.substring(0,urlStr.indexOf(".jpg")+4);
					}
					
					imgUrl = new URL(urlStr);
					

					writer.write(urlStr+"\n");
					System.out.println(urlStr);

					try {
						image = ImageIO.read(imgUrl);
						
						if (image != null) {
							ImageIO.write(image, "jpg", new File("images/" + query + "_" + count + ".jpg"));
						}

					} catch (Exception e) {
						continue;
					}
					
					count++;
					System.out.println("Number of image downloaded = "+count);

				} else {
					System.out.println("NO MATCH");
				}

			}

			System.out.println("Total images retrieved = " + images.size());
			driver.close();
			driver.quit();
			writer.close();
		}
	}
}