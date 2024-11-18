Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 666719D13A4
	for <lists+linux-erofs@lfdr.de>; Mon, 18 Nov 2024 15:51:57 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XsVvb3RyJz3bZ4
	for <lists+linux-erofs@lfdr.de>; Tue, 19 Nov 2024 01:51:55 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=46.23.108.219
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1731941513;
	cv=none; b=P3DFven5QPEVETsM6LIlmFYMqGLg1l4xUE9IE2MPBcc+nqq3CT56H7NghSd7z39b0WH6/M5vKflK81Y5hSLmBUFpkpL5Ji9UyyiuOFQDp2qp1vWRPgAg/r81DBZt9cnhEsYSREj07uE6y2kNYv6Hk7XzLG1gjLVA659G5VEPtc4KOD/qzOLq7eQDBOrK+vigCT3A+rHrh0np2cg63OT1h+cjqnvYAeuys3LXyN66FpF8ukLGhjqo2m+25U3zZT/gmZCqxVBRnm1o5mqCtkeXpC8WnjPg6bXdNepSKv35vKO2i5uBbr3YSuPHVDMQZC/4QbdyiLd9dnVwtgObJN2Zig==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1731941513; c=relaxed/relaxed;
	bh=QEKffRNU9P/pEV4gWMII+BWZZPaRwacWCDpYqQwPgs4=;
	h=To:Subject:Message-ID:Date:From:MIME-Version:Content-Type; b=oTvZqffl1vjCJJXyyNF56DmX92/0Uu+eAakH+WqxiYFn7KYOHYnYkQbJqSTBqSUdNUyinIFozLX05Ej25fm0grfq2JesnYdtQgm4w0vaUY59eCRcZ4CwgcHNCRWjIMNcHhbLIqYAJcHV45snGrXTuu0CYz3Rs9cMG5fi7E71XNWveH0ukkhIyEVqV4s6kkt71s/OYHJ/c14UDIb7NlbTZsGmyIHXXD41fCQKwZkvCU5GsWrNTIQUvXgQjy6+aDsY4PlxeBDzZRlLuv2eHgcmCpx7Ryhv0X15AWRNM4gPli+vPW8A8q4l5VAVbU9IS77DF0xwq6PnoDI3/ebcfBRJHw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=jsdpg.com; dkim=pass (1024-bit key; unprotected) header.d=jsdpg.com header.i=@jsdpg.com header.a=rsa-sha1 header.s=mail header.b=O6sM8UIv; dkim-atps=neutral; spf=pass (client-ip=46.23.108.219; helo=zhimeike.com; envelope-from=fatbikeyx@sbzce.com; receiver=lists.ozlabs.org) smtp.mailfrom=sbzce.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=jsdpg.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=jsdpg.com header.i=@jsdpg.com header.a=rsa-sha1 header.s=mail header.b=O6sM8UIv;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=sbzce.com (client-ip=46.23.108.219; helo=zhimeike.com; envelope-from=fatbikeyx@sbzce.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 99 seconds by postgrey-1.37 at boromir; Tue, 19 Nov 2024 01:51:52 AEDT
Received: from zhimeike.com (zhimeike.com [46.23.108.219])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XsVvX1xVXz2yn1
	for <linux-erofs@lists.ozlabs.org>; Tue, 19 Nov 2024 01:51:52 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; s=mail; d=jsdpg.com;
 h=To:Subject:Message-ID:Date:From:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=P8iSxnoTCtadg/qh9Ex9Q2ptW0w=;
 b=O6sM8UIvY/CsaYpQxfI/Hz9qd1x8B89tbDhy5EqArX/B5WTurjC+CzGFOMFRcHJccKu69jmmIM+q
   hseLcCuz1XkK3kxvHHK1IbOGX/CqWfzch1RFLf2d5wNIcnQal6hQ4Luy+tLS/tC+orAUI+Qd3Wan
   BwVTgF8ZBN/Gwxxic4U=
To: linux-erofs@lists.ozlabs.org
Subject: new fat tire electric bike
Message-ID: <27cef0c33dfc5bd3dac0dcfc226069e1@cfamedical.com>
Date: Mon, 18 Nov 2024 15:47:15 +0100
From: "Jonathan Miller" <fatbikenl@jsdpg.com>
MIME-Version: 1.0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_IMAGE_RATIO_02,
	HTML_MESSAGE,MIME_HTML_ONLY,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
	URIBL_BLACK autolearn=disabled version=4.0.0
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org
X-BeenThere: linux-erofs@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Development of Linux EROFS file system <linux-erofs.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linux-erofs/>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Help: <mailto:linux-erofs-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=subscribe>
Reply-To: fatbike@jsdpg.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

<html>
<head>
</head>
<body>
Hi,<br /><br /> I hope this message finds you well.&nbsp;Are you ready to
take your cycling experience to the next level? Whether you're an avid
cyclist or someone looking to enjoy outdoor rides with ease, our 20 inch
Fat Tire Electric Bike offers the perfect blend of power, comfort, and
style for adults of all ages.<br /> <br /> Powerful and Efficient 500W
Brushless Motor<br /> At the heart of this e-bike is the 500W brushless
motor, delivering impressive power and a smooth, quiet ride. With this
motor, you can easily tackle various terrains - from smooth city streets to
rough trails. Whether you're commuting to work, running errands, or
enjoying a weekend adventure, our e-bike will make every journey faster,
smoother, and more enjoyable.<br /> <br /> Fast and Far-Ranging with a 48V
15Ah Battery<br /> <br /> The 48V 15Ah removable battery ensures that you
can ride longer distances with confidence. With a range of up to 60
kilometers on a single charge, you can rely on your e-bike for your daily
activities or even for a longer weekend ride. Plus, the battery is
removable, making it convenient to charge at home or at your office.<br />
<br /> You have up to 45 km/h (28 mph) of speed at your disposal. Feel the
thrill of the ride while still staying within a comfortable and safe speed
range, whether you're traveling through urban streets or countryside
roads.<br /><br />If you'd like to purchase our ebike, please kindly reply
to this email with your address, and we will arrange everything as soon as
possible.<br /><br /><img
src="https://v8fatbike.com/wp-content/uploads/2022/10/Fat-Tire-Bike-1-768x768.jpg"
width="768" height="768" /><br /><img
src="https://v8fatbike.com/wp-content/uploads/2022/10/V8-Fatbike-1-768x768.jpg"
width="768" height="768" /><br /><img
src="https://v8fatbike.com/wp-content/uploads/2022/10/OUXI-V8-Electric-Bike-2-768x768.jpg"
width="768" height="768" /><br /> <br /> Superior 20 inch Fat Tires for
Stability and Comfort<br /> <br /> One of the standout features of this
electric bike is the 20 inch fat tires, designed for superior stability and
control. These wider tires provide excellent traction on sand, snow, mud,
and even gravel, ensuring you can ride on virtually any surface with ease.
Whether you're cruising through a city park or heading off-road, these
tires offer the support you need for a smooth, comfortable ride.<br /> <br
/> 7-Speed Transmission for Easy Gear Shifting<br /> <br /> Our e-bike
comes equipped with a 7-speed transmission, giving you full control over
your riding experience. Whether you're climbing uphill or cruising down a
flat road, you can shift gears effortlessly for the most efficient ride.
This feature helps conserve battery life when riding on more challenging
terrains, and provides a comfortable ride when you want to relax and take
it easy.<br /> <br /> Durable, Stylish, and Eco-friendly Design<br /> <br
/> Not only is this electric bike packed with performance features, but it
also boasts a stylish and modern design. Its sturdy frame is built to last,
and the sleek appearance makes it a head-turner wherever you go. Plus, by
choosing an electric bike, you&rsquo;re making a positive impact on the
environment. Say goodbye to gas emissions and hello to a greener way of
getting around!<br /> <br /> Key Features of the 20 inch Fat Tire Electric
Bike:<br /> <br /> 500W Brushless Motor for powerful and quiet
performance<br /> 48V 15Ah Removable Battery for up to 60 km of range<br />
Top Speed of 45 km/h (28 mph) for an exciting ride<br /> 20 inch Fat Tires
for enhanced stability and off-road capability<br /> 7-Speed Transmission
for easy shifting and control<br /> <br /> Why Choose Our Electric Bike?<br
/> Comfort and Versatility: Perfect for commuting, weekend rides, or
off-road adventures.<br /> Performance You Can Count On: With the 500W
motor and high-quality battery, you can tackle almost any terrain with
ease.<br /> The bike's design ensures it&rsquo;s easy to maintain and keep
in top condition, so you can focus on riding, not repairs.<br /> <br /> If
you'd like to purchase our ebike, please kindly reply to this email with
your address, and we will arrange everything as soon as possible.<br />
Thank you for considering our 20 inch Fat Tire Electric Bike. <br /> <br />
Best regards,<br /> Jonathan Miller
</body>
</html>

