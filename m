Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id A09579E5C36
	for <lists+linux-erofs@lfdr.de>; Thu,  5 Dec 2024 17:53:42 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Y40pD5NgKz30VR
	for <lists+linux-erofs@lfdr.de>; Fri,  6 Dec 2024 03:53:40 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=181.214.231.27
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1733417618;
	cv=none; b=jx26ZtnKqLNTzgC4Rvgho/uRtxtBkFSoTc+448JTB4y5YKvbWArw6Sodsh8icrPJrwZauY8/RTM6tw/xF2NbTwIVRQEI9P17uAVta/UbQZIgEsr4+K516SWdDPhwiop+nVloedX8DoxAZdpgY0POlm7pleYhnr5oEgJ55u+jeyBlmUCHgfIIuZ2wXeMfZUF9oTRBMjpZ2uMIJo3xQ4TTAEMewTW2/5FjBIP80Qb6vg98ewxNH4Df1ZPSml3dtm8HGziyHmfALcp09sdzftYuB4hjZ5qv4AkPb+qBos5ucqSP75Ecx5FDNaBMuiEjeeB7ZqXNoTaciwAWRwZ/4H5wgg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1733417618; c=relaxed/relaxed;
	bh=tyz88NzjQN9C4JBO5375D3V7jq+2a/WVY5jBZqWp5iE=;
	h=To:Subject:Message-ID:Date:From:MIME-Version:Content-Type; b=Q7yVkuhgUhPtzqLlSxDDOxAu2qyrYWiqwZv/bZ2+vgnt/RwSncNYqgGcHUfx3BHx99GXrxYnij7T83QUHX1zpLIvU6AheViOACGnwNx9+RGsXgFpEfosUkT/6W8P6l8WJJ9k4yHpVIcrXwZyXKPfItjKHPPsU+f/FmPLQpmbHV6UJON2X0frukOkp5yb0fPlfKCTENSgVq1jRAWNk96JLEQHZLDaEW3xJcoleYBthFxqAN0X7XIKqJ3S1osiIHO+g9ZKRdtTIZ8GFQ6lrMyysklK04uOflrhvbkw9qyacEt8j5xfXJ9XBNEA/sKBFM07OfYr9MiErahxC1JRBfQROQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=clwzxl.com; dkim=pass (1024-bit key; unprotected) header.d=clwzxl.com header.i=@clwzxl.com header.a=rsa-sha256 header.s=default header.b=SnHUZkkn; dkim-atps=neutral; spf=pass (client-ip=181.214.231.27; helo=mta5.rev.qiantuduoduo.com; envelope-from=ebikehbwz@clwzxl.com; receiver=lists.ozlabs.org) smtp.mailfrom=clwzxl.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=clwzxl.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=clwzxl.com header.i=@clwzxl.com header.a=rsa-sha256 header.s=default header.b=SnHUZkkn;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=clwzxl.com (client-ip=181.214.231.27; helo=mta5.rev.qiantuduoduo.com; envelope-from=ebikehbwz@clwzxl.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 3655 seconds by postgrey-1.37 at boromir; Fri, 06 Dec 2024 03:53:37 AEDT
Received: from mta5.rev.qiantuduoduo.com (mta5.rev.qiantuduoduo.com [181.214.231.27])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Y40p92BBVz2xJ8
	for <linux-erofs@lists.ozlabs.org>; Fri,  6 Dec 2024 03:53:37 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=default; d=clwzxl.com;
 h=To:Subject:Message-ID:Date:From:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=tyz88NzjQN9C4JBO5375D3V7jq+2a/WVY5jBZqWp5iE=;
 b=SnHUZkknpOjxAhjbfifiJG7kCJAgTZNXLT1/5tCl/801zxQU5IwBS4L4dHz3TmXLeRlCtuenUCc5
   BWfcOgDoEzQl0gnvitfIJ0K223ha/7ZfKFdQXYOcYKfN545U1N0LRSbPfKDB4CU9YgHNoTpfEZPO
   KBzVYduwpeLg8VeQ6c0=
To: linux-erofs@lists.ozlabs.org
Subject: =?UTF-8?B?Z2V0IHlvdXIgdXJiYW4gY3J1aXNlciB0b2RheSDigJMgZmFzdCBzaGlwcGluZyBmcm9tIGdlcm1hbnk=?=
Message-ID: <3492cbc6efcac3d50f00b7a481d97b3f@clwzxl.com>
Date: Thu, 05 Dec 2024 11:27:24 +0100
From: "Ebike Factory" <ebikehbmd@clwzxl.com>
MIME-Version: 1.0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=3.5 required=5.0 tests=DATE_IN_PAST_06_12,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_IMAGE_RATIO_02,
	HTML_MESSAGE,MIME_HTML_ONLY,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
	URIBL_DBL_SPAM autolearn=disabled version=4.0.0
X-Spam-Level: ***
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
Reply-To: ebikehb@lqsgw.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

<html>
<head>
</head>
<body>
Hi,<br /><br />I hope you're doing well! As a leading manufacturer in
electric bikes, we are thrilled to introduce our latest innovation &ndash;
the Urban Cruiser, <br />a state-of-the-art e-bike designed to elevate your
cycling experience.<br /> <br /> With a perfect balance of advanced
technology, exceptional comfort, and practical features, the Urban Cruiser
is built for riders who seek style, <br />performance, and versatility.
Whether you're commuting through the city or embarking on an outdoor
adventure, <br />this e-bike has everything you need to make your ride more
enjoyable and effortless.<br /> <br /> Shipping directly from our warehouse
in Germany, you can expect a fast and reliable delivery to any EU
destination within just 3-7 days.<br /> For more information or to make a
purchase, simply get in touch with us. We will need your shipping address
to calculate the exact shipping cost.<br /> <br /><img
src="https://electroheads.com/cdn/shop/files/ado-ado-beast-20f-250w-electric-bike-ex-display-electric-bikes-with-fat-tyres-31064042569841.jpg"
width="800" height="800" /><br /><br /> Key Features of the Urban
Cruiser:<br /> Dual Suspension System<br /> The Urban Cruiser is designed
for smooth rides over all terrains. The 80mm front air suspension ensures a
cushioned, comfortable ride on rough roads, <br />while the rear suspension
absorbs impacts, making it perfect for outdoor adventures and long rides.
Whether you're on urban streets or mountain trails, <br />this e-bike
offers an incredibly stable and comfortable journey.<br /> <br /> Powerful
500W Motor<br /> Equipped with a 500W high-performance motor, the Urban
Cruiser effortlessly reaches speeds of up to 30 MPH. Whether you're
cruising through the city, <br />tackling steep mountain paths, or riding
on snow, this e-bike delivers power when you need it most, making your ride
faster and more efficient.<br /> <br /> Upgraded 48V 15AH Lithium-Ion
Battery<br /> The 48V 15AH battery provides an impressive range of 40-54
miles per charge, depending on riding conditions and assist mode. <br />The
battery is removable, dustproof, and waterproof, ensuring long-lasting
performance, safety, and reliability. Charge it at home, at work, or while
on the go &ndash; the flexibility is yours.<br /> <br /> Foldable and
Lightweight<br /> Weighing just 71 pounds and folding to 33 x 16 x 30
inches, the Urban Cruiser is perfect for commuting, traveling, and storage.
<br />It's lightweight and easy to carry, store in your car trunk, or take
on public transport, making it ideal for any modern lifestyle.<br /> <br />
Enhanced Riding Experience<br /> The Urban Cruiser features an intuitive
LCD display, giving you real-time data about your ride, including speed,
battery level, pedal assist mode, and distance traveled. <br />It&rsquo;s
easy to keep track of your performance while you ride! Additionally, the
e-bike comes with front and rear mechanical disc brakes, ensuring superior
stopping power, even in challenging conditions. <br />The bright headlight
and adjustable rear light offer excellent visibility, enhancing your safety
when riding at night.<br /> <br /> You can also customize your ride with 3
assist modes and a 7-speed gearbox, providing you with a variety of options
for different terrains and riding styles.<br /><br /><img
src="https://www.himobikes.com/cdn/shop/files/A20F_f3da5efe-2691-49e7-a6df-5ee686f9a58a.jpg"
width="800" height="800" /><br /><img
src="https://zoomelectricbikes.com/cdn/shop/files/G-FORCET42FatTire750W48V20AhAllTerrainFatTireFoldingElectricBike6_1200x.jpg"
width="800" height="800" /><br /><br /> Additional Features:<br /> 20-Inch
Fat Tires: Enjoy superior stability and comfort on any surface, whether
it&rsquo;s asphalt, gravel, or snow.<br /> Lightweight Aluminum Alloy
Frame: Durable and stylish, perfect for urban environments and daily
use.<br /> Stylish Design: The sleek, modern aesthetic ensures that the
Urban Cruiser stands out, whether you're riding through the city or on an
outdoor trail.<br /> We believe that the Urban Cruiser will not only
enhance your daily commute but also transform your outdoor adventures. <br
/>With direct shipping from our German warehouse, getting your hands on
this high-performance e-bike is quick. Your next cycling adventure is just
a few clicks away.<br /> <br /> For any questions, further details, or to
purchase, don&rsquo;t hesitate to reach out. Once we have your address,
we'll calculate the shipping cost for you.<br /> <br /> Best regards,<br />
<br /> David Dyson<br /> The E-bike Power<br /><br /><br /><br /><br /><br
/><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br
/><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br
/><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br
/><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br
/><br /><br /><br /><br /><br /><br /><br /><br />Send address for remove
</body>
</html>

