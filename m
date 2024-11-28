Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id B0A519DB8C6
	for <lists+linux-erofs@lfdr.de>; Thu, 28 Nov 2024 14:32:33 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XzcgD0346z2ypV
	for <lists+linux-erofs@lfdr.de>; Fri, 29 Nov 2024 00:32:24 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=208.116.56.108
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1732800742;
	cv=none; b=nzbny4+4vQcBGG2MzJcnjkgfli7tOCe+4/hA8Ml2BYqgr/Iyuy0IP9llGUpuXlVrGKw0ufLdOGXhB/VKjCqLzMLa2IRl3MRVLWEYdtF25pqpZrxBQt3kb6vQkgXgkS9v6T0QbdD8uKxNKJ9u8sZG/7v10V2rzkzUgqtILHhu8aOwrcrwRuicxm2eVrNJvUKNDSPKyMd2ll0ttvehRyNu7UjQTU+8xLcyL8OoJtt1S3F+mu1MCINpG75gs8SqKcpt+RF4u39M0Fn4qhrAPMSCx9kDFK5uHBxDplyU0+sC2bu/gn80doi++NMfV1wuba4n5Iood9SUZq0SCg9AMnAC8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1732800742; c=relaxed/relaxed;
	bh=wLB/m2VbqS9Tf1pRsBGW5zmU9WoOtUdRnoU2qkDZorc=;
	h=To:Subject:Message-ID:Date:From:MIME-Version:Content-Type; b=IsZsZGrmj8FL2o5WeGGSC180BgM7BVThK3Y6jM2htoSLD4G0hOC02aBW3Z+uvscvlK1WQU96t3NZ+xjkAXMuSje8JisVazeO7nK1QSNjiyA7FuXL4VWtOkmXZI+E1QepFGR6D56gmTKCDt8FxGyLQUTpdjlqiH5YrBAIw43pFMnl7HnqebjMl0BpEPS9EtNbb2ZSSVztV1/JxfGr/jTJuN05TP9L4wW4FofDSETkTlLmgUnmspZOoJB4Ja365pCIJEcQ+KhfYuEtLCtIaHJQ01JmdvGwynNSTXnkCx/zWx860YN6VdDxUBjULGXa9RlrX2ZH2rhsbvDtcCFNRcSKvw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=cnkia.net; dkim=pass (1024-bit key; unprotected) header.d=cnkia.net header.i=@cnkia.net header.a=rsa-sha256 header.s=default header.b=Alt6p3FJ; dkim-atps=neutral; spf=pass (client-ip=208.116.56.108; helo=mta2.rev.kanquanqiu.com; envelope-from=bikeforbl@cnkia.net; receiver=lists.ozlabs.org) smtp.mailfrom=cnkia.net
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=cnkia.net
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=cnkia.net header.i=@cnkia.net header.a=rsa-sha256 header.s=default header.b=Alt6p3FJ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=cnkia.net (client-ip=208.116.56.108; helo=mta2.rev.kanquanqiu.com; envelope-from=bikeforbl@cnkia.net; receiver=lists.ozlabs.org)
X-Greylist: delayed 60 seconds by postgrey-1.37 at boromir; Fri, 29 Nov 2024 00:32:20 AEDT
Received: from mta2.rev.kanquanqiu.com (mta2.rev.kanquanqiu.com [208.116.56.108])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Xzcg85Vc2z2xdZ
	for <linux-erofs@lists.ozlabs.org>; Fri, 29 Nov 2024 00:32:20 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=default; d=cnkia.net;
 h=To:Subject:Message-ID:Date:From:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=wLB/m2VbqS9Tf1pRsBGW5zmU9WoOtUdRnoU2qkDZorc=;
 b=Alt6p3FJ9K/DvouQATMzzTP/TJZ12+txLdclnY5fubWrf8q9yb4K4JvAam1MDI6KxnrWfS2fWZgL
   fyrFx2sQOiJFJ5JmSYrtDFVu9ssgfSW5FvBMoSDi8uHn5CfhjQr9SRpICn5bndwyWhMlNJjudxUy
   sN+XuEaE9UTaLyAnrzs=
To: linux-erofs@lists.ozlabs.org
Subject: your e-bike purchase comes with a 1-year warranty and lifetime support
Message-ID: <8bded626428ad2793a81a9b616686952@belmont-station.com>
Date: Thu, 28 Nov 2024 14:30:10 +0100
From: "David" <bikeforff@cnkia.net>
MIME-Version: 1.0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,HTML_IMAGE_RATIO_04,HTML_MESSAGE,
	MIME_HTML_ONLY,RCVD_IN_MSPIKE_BL,RCVD_IN_MSPIKE_L5,
	RCVD_IN_VALIDITY_RPBL,SPF_PASS,T_SPF_HELO_PERMERROR autolearn=disabled
	version=4.0.0
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
Reply-To: ebikeexpert@cnkia.net
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

<html>
<head>
</head>
<body>
Hi,<br /> <br /> How&rsquo;s it going? We are a leading ebike manufacturer.
With our distribution center based in Germany, we are able to offer fast
delivery within 3-7 days, bringing high-quality electric bicycles directly
to your doorstep. Whether you're commuting, touring off-road, or simply
enjoying a weekend ride, our electric bicycles are designed to meet all
your demands with performance, ease, and design.<br /> <br /> Robust 500W
Motor with Fat Tires for Any Terrain<br /> Our electric bike comes equipped
with a 500W motor, delivering an impressive 66.6 newton-meters of torque.
This provides you with plenty of force to ride at a top speed of 45
kilometers per hour. Paired with 26&rdquo; x 4.0 anti-skidding fat tires,
this bike is built to handle any terrain &ndash; from sandy beaches and
snowy trails to gravel paths and mountainous roads. Enjoy superior hold,
stability, and a seamless ride wherever you go.<br /> <br /><img
src="https://img.joomcdn.net/100058473cc5b08b7b91a50b712c21d6fec990fd_1024_1024.jpeg"
width="800" height="800" /><br /><br /> With a 48V 15 amp-hour removable
lithium-ion battery, our electric bike ensures long-lasting power for your
explorations. You can expect a range of 30 to 35 miles on electric mode,
and up to 55-60 miles, depending on your weight, riding style, and terrain.
Charging time is about 6.5 hours, and the battery can be charged on the
bike or separately for your convenience.<br /> <br /> For more information
or to proceed with your purchase, please don't hesitate to get in touch us.
To calculate the shipping cost, we will need your destination address. We
look forward to assisting you.<br /><br /><img
src="https://img.joomcdn.net/0fdd62d788455975de2e5793aaae5da0017cbf2e_1024_1024.jpeg"
width="800" height="800" /><br /> <br /> Comfort on Any Terrain<br /> Our
electric bike is designed with comfort in mind, even on rough, uneven
terrain. Equipped with lockable front suspension forks and a soft saddle,
it minimizes the impact of bumps, giving you a stable and balanced ride.
The 7-speed gears allow for seamless shifting and flexibility to adjust the
bike to your desired level of comfort. Additionally, the LCD display shows
key information, including your speed, battery level, mileage, and pedal
assist mode, so you can stay informed throughout your ride.<br /> <br />
Safety First<br /> Your safety is our priority. The bike is equipped with
illuminated headlights, taillights, and turn signals, ensuring you stay
visible during low-light conditions. The large 180mm dual disc brakes
provide trustworthy stopping power, giving you full control in any
situation, whether you're riding on busy streets or rugged trails.<br />
<br /> Flexible Riding Modes<br /> Our electric bike offers 5 different
working modes and 5 pedal assist levels, giving you the flexibility to
customize your riding experience. You can choose between:<br /> <br /> Pure
Electric Mode<br /> Assisted Bicycle Mode<br /> Normal Bike Mode<br />
Cruise Mode<br /> Booster Mode<br /> Whether you need assistance for
long-distance rides, casual cruising for a leisurely ride, or extra help on
inclines, you can easily switch between modes to suit your style.<br /> <br
/> Convenient Shipping &amp; Assembly<br /> Thanks to our reliable Germany
warehouse, we can ship your bike directly to you within 3-7 days. When your
bike arrives, it comes mostly pre-assembled, so you can easily finish the
setup with just a few simple steps. We&rsquo;ve also made assembly
instructions available to ensure the process is as simple as possible.<br
/> <br /> Quality and Support<br /> We are committed to providing the best
experience for our customers. Our bikes support riders from 5.3 to 6.2
feet, with a maximum load of 330lbs. Plus, we offer a 365-day warranty and
lifetime technical support. Should you have any questions or need
assistance, our support team is always ready to help and will respond
within the next 24 hours.<br /> <br /> For more information or to proceed
with your purchase, please don't hesitate to message us. To calculate the
shipping cost, we will need your shipping address. We look forward to
assisting you.<br /> <br /> Best regards,<br /> <br /> David Williams<br />
The E-bike Manufacture<br /> <br /> <br /> <br /> <br /> <br /> <br /> <br
/> <br /> <br /> <br /> <br /> <br /> <br /> <br /> <br /> <br /> <br />
<br /> <br /> Send address to remove<br /> <br /><br />
</body>
</html>

