Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 725C2A1B4FC
	for <lists+linux-erofs@lfdr.de>; Fri, 24 Jan 2025 12:47:58 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YfbfF3yNCz30TP
	for <lists+linux-erofs@lfdr.de>; Fri, 24 Jan 2025 22:47:49 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=141.195.119.107
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1737719268;
	cv=none; b=MEQtYe9o9BBUxcny30RVOw6XYjgqkxwAJiPjwWi0zAzdGyHDixk5g5/WEWtQVbYLe3l2SNLq85YTjAxbI5qLYzh/hvZQvYa9IYGpzEEPqtZPtz31BlmucdWRi0o0nY911ugt8Lope1WMAq9rQMKaNPJwEYb8ezSTAe0OYZdTBeiTFO61puTzachl2BJCfjKVEpCM4FiXJfFbCj280cy7V/ZFSy3AQ36j0OsR+pZolEd89G3L5w57zCPvliInSDaqA4IFyJLFO0Tb0oHbawa+EVOfSEpvgKc9zB4Pp58p8/UN290miy7sp6Ua/GZc1lFDDDBjZm0gP02chpaKcb7Omw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1737719268; c=relaxed/relaxed;
	bh=Qkm6E0QAd41XNPL9CxHGQPV/68eqe0DRPFLMoRD0b2c=;
	h=To:Subject:Message-ID:Date:From:MIME-Version:Content-Type; b=XCdE5nb8rzTvahp/idKNgW79mcHLFnfvonUeJzIudxayiRdpFP7dkBWTDlW8qHZ/3GzrvPB1GZnPCzOhKtolTYuCBSpJUJXPSG/oRBp5Hz9nkP4Y0oW4/KJwyiy2e5nv0712GNdNPLfP7sVuSlXI8xIddxGj8CN9ScFXA7nVnhQQ0mv7I51tB+bToe/sEe/BL2Bl/+EbF3BbqT9yypPCt5K4xjCfD/RXxYwEB8PqRKP2kHXbS6tJnp9N2fbFIxs70Plb3aOogY1DaGQb1SxqnfEN7vndpf6lIReIEwlDWhaZfPhQ331oCRovWM7BF5jNDxFjfWBtwrql9tUccWRzyQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=ipozx.com; dkim=pass (1024-bit key; unprotected) header.d=ipozx.com header.i=@ipozx.com header.a=rsa-sha256 header.s=default header.b=qx0GL9Nq; dkim-atps=neutral; spf=pass (client-ip=141.195.119.107; helo=rtl-3.lev.bay.magicclub18.cn; envelope-from=teamhbjq@ipozx.com; receiver=lists.ozlabs.org) smtp.mailfrom=ipozx.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=ipozx.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=ipozx.com header.i=@ipozx.com header.a=rsa-sha256 header.s=default header.b=qx0GL9Nq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=ipozx.com (client-ip=141.195.119.107; helo=rtl-3.lev.bay.magicclub18.cn; envelope-from=teamhbjq@ipozx.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 4371 seconds by postgrey-1.37 at boromir; Fri, 24 Jan 2025 22:47:36 AEDT
Received: from rtl-3.lev.bay.magicclub18.cn (rtl-3.lev.bay.magicclub18.cn [141.195.119.107])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Yfbf036mCz30DX
	for <linux-erofs@lists.ozlabs.org>; Fri, 24 Jan 2025 22:47:36 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=default; d=ipozx.com;
 h=To:Subject:Message-ID:Date:From:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=Qkm6E0QAd41XNPL9CxHGQPV/68eqe0DRPFLMoRD0b2c=;
 b=qx0GL9NqbQZ8VQCpTGlPl+5sJVYPtjsNGfUlj2IbdnQygnba8vaRKOv4aQyoP0oAcCjU+Dplpw1X
   YwA2fMCt7fRaaf8BFEwZsE0rwEIhytTsnvy9WXNgPa83Ebx3F/FZ6BodLdEhXsp7QJKcWK5fG2iv
   Di7d3PmVk63PcrEyDlk=
To: linux-erofs@lists.ozlabs.org
Subject: =?UTF-8?B?Y2l0eSB2b3lhZ2VyIOKAkyB5b3VyIHN0cmVuZ3RoIGFuZCBob25vciBvbiBldmVyeSByaWRl?=
Message-ID: <49a320f927bdfc5cc142e62fff2b3a94@boonebike.com>
Date: Fri, 24 Jan 2025 11:30:52 +0100
From: "=?UTF-8?B?UmFpbmVyIE3DvGxsZXI=?=" <teamhbjq@ipozx.com>
MIME-Version: 1.0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,HTML_IMAGE_RATIO_04,HTML_MESSAGE,
	MIME_HTML_ONLY,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
	autolearn=disabled version=4.0.0
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
Reply-To: cityvoyager@ipozx.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

<html>
<head>
</head>
<body>
Hi,<br /> <br /> I hope this message finds you in great spirits. We are
excited to present our latest creation in the world of electric bikes
&ndash; the City Voyager. As a pioneer in the industry, we've designed this
model to enhance your cycling experience with its state-of-the-art features
and elegant design.<br /> <br /> The City Voyager seamlessly blends
advanced technology, superior comfort, and a rider-focused design, making
it the perfect option for those who seek both performance and style.
Whether navigating the bustling streets of the city or exploring off-road
terrain, this e-bike guarantees a smooth, swift, and enjoyable ride.<br />
<br /> Shipped directly from our German facility, we ensure efficient and
dependable shipment to all EU locations, usually within 3 to 7 days.<br />
<br /> Should you have any questions, need further details, or are ready to
make purchase. Provide your address, and we'll offer you a personalized
quote.<br /> <br /><img
src="https://i.otto.de/i/otto/43e5a6d4-2f2d-4bc0-8442-e174f2d3e525/Schwarz.jpg"
width="1000" height="1000" /><br /><br /> Key Features of the City
Voyager:<br /> Dual Suspension for Maximum Comfort<br /> The City Voyager
comes with an 80mm front air suspension, designed to provide a smooth,
comfortable ride even on bumpy surfaces. The rear suspension absorbs
shocks, making it ideal for extended rides or off-road adventures. Whether
navigating urban streets or rugged trails, you'll enjoy steady handling and
comfort.<br /> Powerful 500W Motor<br /> <br /> Equipped with a
high-performance 500W motor, the City Voyager can reach speeds of up to 45
km/h. This motor is ideal for city rides, tackling steep inclines, and even
snowy paths, delivering the power you need for an exhilarating and
efficient ride.<br /> Long-Lasting 48V 15AH Battery<br /> <br /> The 48V
15AH lithium-ion battery offers a range of 65&ndash;85 km per charge,
depending on riding conditions and selected power mode. This durable,
removable battery is both dust and waterproof, ensuring it performs under
varying conditions. It can be easily recharged at home, work, or wherever
you are, keeping you ready for your next ride.<br /> Compact and Foldable
Design<br /> <br /> Weighing only 28 kg and folding to 84 x 40 x 76 cm, the
City Voyager is ideal for individuals with an active lifestyle. It's easy
to carry and store, making it a perfect companion for both commuters and
travelers.<br /> Enhanced User Experience<br /> <br /> The LCD display
provides real-time information on your speed, battery status, support mode,
and distance traveled. With reliable mechanical disc brakes on both the
front and rear wheels, you can count on powerful stopping performance in
any weather. The front and rear lights improve your visibility during
nighttime riding, boosting safety.<br /> Choose from three different
support modes and a 7-speed gear system to tailor your ride according to
the terrain and your riding preferences.<br /> <br /> Additional
Features:<br /> 1.20-inch Fat Tires: Ensuring maximum stability and comfort
across various surfaces, from pavement to gravel and snow.<br />
2.Lightweight Aluminum Frame: Combining strength and style for daily
use.<br /> 3.Modern, Sleek Design: The City Voyager boasts a contemporary
and stylish look.<br /> <br /> If you have any questions, need further
information, or are ready to proceed, don't hesitate to contact us. Simply
share your address, and we will provide an accurate quote.<br /> <br />
Best regards,<br /> Rainer M&uuml;ller<br /> The City Voyager Team
</body>
</html>

