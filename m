Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1232DA091E5
	for <lists+linux-erofs@lfdr.de>; Fri, 10 Jan 2025 14:28:10 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YV2XR6bm2z3cXC
	for <lists+linux-erofs@lfdr.de>; Sat, 11 Jan 2025 00:28:07 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=141.195.119.58
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1736515685;
	cv=none; b=M2IxcimSoVfSrPZoFIIsmgkolSNEW89ovqvwPbwzKichWykgTEs0ZRNaKqlpApEe2jCed1GyFKJwYvZgocIlYozHc2h4I91nGLhCWiudkC4Ex+Ty8Mwk4+3PHwYqTylidf2+UTum99kCj83NVPC+18w1maiXB6Grt73JzZxmTesv07cG25ETsksk1/Nig/JEdlN+jwmrDD2Rwohw9nHQgpzmzFanxsx75JQ7MtV2V4OMq4QTZtPQv1sa+lKR4087DrJUGLY9EDOO2H0v8U/ZG+Hk9SgyXeflabQW4LqEIQMZ4YosI4YA3Q4JFU+Xiv4XTkvr5Khm3566ZMTTuuKCLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1736515685; c=relaxed/relaxed;
	bh=ha4kBPnXx4DxFCq5HYDTIBtt9WF+xz1udsJHHYUjejA=;
	h=To:Subject:Message-ID:Date:From:MIME-Version:Content-Type; b=hawXkwCcBDEXanQm3uzhGCkMrXcnX8vKv3gfjzP/cC9j8GhWm6Knb9FSRT0UvHcV3nf7UVSiakErmXePjkRYonnkDA875FzmamtyWePF2ksuEgaUm/+EE4BGmXCTSooIaCQrrI8u3frLc44tkjE88fJyNRUKJbMGna6yNk1TOVmNylwH9IWtZ0c5WmkOsr3FHHrxqx7bebLJxRbbAPDabVA/fTrxJAgPV++mChqqtZOB2Yd9hELyowwj7VkJRoePvV0kYzIKUo1dZqR8Xb5xXMR0WrMM3gtuUV/WAOj4eZ78o9pOYRXIVQ859wwMsgmz+XrrAiDI9KCk3/Co4XY8Eg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=cnhdw.com; dkim=pass (1024-bit key; unprotected) header.d=cnhdw.com header.i=@cnhdw.com header.a=rsa-sha256 header.s=default header.b=hcorYv+3; dkim-atps=neutral; spf=pass (client-ip=141.195.119.58; helo=mail14.era.bean.tjxinshunda.com; envelope-from=ridebikeef@cnhdw.com; receiver=lists.ozlabs.org) smtp.mailfrom=cnhdw.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=cnhdw.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=cnhdw.com header.i=@cnhdw.com header.a=rsa-sha256 header.s=default header.b=hcorYv+3;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=cnhdw.com (client-ip=141.195.119.58; helo=mail14.era.bean.tjxinshunda.com; envelope-from=ridebikeef@cnhdw.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 121 seconds by postgrey-1.37 at boromir; Sat, 11 Jan 2025 00:28:04 AEDT
Received: from mail14.era.bean.tjxinshunda.com (mail14.era.bean.tjxinshunda.com [141.195.119.58])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YV2XN63JSz2ydQ
	for <linux-erofs@lists.ozlabs.org>; Sat, 11 Jan 2025 00:28:04 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=default; d=cnhdw.com;
 h=To:Subject:Message-ID:Date:From:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=ha4kBPnXx4DxFCq5HYDTIBtt9WF+xz1udsJHHYUjejA=;
 b=hcorYv+3jZYzMBO3H95673pkDZSeYJckphRqxUPFyQqUkK4O9TM6wDQ4eenNJDO4o33CuRELFJ0N
   5RpKyNdFQJ0kU2ZIjx82Vyb4LTU5K278AyS0xCnUU7LsP99v6UGahHXcysnQAUWwNGghwqoZE9Ij
   xtKQV3VAkKXFV9Kmz2Q=
To: linux-erofs@lists.ozlabs.org
Subject: strength and honor in every turn
Message-ID: <372858788038c81685c787767df2df33@cnhdw.com>
Date: Fri, 10 Jan 2025 13:54:08 +0100
From: "E-Bike Wholesale Center" <ridebikeoi@cnhdw.com>
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
manufacturer in the e-bike industry, with a storage facility located in
Germany. We guarantee quick shipping directly to your doorstep within 3-7
days. Our top-quality e-bikes are perfect for daily commutes, trekking off
the beaten path, or simply enjoying a relaxed ride. Designed to meet your
requirements, our bikes offer a perfect blend of strength, design, and
convenience.<br /> <br /> Equipped with a Strong 500W Motor and Versatile
Fat Tires<br /> <br /> Our e-bikes are powered by a 500W motor, delivering
up to 66.6Nm of torque, enabling a top speed of 28 miles per hour. Whether
you&rsquo;re riding on sandy beaches, snowy trails, or rugged mountains,
the 26-inch fat anti-skid tires ensure excellent control on any surface,
making your journey effortless. Enjoy a smooth ride, no matter where you
go.<br /> <br /> Long-Lasting Power with a 48V 15-Ah Battery<br /> <br />
The e-bike comes with a 48V 15 amp-hour removable lithium-ion battery that
offers extended power. It can cover up to 30-35 miles on a single charge
and up to 55 to 60 miles. Charging takes about 6 hours 30 minutes, and you
have the flexibility to charge it on or off the bike, making it highly
convenient.<br /> <br /> For More Information<br /> <br /> Please message
us for more details. To calculate accurate shipping costs, we would need
your shipping address. We're excited to assist you.<br /><br /><img
src="https://epcyclingbike.com/cdn/shop/products/Hf935e9f192f242b881375d5af6375b39H_1024x1024.jpg"
width="1000" height="1000" /><br /> <br /> Riding Comfortably Over Any
Terrain<br /> <br /> Our e-bikes are designed with your comfort in mind,
offering comfort on all types of terrain. The lockable front suspension
fork and comfortable saddle absorb shocks, ensuring a stable ride, even on
rough terrain. The 7-speed gear system allows seamless shifting, while the
LCD display provides essential information like speed, battery status,
mileage, and pedal assist mode.<br /> <br /> Prioritizing Your Safety<br />
<br /> Your safety is our priority. Our bikes are equipped with turn
signals to enhance visibility during low-light conditions. The
180-millimeter dual disc brakes ensure trustworthy stopping power, giving
you complete control even in challenging conditions.<br /> <br /><img
src="https://epcyclingbike.com/cdn/shop/products/Hb45338662f6f4b7ba02da68c7e5ca0eft_1024x1024.jpg"
width="1000" height="1000" /><br /><br /> Versatile Modes for Flexible
Rides<br /> <br /> Choose from 5 riding modes and five pedal assist levels
to match your preferences:<br /> <br /> Pure Electric Mode<br /> Assisted
Bicycle Mode<br /> Regular Bike Mode<br /> Cruise Mode<br /> Booster
Mode<br /> Whether you need power for longer distances, ease for the
weekend, or help with hilly slopes, easily switch between modes to suit
your preferences.<br /> <br /><img
src="https://epcyclingbike.com/cdn/shop/products/Hedbb2b0cefe24e4bb1edadffadfe4119B_1024x1024.jpg"
width="1024" height="1024" /><br /> <img
src="https://epcyclingbike.com/cdn/shop/products/Hed8230fff9ec47b78cfd0c4bb90c46d6x_1024x1024.jpg"
width="1024" height="1024" /><br /><img
src="https://epcyclingbike.com/cdn/shop/products/H4e486ca5ecfa42eaac0902859c7992388_1024x1024.jpg"
width="1024" height="1024" /><br /><br />Seamless shipping and Assembly<br
/> <br /> Our reliable German warehouse ensures shipping to your door in
just 3-7 days. The bike arrives 85percent pre-built, so setting it up is
simple with a few steps. Our detailed assembly videos make the process
easy.<br /> <br /> Warranty and Support<br /> <br /> Designed for riders
between 5.3ft-6.2ft and capable of supporting weights up to 330 pounds, our
bikes come with a 1-year warranty, along with lifetime technical support.
Our friendly customer service is available to assist you within one day.<br
/> <br /> For any additional questions or to reach us, please provide your
address.<br /> <br /> Best regards,<br /> <br /> Danny Martin<br /> <br />
Your Electric Bike Partner<br />
</body>
</html>

