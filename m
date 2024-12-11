Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 3012B9ECC81
	for <lists+linux-erofs@lfdr.de>; Wed, 11 Dec 2024 13:47:43 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Y7b3Z5LF8z30St
	for <lists+linux-erofs@lfdr.de>; Wed, 11 Dec 2024 23:47:38 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=179.61.138.236
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1733921256;
	cv=none; b=O1z6iN5Rb8lR98w0vFXBv3NizPiYZrujhpAabZIgkF/ajoxlXd/P5CoSb9kI7R7w/nKuwZhtBB49FT1LN/fPKIrjSQpf9DFMmfw2ymtPOJ5ZSQi4IM4n1fFih06UIG5rZsa3WMpnrD/Q8FOMr90n7wCPskwAsTjJoC6KlJRkLf2gcr3lms90JEtFZd9iFQltuUcNHG43qtSp7nlqJnqP/CLK/JizgdqEUuKurcpTNDEXGkyfj5r941zw2lFRHQyG6MmaBt8CcT407SHpLBYfazxQ9V4hciSNJUBnkgzEKz4NinDOPFfkPqLe0RIlG5eu9RqZ+d/DF+cjk/GCUD7kIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1733921256; c=relaxed/relaxed;
	bh=cHgCH4E1lhOxtAbQr+i7z/m07WUNAnD6/q9ZJPzrRCo=;
	h=To:Subject:Message-ID:Date:From:MIME-Version:Content-Type; b=PKy+mOLEhD2sSK97ZKwppVoOaj6guW7vkyjuQKMx6tXpxPfm+JxqcZvrhv0KTPNbMHhHt8dyJImFv0Cl44CRlgIxPbfp7sm2Ba6ibjiJCoWwQElS9InRWj5BpXL8UJyuCt2noZYeoBMFbTjRLWZj20NoQY314pRc1FP3virTyotWROU8R66oFOo1Tv6ccxtTassi0jdL5RJ6IDOynhOqD6mXiwLiNv3vsUU9KVYyusnDNxt20iarqKWV9NfKrNywHC86GQy8BIBPvpn49mrgG68qUEqhTtRDVgfrc/Rjch+bsKV0ntFieAuWuy0rIDB+U1ee2lBTAxiOZBr/V4fGig==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=388yh.com; dkim=pass (1024-bit key; unprotected) header.d=388yh.com header.i=@388yh.com header.a=rsa-sha256 header.s=default header.b=OfcaR2qK; dkim-atps=neutral; spf=pass (client-ip=179.61.138.236; helo=mta8.rev.vn578.com; envelope-from=partnerfn@388yh.com; receiver=lists.ozlabs.org) smtp.mailfrom=388yh.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=388yh.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=388yh.com header.i=@388yh.com header.a=rsa-sha256 header.s=default header.b=OfcaR2qK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=388yh.com (client-ip=179.61.138.236; helo=mta8.rev.vn578.com; envelope-from=partnerfn@388yh.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 3632 seconds by postgrey-1.37 at boromir; Wed, 11 Dec 2024 23:47:35 AEDT
Received: from mta8.rev.vn578.com (mta8.rev.vn578.com [179.61.138.236])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Y7b3W6Z4cz2xYs
	for <linux-erofs@lists.ozlabs.org>; Wed, 11 Dec 2024 23:47:35 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=default; d=388yh.com;
 h=To:Subject:Message-ID:Date:From:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=cHgCH4E1lhOxtAbQr+i7z/m07WUNAnD6/q9ZJPzrRCo=;
 b=OfcaR2qKkcFMRyQDr/BxdoOgNZfMJbgHVYNyeV1VJE0aAP/AP7ueqgF2K0SX7ZPet4Gda1mG1q0X
   dAKgUen2SzyusTr1lBDjjyD+Rujmtf4wlwVz1OqSGrY8SQT3Sj1ycezNKClNwcBEHCHRgMqoTSP0
   TgEOISnt4Ds3RxFv5+Y=
To: linux-erofs@lists.ozlabs.org
Subject: follow up: wondering if you received my last email
Message-ID: <58c0c9551fb3eb52bee568ed88d1fe04@388yh.com>
Date: Wed, 11 Dec 2024 07:54:42 +0100
From: "Roland Smith" <partnergp@388yh.com>
MIME-Version: 1.0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=2.7 required=5.0 tests=DATE_IN_PAST_03_06,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_IMAGE_RATIO_02,
	HTML_MESSAGE,MIME_HTML_ONLY,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
	URIBL_BLACK autolearn=disabled version=4.0.0
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
Reply-To: ebikepartner@cdcqcy.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

<html>
<head>
</head>
<body>
Hi,<br /> <br /> I hope this message finds you well. We are thrilled to
introduce you to our premium collection of electric bikes, designed to suit
a variety of lifestyles and riding needs. With fast, reliable shipping from
our German warehouse (shipping within 3-7 days across the EU), you can
start your next adventure in no time. Explore our three distinct models,
each crafted for performance, comfort, and convenience.<br /> <br /> Please
contact to proceed with your purchase. <br /> To provide an accurate
shipping cost, kindly share your address.<br /> <br /> 1. The MetroMoped :
The Classic Moped-Style E-Bike<br /> <br /> Blending timeless design with
modern electric power.<br /> The MetroMoped offers a unique blend of
vintage aesthetics and cutting-edge performance. Good for those who
appreciate style, comfort, and versatility.<br /> <br /> 500W Motor:
Provides smooth acceleration and a top speed of 28 MPH, making it suitable
for urban and rural rides.<br /> 48V 15Ah Battery: Offers an impressive
range of 38-55 miles per charge, making it ideal for commutes and longer
trips.<br /> 20&rdquo; Fat Tires: Ensure excellent traction and stability
on both paved roads and rough trails.<br /> Classic Design: Combines the
charm of a traditional moped with the efficiency of modern e-bike
technology.<br /> Front and Rear Disc Brakes: Deliver precise stopping
power for increased safety.<br /> Integrated Light System: Enhances
visibility for night riding and low-light conditions.<br /> <br /> The
MetroMoped arrives 95 percent pre-assembled, making it easy to get started.
With a 2-year warranty and lifetime technical support, you can ride with
confidence and peace of mind.<br /><br /><img
src="https://www.ridefaboard.com/cdn/shop/files/v8.1.jpg" width="800"
height="800" /><br /><br /> <br /> <br /> 2. Trail Blazer: The Adventurous
All-Terrain E-Bike<br /> <br /> Ideal for tackling rugged terrain, beaches,
snow, and trails.<br /> The Trail Blazer is your go-to e-bike for outdoor
adventures. Whether you&rsquo;re hitting mountain trails or exploring
off-road paths, this bike is built to perform.<br /> <br /> 500W Motor:
Generates 66.6Nm of torque and a top speed of 28 MPH (45 km/h), Good for
conquering hills and rough landscapes.<br /> 26&rdquo; x 4.0&rdquo; Fat
Tires: Anti-slip design ensures excellent grip and control on sand, snow,
and dirt tracks.<br /> 48V 15Ah Battery: Delivers a range of 30-35 miles
(pure electric) or 55-60 miles (pedal assist). The battery is removable for
flexible charging.<br /> Front Suspension Fork: Absorbs shocks and bumps,
providing a comfortable ride even on uneven ground.<br /> Soft, Ergonomic
Seat: Ensures comfort on long rides.<br /> <br /> Equipped with reliable
disc brakes, an informative LCD display, and multiple assist levels, the
Trail Blazer is ready to accompany you on any adventure.<br /> <br /><img
src="https://wheelriders.dk/wp-content/uploads/2023/02/Gunai-mx02S.webp"
width="800" height="800" /><br /> <br /> 3. Urban Cruiser: The Versatile
Commuter<br /> <br /> Good for city commuting and urban adventures.<br />
The Urban Cruiser is built for those who need a dependable and adaptable
e-bike for daily commutes or casual rides around town.<br /> 500W Motor:
Offers a top speed of 30 MPH for swift and efficient travel.<br /> Dual
Suspension: 80mm front air suspension and rear suspension ensure a smooth
ride, even on bumpy roads.<br /> 48V 15Ah Battery: Provides a range of
40-54 miles on a single charge. The battery is removable, dustproof, and
waterproof for maximum durability.<br /> Foldable Design: Weighing only 71
lbs and folding down to 33 x 16 x 30 inches, it&rsquo;s easy to store and
transport.<br /> 20&rdquo; Fat Tires: Ideal for city streets and light
off-road paths, offering stability and comfort.<br /> LCD Display:
Real-time tracking of speed, battery level, and distance.<br /> <br /> With
reliable mechanical disc brakes and a complete lighting system for
nighttime safety, the Urban Cruiser is designed to handle your daily needs
effortlessly.<br /><br /><img
src="https://www.tucanobikes.fr/WebRoot/StoreES3/Shops/ec7534/5AF2/F71A/A0A3/F1B8/CEDD/52DF/D03B/1D99/Tucano_Bikes_Monster_HB_Roca.jpg"
width="800" height="721" /><br /><br /><br /> Fast Shipment: Shipped from
our German warehouse with shipping in 3-7 days across the EU.<br />
Comprehensive Warranty: Up to 2 years of warranty and lifetime technical
support.<br /> Customer-Centric Service: Our dedicated support team is
ready to assist you within 24 hours.<br /> Premium Quality: Each e-bike is
designed for durability, performance, and rider satisfaction.<br /> <br />
Please contact to proceed with your purchase. <br /> To provide an accurate
shipping cost, kindly share your shipping address.<br /> <br /> Best
regards, &nbsp;<br /> Roland Smith<br /> Your Electric Bike Partner
</body>
</html>

