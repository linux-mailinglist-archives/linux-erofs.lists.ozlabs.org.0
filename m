Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 86E28A0948F
	for <lists+linux-erofs@lfdr.de>; Fri, 10 Jan 2025 16:02:48 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YV4dd0549z3cYw
	for <lists+linux-erofs@lfdr.de>; Sat, 11 Jan 2025 02:02:45 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=141.195.119.58
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1736521362;
	cv=none; b=Al90SfvHLzk7KiF+hoIRqVWHs3V3RlwI0elggz9QCjYR9PPljUfYP2V/3Lltm4lqnklUdxt4TCuUQIU9iZHMWlMqXYAD+1848QOkRL7HSSXy4OtdPsenb/8H7Md7r35zRovtKaP3yPRpN6euVhWKgAH6qR6GiOv8I9quU7nbs1fBd3CLWVJoot05o3IQfnx5Saklxi83pyXNjBWveiE2UohiP1K1fyK0CETUT4uGqAAyeb6JFigxXYUyTv+GJfx2BwNBjZhcV06rz8jicnSEbn7pWiZhk7GO/1mIx4ICJ40NO+h2gYKZ+M2NOOw90F1L5qoHQ3AkKw5iFGIizJwOQg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1736521362; c=relaxed/relaxed;
	bh=NOOfR3dtk0Ioh4eeKdhpqG0twcvl9W315DrUz3jEDPs=;
	h=To:Subject:Message-ID:Date:From:MIME-Version:Content-Type; b=UgpIwWtwbeZqPAtZgnRhrWglcmBNSGryXKU0FXwIjnNr8eBB17Iu3HvFJfgruOUu29MsbMJyDSpiaZ4W5Kb9UthDLok5L8S7O0wkuV6Ed+sZpuoMx65d89G0hIGeKbfyogDZKtakn+cPt2SXFBnHEVSaUmWpEMNqyY1d/Jr7HngG6c02AVYkEON0LzdNYEwd0nlooXimyAh8Ea5z/v9ien3xv0yHFf+60sabEEWcyRVo4FwcaO8Zb4KoopehbWN2f+rtLtFk8qFNCRmB/YUXJle0zuY5+tTRLP1SIUXuYtItCwFF8QSqHsJ5Wy+tUIMyuzCeDknfQeldyRD028oX1Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=cnhdw.com; dkim=pass (1024-bit key; unprotected) header.d=cnhdw.com header.i=@cnhdw.com header.a=rsa-sha256 header.s=default header.b=ElqmoOcY; dkim-atps=neutral; spf=pass (client-ip=141.195.119.58; helo=mail14.era.bean.tjxinshunda.com; envelope-from=ridebikelr@cnhdw.com; receiver=lists.ozlabs.org) smtp.mailfrom=cnhdw.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=cnhdw.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=cnhdw.com header.i=@cnhdw.com header.a=rsa-sha256 header.s=default header.b=ElqmoOcY;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=cnhdw.com (client-ip=141.195.119.58; helo=mail14.era.bean.tjxinshunda.com; envelope-from=ridebikelr@cnhdw.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 1817 seconds by postgrey-1.37 at boromir; Sat, 11 Jan 2025 02:02:33 AEDT
Received: from mail14.era.bean.tjxinshunda.com (mail14.era.bean.tjxinshunda.com [141.195.119.58])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YV4dP5wVFz3cY0
	for <linux-erofs@lists.ozlabs.org>; Sat, 11 Jan 2025 02:02:33 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=default; d=cnhdw.com;
 h=To:Subject:Message-ID:Date:From:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=NOOfR3dtk0Ioh4eeKdhpqG0twcvl9W315DrUz3jEDPs=;
 b=ElqmoOcY0keORGa3HROAdgrzymwdUTezlh37Kn/3kJmOOj9p9Xw3y0wf9n2ydVlVvP2Fdt+V6J4A
   a0L6h/W4Pnmc9o9fIfW009XPUQDaJD/Xzt52pjNPmjngbjRb9tGNt5SUhgfz4VxwmSe1zbBhCmHh
   Xtrg0lPbiShMMKg8Otc=
To: linux-erofs@lists.ozlabs.org
Subject: strength and honor on every mile
Message-ID: <2f0d2543b2916d0c3cd25d26996271e0@cnhdw.com>
Date: Fri, 10 Jan 2025 14:48:10 +0100
From: "E-Bike Wholesale Center" <ridebikeff@cnhdw.com>
MIME-Version: 1.0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=4.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,HTML_IMAGE_RATIO_02,HTML_MESSAGE,
	MIME_HTML_ONLY,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLACK,
	URIBL_DBL_SPAM autolearn=disabled version=4.0.0
X-Spam-Level: ****
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
Reply-To: sales@xiaoqinz.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

<html>
<head>
</head>
<body>
Hello there,<br /> <br /> I hope you're doing well! We are a leading
manufacturer in the e-bike industry, with a distribution center located in
Germany. We guarantee efficient shipping directly to your doorstep within
3-7 days. Our top-quality e-bikes are perfect for daily commutes, touring
off the beaten path, or simply enjoying a relaxed ride. Designed to meet
your needs, our bikes offer a perfect blend of power, style, and
fashion.<br /> <br /> Equipped with a Powerful 500W Motor and Versatile Fat
Tires<br /> <br /> Our e-bikes are powered by a 500W motor, delivering up
to 66.6 N-m of torque, enabling a top speed of 28 mph. Whether you&rsquo;re
riding on sandy beaches, snowy trails, or rugged mountains, the 26-inch fat
anti-skid tires ensure excellent control on any surface, making your
journey effortless. Enjoy a smooth ride, no matter where you go.<br /> <br
/> Long-Lasting Power with a 48V 15-Ah Battery<br /> <br /> The e-bike
comes with a 48V 15 amp-hour removable lithium-ion battery that offers
reliable power. It can cover up to 30 to 35 miles on electric mode on a
single charge and up to 55-60 miles. Charging takes about 6.5 hours, and
you have the flexibility to charge it on the bike or separately, making it
highly convenient.<br /> <br /> For More Information<br /> <br /> Please
message us for more details. To calculate accurate shipping costs, we would
need your shipping address. We're excited to assist you.<br /><br /><img
src="https://epcyclingbike.com/cdn/shop/products/Hf935e9f192f242b881375d5af6375b39H_1024x1024.jpg"
width="1000" height="1000" /><br /> <br /> Riding Comfortably Over Any
Terrain<br /> <br /> Our e-bikes are designed with your comfort in mind,
offering convenience on all types of terrain. The lockable front suspension
fork and comfortable saddle absorb shocks, ensuring a smooth ride, even on
rough terrain. The 7-speed gear system allows seamless shifting, while the
LCD display provides essential information like speed, battery status,
mileage, and pedal assist mode.<br /> <br /> Prioritizing Your Safety<br />
<br /> Your security is our priority. Our bikes are equipped with tail
lights to enhance visibility during night rides. The 180 mm dual disc
brakes ensure consistent stopping power, giving you complete control even
in challenging conditions.<br /> <br /><img
src="https://epcyclingbike.com/cdn/shop/products/Hb45338662f6f4b7ba02da68c7e5ca0eft_1024x1024.jpg"
width="1000" height="1000" /><br /><br /> Versatile Modes for Flexible
Rides<br /> <br /> Choose from 5 riding modes and five pedal assist levels
to match your preferences:<br /> <br /> Pure Electric Mode<br /> Assisted
Bicycle Mode<br /> Regular Bike Mode<br /> Cruise Mode<br /> Booster
Mode<br /> Whether you need assistance for longer distances, relaxation for
the weekend, or help with steep hills, easily switch between modes to suit
your desires.<br /> <br /><img
src="https://epcyclingbike.com/cdn/shop/products/Hedbb2b0cefe24e4bb1edadffadfe4119B_1024x1024.jpg"
width="1024" height="1024" /><br /> <img
src="https://epcyclingbike.com/cdn/shop/products/Hed8230fff9ec47b78cfd0c4bb90c46d6x_1024x1024.jpg"
width="1024" height="1024" /><br /><img
src="https://epcyclingbike.com/cdn/shop/products/H4e486ca5ecfa42eaac0902859c7992388_1024x1024.jpg"
width="1024" height="1024" /><br /><br />Seamless shipping and Assembly<br
/> <br /> Our well-organized German warehouse ensures shipping to your door
in just 3-7 days. The bike arrives 85percent ready to use, so setting it up
is simple with a few steps. Our detailed setup instructions make the
process easy.<br /> <br /> Warranty and Support<br /> <br /> Designed for
riders between from 5.3ft to 6.2ft tall and capable of supporting weights
up to 150 kg, our bikes come with a 365-day warranty, along with lifetime
technical support. Our friendly support team is available to assist you
within 24 hours.<br /> <br /> For any additional questions or to reach us,
please provide your address.<br /> <br /> Best regards,<br /> <br /> Danny
Martin<br /> <br /> Your Electric Bike Partner<br />
</body>
</html>

