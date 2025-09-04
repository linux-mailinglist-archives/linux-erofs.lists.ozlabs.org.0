Return-Path: <linux-erofs+bounces-975-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 33F11B43F1F
	for <lists+linux-erofs@lfdr.de>; Thu,  4 Sep 2025 16:39:18 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cHhv76wv7z2xnM;
	Fri,  5 Sep 2025 00:39:15 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=179.61.221.64
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1756996755;
	cv=none; b=S/9f/KExH7/EQ3EkWiIhFbi781kYms/KhTdc26byIw7TNMnYM5DZYa/qsZb0X433eZxh+ra64vCUk70W6a8AM7NOQPM2whUIGaQjp5/j/+lftLLC7GB2kzqEAgldvXprePMUyKh+epie/77wZOWH04hLn3CBJk39H9nnS5quRuNFTcxwoeq7yZZp9puW2Ca0AHa8NmaIaupeNhdr7TdtW3JvttmvXk0ZRwnI2T+nOzpvlrwPM2oV+D1oY+E7jO/IJFt07aVyVscJ9KVnfBEGMRM36bcp7d90dHxV3LmA2MnbufpIX8Fq/z6XzOIZtcs+zaeWAnk72ZOv+2OeGbOn/A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1756996755; c=relaxed/relaxed;
	bh=L/YuBR8jslp3No5LFYWfTaGhg/SlEmKj5PXHMU4Habw=;
	h=To:Subject:Message-ID:Date:From:MIME-Version:Content-Type; b=VT+pQD+NqwvXNsP6UUQEazCfSB0lfxQObQNwAhJ9WsWdi1ZmCpM1HVFvueNaK/+zAu4mCCfKnX0C1EidX9yvbH/j+9f1HgxcULSHAp8Jl7vmn5PBHV/+XY6gBnInfCqUlLoKtb2qHRD42fFiSlU4rAUfmvr5X9t3lXNqk8KTwmdAOUI1c53P2K8OzeJ6FlgL+iJ8glnMbm7wjWGmt/XQI0s3i1m9aRoSXbZJOR6aYTVPQMBWPBbv3YgGJAI5NxcMGp0c7OUeSSRuLpa52yPsp//EBv/1w5ltD7X0aWTy/ZP1Cy8EhJOBwvgE3fP28AM+v3JeKm6Td63vx43Jx/jSnw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=kb80.net; dkim=pass (4096-bit key; unprotected) header.d=kb80.net header.i=@kb80.net header.a=rsa-sha256 header.s=default header.b=J+U5W+PW; dkim-atps=neutral; spf=neutral (client-ip=179.61.221.64; helo=kot.wzwykj.net; envelope-from=proe864@virtualsportsassociation.com; receiver=lists.ozlabs.org) smtp.mailfrom=virtualsportsassociation.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=kb80.net
Authentication-Results: lists.ozlabs.org;
	dkim=pass (4096-bit key; unprotected) header.d=kb80.net header.i=@kb80.net header.a=rsa-sha256 header.s=default header.b=J+U5W+PW;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=neutral (access neither permitted nor denied) smtp.mailfrom=virtualsportsassociation.com (client-ip=179.61.221.64; helo=kot.wzwykj.net; envelope-from=proe864@virtualsportsassociation.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 5276 seconds by postgrey-1.37 at boromir; Fri, 05 Sep 2025 00:39:14 AEST
Received: from kot.wzwykj.net (kot.wzwykj.net [179.61.221.64])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cHhv62tdyz2xlM
	for <linux-erofs@lists.ozlabs.org>; Fri,  5 Sep 2025 00:39:14 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=default; d=kb80.net;
 h=To:Subject:Message-ID:Date:From:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=L/YuBR8jslp3No5LFYWfTaGhg/SlEmKj5PXHMU4Habw=;
 b=J+U5W+PWL99Xk7spGW5HLky7TWYc5xbOUP7RfbFDd1C8eV8PuN0v9ISomWo1BApgByrFGBHZ44ar
   c/Hn3Si+YpDSwJ1NvhDFPKcp9VGySDJ2YK5y/tzoXb4sBMrqn3HBdv34sM3U01kcxIpcw/77lJxH
   XK+QA1/3BNPHeaHCTftT73PQ+ykyRWWHTZBea2urtp+rTG8Tm1IMVynBcpnZ9SOXxOxG1CDkPPEj
   wDJr5gcWuumpwPRNTRSTUkjLyOkzrn91wLgLH1gmrfkkWjfvw2nRHsrypLKwTMQy0b9tK3ZLvISF
   OJ11/X7PfEIcUauvkgg3sstxyiURxnH4kqJQQkFob90YIgPHpk8mSX8AERjkO8mCuBEWzQYCkQK1
   4iQuwCTu4/Imv77TEIQ3AqcbNdhaWnm8mwr7RFBf26hoCPdeaSiId3FCXTwQ4wRUsSYntwQ5sGeb
   kh4TQEg5A+RiGn+FZDblsaC95f3ksVi5XwuSHTYNBn442TJFOAIgsdkrARtnGc5wHZ98QXVe2F1A
   Yxr17i6abfoi1xHhKgMDixTQoJyJHsGrVvTQK8F4bn5htADK84lMhaTa/VRGoYsu+M9mmUop14iu
   ei9ZyDVWIOuUm/n1tQ83JbE8UzvSzFiJlB18wjPKZ1tyWOeyxYOkDPX0JwxlS5bs7AZEuD88Ark=
To: linux-erofs@lists.ozlabs.org
Subject: Re3: I hope this message finds you well.
Message-ID: <291f7798fd4641375a21ba1d76fe4c38@server723>
Date: Thu, 04 Sep 2025 14:25:18 +0200
From: "Roy" <inquiry@kb80.net>
Reply-To: enquiry@kb80.net
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
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	MIME_HTML_ONLY,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NEUTRAL
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

<html>
<head>
</head>
<body>
<p>I hope this message finds you well. I would like to introduce our
compan=
y, a leading manufacturer of e-bicycles with an annual production capacity
=
of 50,000 units. We proudly export to regions including Europe, North
Ameri=
ca, Australia, South Africa, and the Middle East, serving hundreds of
custo=
mers and dealers worldwide.</p>
<p>Our warehouses in Europe and the United States allow us to ship within
3=
-7 days across the European Union and North America. If you're interested
i=
n purchasing our e-bicycles, please contact us for a competitive quote. We
=
will calculate the best price based on your location. We also offer the
opp=
ortunity to become an authorized distributor in your area&mdash;get in
touc=
h if this is something you're interested in.</p>
<p><b>Featured Model: 26&rdquo; Fat Tire E-Bicycle</b></p>
<p>One of our top sellers in our European warehouse is
the&nbsp;<b>26&rdquo=
; Fat Tire Electric Bicycle</b>&nbsp;with the following features:</p>
<ul>
<li><b>Brushless Motor</b>: A high-speed 500W motor (peak 1000W) that
reach=
es speeds up to 25 MPH (with speed limiter unlocked), ideal for both
climbi=
ng hills and off-road adventures.</li>
<li><b>Large Capacity Battery</b>: Powered by a 48V 15AH battery, offering
=
a range of&nbsp;<b>55-60 miles</b>&nbsp;in pedal-assist mode
and&nbsp;<b>28=
-30 miles</b>&nbsp;in full-electric mode. The battery is also removable
and=
 lockable for convenience.</li>
<li><b>Safety and Comfort</b>: Features a&nbsp;<b>lockable suspension
fork<=
/b>,&nbsp;<b>dual 180mm disc brakes</b>, and upgraded&nbsp;<b>headlights
an=
d taillights</b>&nbsp;for better visibility at night. The Bicycle also
come=
s with a turn signal for added safety.</li>
<li><b>Sturdy Build</b>: The durable frame and&nbsp;<b>puncture-resistant
f=
at tires</b>&nbsp;(26&rdquo; x 4.0&rdquo;) provide excellent traction,
perf=
ect for rough terrains and slippery roads.</li>
<li><b>Versatility</b>: With&nbsp;<b>5 riding modes</b>&nbsp;(including
thr=
ottle, pedal assist, and cruise mode) and&nbsp;<b>7-speed gears</b>, the
Bi=
cycle adapts to your riding preferences for any environment, from urban
str=
eets to mountain trails.</li>
<li><b>Convenient Installation</b>: The Bicycle is&nbsp;<b>85 percent
pre-a=
ssembled</b>&nbsp;with a&nbsp;<b>12-month warranty</b>. Full assembly
instr=
uctions and tools are provided, making the setup easy.</li>
</ul>
<p>If you&rsquo;re interested in this or other models, please don&rsquo;t
h=
esitate to reach out. We look forward to the opportunity to serve you and
e=
xplore potential partnerships.</p>
<p>Best regards,<br />Roy Lu<br />A leading manufacturer of e-bicycles<br
/=
><br /></p>
</body>
</html>


