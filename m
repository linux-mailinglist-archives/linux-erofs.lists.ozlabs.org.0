Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 338EE9DB9FD
	for <lists+linux-erofs@lfdr.de>; Thu, 28 Nov 2024 15:57:50 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XzfYk4vgXz2ytQ
	for <lists+linux-erofs@lfdr.de>; Fri, 29 Nov 2024 01:57:46 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=181.214.99.90
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1732805865;
	cv=none; b=HBbf9+LFZesIcoVfzjyuISzcYMY2bmJghc4F4DEuC56VZ9BJcJaVXTGknhJZEQ8dDEqyZqNE5Gz2IEftxblBMlUGvawIK5SaL74tMNJ4Q7BCv/Bk2ZMljdlgYLzVyCIT5pW1YDw+dJ92kTlnp9qTaHnvR1Kr7/FMnSEb5JD1QMqMC0qrBD+bR0p/7DC4CdH35aEJjCTjx0VrDRKwKg47xjQiN/CMddF+63Y2l1opsbMhgSN98v+QmDuBV6o/LjSluU//7B4vWJPv6lJc6qS87LAWBPE4cUnyKQdpI5knRExTYvCaOt1bKmDkMtdNSyUYDRDJQ0Vi8bL1bQNb5NgKKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1732805865; c=relaxed/relaxed;
	bh=xjmrgh/CS+NSoXp3TIA4AgyVgtzMNUfPWY54qRs7SNQ=;
	h=To:Subject:Message-ID:Date:From:MIME-Version:Content-Type; b=gYbPUrksb4x/Mw0jhkZj3mTuxgRSawbx/h+Gg1tdJM7zKUURvOQbIZ9UVfWdeXdkLVOpuzacjJSjJfV5GHLkzhObpKPtotGKQ/w3PST663E4Gq9CQKkr9HMRmQpzYHJgRHUoC8KnKmsuAVhapF0ZtUcp4flUtIgSnxId1XGnCZPTszuDfUulYTtBPg4AQilgwBXd3KcEVkedrefh7ndA/Kd1Vib06AEyXq3ft1GlR9yGtedAlhV4o3L+Rv4yKseGLP4emP3o49qCLtr0gqJXCjOKtJ9lLekhM9R1esb5HgHpxAGaeLpq2kUQexYpL07x8ySx/+1UUvrIqH2MoffmDg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=cnkia.net; dkim=pass (1024-bit key; unprotected) header.d=cnkia.net header.i=@cnkia.net header.a=rsa-sha256 header.s=default header.b=jfyzASFy; dkim-atps=neutral; spf=pass (client-ip=181.214.99.90; helo=mta2.rev.xzk56.com; envelope-from=bikeforqa@cnkia.net; receiver=lists.ozlabs.org) smtp.mailfrom=cnkia.net
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=cnkia.net
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=cnkia.net header.i=@cnkia.net header.a=rsa-sha256 header.s=default header.b=jfyzASFy;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=cnkia.net (client-ip=181.214.99.90; helo=mta2.rev.xzk56.com; envelope-from=bikeforqa@cnkia.net; receiver=lists.ozlabs.org)
X-Greylist: delayed 309 seconds by postgrey-1.37 at boromir; Fri, 29 Nov 2024 01:57:44 AEDT
Received: from mta2.rev.xzk56.com (mta2.rev.xzk56.com [181.214.99.90])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XzfYh1NJZz2y3Z
	for <linux-erofs@lists.ozlabs.org>; Fri, 29 Nov 2024 01:57:44 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=default; d=cnkia.net;
 h=To:Subject:Message-ID:Date:From:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=xjmrgh/CS+NSoXp3TIA4AgyVgtzMNUfPWY54qRs7SNQ=;
 b=jfyzASFyoIbVQnZpLw5yciQDAjYmTkeE5tvXaKut9h7Wb8nLiUNYGpaaZWwpTJ4GwbxovWYQ6Wfo
   COLwcaW/n0rNRuj93FrPNHb3q0DtCni9ijqCm586whVnpXCTtnz6Kzd6HEFGBLcmZ+6cYf3nPXq8
   gdhFZtnma6fv+l4Rjtk=
To: linux-erofs@lists.ozlabs.org
Subject: =?UTF-8?B?YnVpbHQgZm9yIGFueSB0ZXJyYWluIOKAkyBleHBsb3JlIG91ciA1MDB3IGVsZWN0cmljIGJpa2Vz?=
Message-ID: <29bd1817891b5c00fb8cdac6ec592c5d@belmont-station.com>
Date: Thu, 28 Nov 2024 14:46:45 +0100
From: "David" <bikeforud@cnkia.net>
MIME-Version: 1.0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,HTML_IMAGE_RATIO_04,HTML_MESSAGE,
	MIME_HTML_ONLY,RCVD_IN_MSPIKE_BL,RCVD_IN_MSPIKE_L3,SPF_HELO_PASS,
	SPF_PASS autolearn=disabled version=4.0.0
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
Hi,<br /> <br /> How&rsquo;s it going? We are a leading e-bike
manufacturer. With our distribution center based in Germany, we are able to
offer rapid delivery within 3-7 days, bringing high-quality e-bikes
directly to your doorstep. Whether you're commuting, venturing off-road, or
simply enjoying a weekend ride, our e-bikes are designed to meet all your
demands with power, ease, and aesthetic.<br /> <br /> High-performance 500W
Motor with Fat Tires for Any Terrain<br /> Our electric bike comes equipped
with a 500W-capacity motor, delivering an impressive 66.6Nm of torque. This
provides you with plenty of force to ride at a top speed of 28 mph. Paired
with 26" fat anti-skidding fat tires, this bike is built to handle varied
terrain &ndash; from sandy beaches and snowy trails to gravel paths and
mountainous roads. Enjoy superior grip, control, and a smooth ride wherever
you go.<br /> <br /><img
src="https://img.joomcdn.net/100058473cc5b08b7b91a50b712c21d6fec990fd_1024_1024.jpeg"
width="800" height="800" /><br /><br /> With a 48 volt 15 amp-hour
removable lithium-ion battery, our electric bike ensures reliable power for
your explorations. You can expect a range of 30 to 35 miles on electric
mode, and up to 55 to 60 miles, depending on your weight, riding style, and
terrain. Charging time is about 6.5 hours, and the battery can be charged
either on the bike or off for your convenience.<br /> <br /> For more
information or to proceed with your purchase, please don't hesitate to get
in touch us. To calculate the shipping cost, we will need your shipping
address. We look forward to assisting you.<br /><br /><img
src="https://img.joomcdn.net/0fdd62d788455975de2e5793aaae5da0017cbf2e_1024_1024.jpeg"
width="800" height="800" /><br /> <br /> Comfort on Any Terrain<br /> Our
electric bike is designed with rider satisfaction in mind, even on rough,
uneven terrain. Equipped with lockable front suspension forks and a soft
saddle, it minimizes the impact of bumps, giving you a smooth and
controlled ride. The 7-speed gears allow for seamless shifting and
flexibility to adjust the bike to your desired level of comfort.
Additionally, the LCD display shows key information, including your speed,
battery level, mileage, and pedal assist mode, so you can stay informed
throughout your ride.<br /> <br /> Safety First<br /> Your well-being is
our priority. The bike is equipped with front headlamps, taillights, and
turn signals, ensuring you stay visible during low-light conditions. The
180 millimeter dual disc brakes provide trustworthy stopping power, giving
you full control in any situation, whether you're riding on busy streets or
rugged trails.<br /> <br /> Flexible Riding Modes<br /> Our electric bike
offers 5 different working modes and five pedal assist levels, giving you
the flexibility to customize your riding experience. You can choose
between:<br /> <br /> Pure Electric Mode<br /> Assisted Bicycle Mode<br />
Normal Bike Mode<br /> Cruise Mode<br /> Booster Mode<br /> Whether you
need assistance for long-distance rides, relaxation for a leisurely ride,
or extra help on hilly terrain, you can easily switch between modes to suit
your preferences.<br /> <br /> Convenient Shipping &amp; Assembly<br />
Thanks to our reliable Germany warehouse, we can ship your bike directly to
you within 3-7 days. When your bike arrives, it comes 85 percent assembled,
so you can easily finish the setup with just a few simple steps.
We&rsquo;ve also made assembly instructions available to ensure the process
is as smooth as possible.<br /> <br /> Quality and Support<br /> We are
committed to providing the best experience for our customers. Our bikes
support riders from 5.3ft to 6.2ft tall, with a maximum load of 330lbs.
Plus, we offer a 1-year warranty and lifetime technical support. Should you
have any questions or need assistance, our support team is always ready to
help and will respond within the next 24 hours.<br /> <br /> For more
information or to proceed with your purchase, please don't hesitate to
message us. To calculate the shipping cost, we will need your shipping
address. We look forward to assisting you.<br /> <br /> Best regards,<br />
<br /> David Williams<br /> The E-bike Manufacture<br /> <br /> <br /> <br
/> <br /> <br /> <br /> <br /> <br /> <br /> <br /> <br /> <br /> <br />
<br /> <br /> <br /> <br /> <br /> <br /> Send address to remove<br /> <br
/><br />
</body>
</html>

