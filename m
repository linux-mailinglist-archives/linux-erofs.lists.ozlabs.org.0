Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 08EA29D9C11
	for <lists+linux-erofs@lfdr.de>; Tue, 26 Nov 2024 18:07:59 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XyTXm1Ll0z301x
	for <lists+linux-erofs@lfdr.de>; Wed, 27 Nov 2024 04:07:52 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.154.230.149
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1732640870;
	cv=none; b=Jc65l6iG6B6iuE+oF6wgqKG1gpX+LyR5iAVR7tM7pEIptTsAW2BkMqpcBjuAE535HUKUB+NgePj9zIoydMnt3EL42BjBabHE2ORKYf2guBcM+MZ2IoOxQ6WULTwdv92vvKAhiKt0WyUu+YOF4y86d2qMzuL0CwZH0rehzDToQi1dS0/wx2IAhi/EtjqiYpiT/EgzN9zJcZemmmgJErqJ27aR32/hSbFKrBaK71v3HmxY4yiRexRbJCqMzVusz9sG0M0Nwbtepa6cJHKSVyeb65biPJjndt9o1YzCi/iRqX287/vAIERtJCC9HwppalMoyP9dvUHCbG4nhX52GVRufw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1732640870; c=relaxed/relaxed;
	bh=rjmXIO4fBKcKttFIxOLt4TguCa48gQiq3l29py8MZzo=;
	h=To:Subject:Message-ID:Date:From:MIME-Version:Content-Type; b=Cd7VFk8Mq9dKbvnNnAdXzPAjeQR6X5VcA5Nw7/0eue5UfU4Y/vo1WJD+88LeeKvwDC23k6/6FcxLjVLLhjdnb90q/n6v5bVDnbxAPMz+Gf7vZT0uup3iQEiEAS17YoAG4OstN4XRmplBOub7Yp5opZjDKcAJujvHzkBNKJ6XMvQZn3pBZXxs/GECgtlNW88ombeQF+5tm82fgxXkVvRoTsu26ydbsCvHZlJS5twH2Cuhi40mz3UXu0NA3M7PKnJmmAbx3PZH3RNE9TGHclBKcxJ8sQTEIbNGSXxGxnwVNiGWEdyXpMYiJa81OWovcCHavl+ldwqafF87/WOuwxaAyA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=jiuzuzong.com; dkim=pass (1024-bit key; unprotected) header.d=jiuzuzong.com header.i=@jiuzuzong.com header.a=rsa-sha256 header.s=default header.b=XsV0mcS5; dkim-atps=neutral; spf=pass (client-ip=192.154.230.149; helo=mta15.rev.ytqingfan.net; envelope-from=epowerrc@jiuzuzong.com; receiver=lists.ozlabs.org) smtp.mailfrom=jiuzuzong.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=jiuzuzong.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=jiuzuzong.com header.i=@jiuzuzong.com header.a=rsa-sha256 header.s=default header.b=XsV0mcS5;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=jiuzuzong.com (client-ip=192.154.230.149; helo=mta15.rev.ytqingfan.net; envelope-from=epowerrc@jiuzuzong.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 7286 seconds by postgrey-1.37 at boromir; Wed, 27 Nov 2024 04:07:49 AEDT
Received: from mta15.rev.ytqingfan.net (mta15.rev.ytqingfan.net [192.154.230.149])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XyTXj5z1Dz2xps
	for <linux-erofs@lists.ozlabs.org>; Wed, 27 Nov 2024 04:07:49 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=default; d=jiuzuzong.com;
 h=To:Subject:Message-ID:Date:From:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=rjmXIO4fBKcKttFIxOLt4TguCa48gQiq3l29py8MZzo=;
 b=XsV0mcS5moZ5EcgeVRMBq+9mAIRXOle+4L3BRg+UNh88dvgPBmRFocbNEEV4mgrue6XzLZ3fcU1d
   FKVvq3bFQ80VBZLhQulO4vdvc0PyJpfrZpPqXrNSYT5B8y9sY7P8eNYIcuTlT270xE9P9w2kZmly
   pPP/Dacavs+rKwx7Cz8=
To: linux-erofs@lists.ozlabs.org
Subject: choose your Urban Cruiser fat tire ebike
Message-ID: <2c78fbc8752e44dec5699bec65b69758@bbbike.org>
Date: Tue, 26 Nov 2024 12:49:59 +0100
From: "Darren Parker" <epowerzm@jiuzuzong.com>
MIME-Version: 1.0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=2.2 required=5.0 tests=DATE_IN_PAST_03_06,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_IMAGE_RATIO_02,
	HTML_MESSAGE,MIME_HTML_ONLY,RCVD_IN_BL_SPAMCOP_NET,RCVD_IN_MSPIKE_BL,
	RCVD_IN_MSPIKE_L5,SPF_HELO_PASS,SPF_PASS autolearn=disabled
	version=4.0.0
X-Spam-Level: **
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
Reply-To: darrenp@jiuzuzong.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

<html>
<head>
</head>
<body>
Hello,<br /> <br /> I hope you're doing well. As a leading manfacture in
electric bike, we're excited to introduce our latest model &ndash; the
Urban Cruiser. <br />This state-of-the-art e-bike offers a perfect
combination of advanced technology and exceptional comfort, designed to
elevate your riding experience. <br />Best of all, it's available for
direct purchase from our warehouse in Germany, with fast and reliable
delivery across the European Union in just 3-7 days.<br />For more details
or to make a purchase, please don't hesitate to reach out. We'll need your
address to calculate the shipping cost.<br /><br /><img
src="https://www.ouhepower.com/wp-content/uploads/2021/11/leopard-fat-tyre-ebike-1.jpg"
width="1020" height="767" /><br /><br /> <br /> Dual Suspension System:
Enjoy a smooth ride no matter the terrain. The front features an 80mm air
suspension, ensuring a cushioned ride even on bumpy roads. <br />The rear
suspension absorbs shock, making it ideal for outdoor adventures.<br /><br
/> Powerful 500W Motor: The Urban Cruiser is equipped with a
high-performance 500W motor, enabling speeds of up to 30 MPH. <br />Whether
you're cruising through the city, tackling mountain trails, or even riding
on snow, this e-bike makes it effortless.<br /> <br /> Upgraded Battery:
Our 48V 15AH lithium-ion battery offers a range of 40-54 miles per charge.
The removable, dustproof, and waterproof design ensures reliability,
safety, and longevity.<br /> <br /> Foldable and Lightweight: With
dimensions of 33 x 16 x 30 inches when folded and a weight of just 71
pounds, the Urban Cruiser is highly portable and perfect for both commuting
and traveling. <br />Easily store it in your car trunk or carry it on
public transport.<br /> <br /> Enhanced Riding Experience: The Urban
Cruiser features an intuitive LCD display showing vital stats like speed,
battery level, pedal assist, and distance traveled. <br />It also comes
with front and rear mechanical disc brakes, a bright headlight, and an
adjustable rear light for optimal safety. <br />Customize your ride with 3
assist modes and a 7-speed gearbox.<br /> <br /><img
src="https://electroheads.com/cdn/shop/files/ado-ado-beast-20f-250w-electric-bike-ex-display-electric-bikes-with-fat-tyres-31064042537073.jpg"
width="1080" height="1080" /><br /> <br />Key Features:<br /> 20-Inch Fat
Tires: Offers superior stability and comfort on a variety of surfaces.<br
/> 500W Motor: Smooth, powerful, and efficient.<br /> 48V 15AH Battery:
Long-lasting performance.<br /> Lightweight Aluminum Alloy Frame: Durable
and stylish, perfect for urban environments.<br /> We&rsquo;re confident
that the Urban Cruiser will transform your daily commute and outdoor
exploration. <br />With direct shipping available from our German
warehouse, your next cycling adventure is just a click away.<br /><br
/>Upgraded Battery: Our 48V 15AH lithium-ion battery offers a range of
40-54 miles per charge. The removable, dustproof, and waterproof design
ensures reliability, safety, and longevity.<br /><br />Foldable and
Lightweight: With dimensions of 33 x 16 x 30 inches when folded and a
weight of just 71 pounds, the Urban Cruiser is highly portable and perfect
for both commuting and traveling.<br />Easily store it in your car trunk or
carry it on public transport.<br /><br />Enhanced Riding Experience: The
Urban Cruiser features an intuitive LCD display showing vital stats like
speed, battery level, pedal assist, and distance traveled.<br />It also
comes with front and rear mechanical disc brakes, a bright headlight, and
an adjustable rear light for optimal safety.<br />Customize your ride with
3 assist modes and a 7-speed gearbox.<br /> <br /> For more details or to
make a purchase, please don't hesitate to reach out. We'll need your
address to calculate the shipping cost.<br /> <br /> Best regards,<br />
Darren Parker<br /> Urban Cruiser Power<br /> <br /><br /><br /><br /><br
/><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br
/><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br
/><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br
/><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br
/><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br
/><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br
/><br /><br /><br /><br /><br /><br /><br /><br /><br /><br />
</body>
</html>

