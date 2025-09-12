Return-Path: <linux-erofs+bounces-1021-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77D8EB541DE
	for <lists+linux-erofs@lfdr.de>; Fri, 12 Sep 2025 07:14:02 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cNMzD0wXcz3cc0;
	Fri, 12 Sep 2025 15:14:00 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=85.158.109.167
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1757654040;
	cv=none; b=Ukve7pgW4uwp/mkRe0UUK2P/HYggwAnMjg3fW/SGoOWSc7M2PFcvKbJ4uxCJsA7W+aXEUJP7AFp/Vo+8sS0mJQTxZ+u+6Z2NeHwfK3au8s+g4V4tgUxf1Rtq1dIeQbvfB2BjWrwLtFyuA/6HSLrPNhybt1Ax33B6mPIaQVou+ADjdW7T81afUWyeLli0gVa1zLN7CkyRdzWCH5q5g9KSdncoHfI+WkdTRH91eGBBiJ2KR8cCYIj1LTCmj5L/XQJiBfb3tQlze6/p82dIxewZbrEtDBwKMiwD0pm1ccPtwMfCCei5PsbLPAz8cpHFsHqOa5ss7zdQnsD5xGpbJ7z2RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1757654040; c=relaxed/relaxed;
	bh=GlrqsNjQhGLK++FnapspIqpTrDX88j9zSp6vWIc8Flo=;
	h=To:Subject:Message-ID:Date:From:MIME-Version:Content-Type; b=oolF7qUjc9kzvwFZjddminCjXLFDt2nNkpxz81mXNNrzU7fIXQtjrV7aYiCe4v6+tzp4LcOidLplPv4fgsMY8GEBno7kb5hxYtFjaaWVNCoLsRJEN1jL7felfB/z6jtWFcE1piVbgbJcYtu37cgoS0zioeuXMoBSFV9g5SHgfienZ0een3V3OdMIwtlgL//9gMjYWtdBMNehkgZ7dFqqM7nPjH19Xw6vzJOPR+O3MLJzj2oC0U+5pF4xYLAxzvL2d7JZ6YbkAVQ/f4cctnqIm3n4CF3E/jTEJmTe2nybvCqWiSdOTdbe4gRZ95FdQV2aFrxaTFO7uGpwZrAw5+Rz9A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=csxkg.net; dkim=pass (4096-bit key; unprotected) header.d=csxkg.net header.i=@csxkg.net header.a=rsa-sha256 header.s=default header.b=UgI3Yj1I; dkim-atps=neutral; spf=pass (client-ip=85.158.109.167; helo=fug.elabio.com; envelope-from=eproba@csxkg.net; receiver=lists.ozlabs.org) smtp.mailfrom=csxkg.net
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=csxkg.net
Authentication-Results: lists.ozlabs.org;
	dkim=pass (4096-bit key; unprotected) header.d=csxkg.net header.i=@csxkg.net header.a=rsa-sha256 header.s=default header.b=UgI3Yj1I;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=csxkg.net (client-ip=85.158.109.167; helo=fug.elabio.com; envelope-from=eproba@csxkg.net; receiver=lists.ozlabs.org)
X-Greylist: delayed 687 seconds by postgrey-1.37 at boromir; Fri, 12 Sep 2025 15:13:59 AEST
Received: from fug.elabio.com (fug.elabio.com [85.158.109.167])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cNMzC3GyGz2yQH
	for <linux-erofs@lists.ozlabs.org>; Fri, 12 Sep 2025 15:13:59 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=default; d=csxkg.net;
 h=To:Subject:Message-ID:Date:From:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=GlrqsNjQhGLK++FnapspIqpTrDX88j9zSp6vWIc8Flo=;
 b=UgI3Yj1Ir6TiCbhvLPi2T+eq3C+GSBjCyg1UitoxCa3jnkjLQE9Q5m+EKl6aK/49+DeYj3EdhQWt
   9FCrsujOr+A7nyL5X4pHn5JYj2obogGCKR4EUvAyK1M01GuZb0VDbenDCE5ERLp/xWc2TdX+/4D5
   B8r1oS6qu84gfT0icSVMT0eEfoDg+NENzHjJ/pCtMSfxDFIEItm43oryL/XusPYh2JZDW5pRvNg8
   AlX8U4X+gN+n6PsAKUGLHuoiypDlSFIAw9s506r/GF+eK2u7NeiGuFoiQs6Rqjx/YLIq8xNLKvkC
   IGUORRt43/6qXiQ0DrWPox1qCkDGgvpbQhhCLlQhVpnVqmoOgx23sOX+7xf+aBFIfz4HlIjtXVWz
   VdgN4SZgTYNEcPo2hSZVIqfR2JokfRYfgDkvI9Q00yO+K4rvwrZ//0LyVtfuTuKbncl8hVV49gJN
   2WERdkD8CUuNo5IWlvVcgm5vBU7LQ1qEmGpphmbsKmXadVBr6qXDzVxYyMnpFg72HxQWC7fY0hl/
   zk6aivhrLQJJnA9k9OXn2zIW5XqYsSjaDEWZiwFePszxRUDikLFSH5Ojr66zIkE4BBqGj3/F6Xjo
   lT7/2PSCprOuazD3lWI/6SzV90Ab1qftrX1aM1xI3cM9u0Ti9PNnYW/LasI2zu6f+7fcQQIudq0=
To: linux-erofs@lists.ozlabs.org
Subject: Are there any questions? pp
Message-ID: <806aa73ad81bd601e11ece47ce6ccd3c@unknowserver033>
Date: Fri, 12 Sep 2025 05:42:46 +0200
From: "Leo L" <eproba@csxkg.net>
Reply-To: eprosale@csxkg.net
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,HTML_IMAGE_RATIO_02,HTML_MESSAGE,
	MIME_HTML_ONLY,RCVD_IN_MSPIKE_BL,RCVD_IN_MSPIKE_L5,SPF_HELO_PASS,
	SPF_PASS,URIBL_DBL_SPAM autolearn=disabled version=4.0.1
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

<html>
<head>
</head>
<body>
<p>I hope this message finds you well.</p>
<p>We are a professional manufacturer of electric pedal assistant bicycles,
exporting to Europe, North America, and Australia. <br />With years of
experience, we have built long-term relationships with hundreds of
customers and distributors across these regions. <br />To better serve our
partners, we have established warehouses both in Europe and the United
States.</p>
<p>For our European customers, shipping is especially convenient&mdash;all
shippments within the EU can be reached to door in just 3&ndash;7 days, <br
/>directly from our local warehouse. This means no long waiting times, no
customs procedures.</p>
<p>20-Inch Moped Fat Tire Model<br />Equipped with a 48V 15.5AH removable
lithium battery for a long riding range.<br />A 501W high-performance motor
delivers strong power for city commuting, hills, and outdoor adventures.<br
/>Compact, stylish design with fat tires that provide excellent stability
and comfort across multiple terrains.<br /><br /><img
src="https://kiwihoverboard.co.nz/wp-content/uploads/2023/03/V8-Fat-Tire-e-Bike.jpg"
width="800" height="800" /></p>
<p>&nbsp;</p>
<p>26 Inch Fat Tire Mountain Model<br />Built with a 501W powerful motor
and the same 48V 15.5AH lithium battery, ensuring reliable endurance.<br
/>The 26-inch wheels with fat tires offer outstanding traction, making it
suitable for mountain trails, snowy paths, and sandy beaches.<br /><br
/><img src="https://ketelesbike.com/cdn/shop/files/K8002000W.jpg"
width="800" height="800" /></p>
<p>Both models are designed with safety, comfort, and practicality in mind,
combining modern technology with durability to suit <br />different riding
needs&mdash;whether for commuting in the city, weekend leisure, or off-road
exploration.<br />If you are interested in purchasing. Once we have your
address, we will calculate the best possible price for you.</p>
<p>In addition, if you are considering becoming an authorized distributor
in your local area, we welcome the opportunity to work with you. <br />Many
of our current partners started by purchasing just a few units and later
grew into regional distributors.<br />Looking forward to your reply and to
the possibility of working together.</p>
<p>Best regards,<br />Leo Lao<br />Pedal Assistant Bicycles<br /><br /><br
/><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br
/><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br
/><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br
/><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br
/><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br
/><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br
/><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br
/><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br
/><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br
/><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br
/><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br
/><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br
/><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br
/><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br
/><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br
/><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br
/><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br
/><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br
/><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br
/><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br
/><br /><br /><br /><br /><br /><br /><br />If you are interested in
purchasing. Once we have your address, we will calculate the best possible
price for you.<br />If you are interested in purchasing. Once we have your
address, we will calculate the best possible price for you.<br />If you are
interested in purchasing. Once we have your address, we will calculate the
best possible price for you.</p>
</body>
</html>


