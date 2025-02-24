Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 103F9A4257A
	for <lists+linux-erofs@lfdr.de>; Mon, 24 Feb 2025 16:09:58 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Z1kg26TwXz30Jc
	for <lists+linux-erofs@lfdr.de>; Tue, 25 Feb 2025 02:09:50 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=85.120.223.179
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1740409788;
	cv=none; b=MMm108Q5VXvGz/YofKz5nXNAomCGwrfAJr8xtu7FwchmCVzi00ToSYJuWnb297owG151J5JH4j2SapnAXmyPPxXUoYqvBym1kdj5ISBxvFfvW9m7WG0liyR8DkdANyfWStOILM+eU/rYD7lj00zULg/Jf37uK4ZCAp9HOBEt82LboX/nGcpe94yL0x1WAF7JioUbWF22swYAnphkE8AU2fkZ716toDSVLdxG2Yrw1lJmIa/XexLp6szBnNmGogqpNWHySdN9fXi1ao+GVDWhJ0Me6d0gT0TFsNmzhEI0mdFcDIWivaJui6MvGrvSkg/H9hkvqhAfy4H7727fDLnKhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1740409788; c=relaxed/relaxed;
	bh=z8uNq8GlAINvKunGTdIldZk7tfOJe0ZodWZrZoIk2aE=;
	h=To:Subject:Message-ID:Date:From:MIME-Version:Content-Type; b=lGuTyJuqop3yHIRHnk2s+mMPX3iDo66ArL7dM4Rk8GgTbWhTE1VMTFTjSzwnuKPTuqzDGrxnYuBb+ezzceElxfrSGNlty6ERE8n2aOujCJIzAUujENJ9XqEc9z0nDcCsXcTwQJNCh/xfMuh+ls8IyOygHWXh5uTvlS3vYGjBqH5SBo5qnT/t1b0auItTS6PZZoX5CSOheaIMb/Ayqw/kKxY1A9erS0mUVYT2kzwNKbVapWFl2XsIvZnBZqZd6XbU93Lapss0ulCN+g+w44fms6aoM1JQwuHGMI09O/1jzKryd82UjS/CQuN73bf+FNWL8PpEtu4Kc4twfFx1+rYIfQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=renliangliang.com; dkim=pass (1024-bit key; unprotected) header.d=renliangliang.com header.i=@renliangliang.com header.a=rsa-sha256 header.s=default header.b=OBf/FMd6; dkim-atps=neutral; spf=pass (client-ip=85.120.223.179; helo=atl-15.jab.fad.pj156.com; envelope-from=bouncerc@win-desk.top; receiver=lists.ozlabs.org) smtp.mailfrom=win-desk.top
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=renliangliang.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=renliangliang.com header.i=@renliangliang.com header.a=rsa-sha256 header.s=default header.b=OBf/FMd6;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=win-desk.top (client-ip=85.120.223.179; helo=atl-15.jab.fad.pj156.com; envelope-from=bouncerc@win-desk.top; receiver=lists.ozlabs.org)
X-Greylist: delayed 3686 seconds by postgrey-1.37 at boromir; Tue, 25 Feb 2025 02:09:48 AEDT
Received: from atl-15.jab.fad.pj156.com (atl-15.jab.fad.pj156.com [85.120.223.179])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Z1kg00r3Gz2xYl
	for <linux-erofs@lists.ozlabs.org>; Tue, 25 Feb 2025 02:09:48 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=default; d=renliangliang.com;
 h=To:Subject:Message-ID:Date:From:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=z8uNq8GlAINvKunGTdIldZk7tfOJe0ZodWZrZoIk2aE=;
 b=OBf/FMd6AlHY03BNjWvJru8X9J8dgPY3kgpNbzt0+2vzhaDTC9aoO8bNT58NZv9ov1ecoEUsD06O
   UdB+dp0WdUdpk0w24w7Y/jtnmTmjXTANzv7xoNGFGL0baIF0XwzxTE4OhKgDMUK0379KV+X+KRpy
   5lZlT1Est3E5QS9LNAk=
To: linux-erofs@lists.ozlabs.org
Subject: the ultimate electric dirt bike for thrilling adventures
Message-ID: <c454f251c875974f5c5e0a54834e6ddf@bodenbelagswelt.de>
Date: Mon, 24 Feb 2025 14:06:04 +0100
From: "E-Factory" <factorywl@renliangliang.com>
MIME-Version: 1.0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FROM_SUSPICIOUS_NTLD,FROM_SUSPICIOUS_NTLD_FP,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_IMAGE_RATIO_02,HTML_MESSAGE,
	MIME_HTML_ONLY,NEW_PRODUCTS,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
	autolearn=disabled version=4.0.0
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
Reply-To: efactory@renliangliang.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

<html>
<head>
</head>
<body>
Hi,<br /> <br /> We are glad to introduce our latest e-bike: the Vintage
Electric Bike designed for adults. Combining timeless design with
cutting-edge technology, <br />this e-bike is built for those who
appreciate both style and high-performance. <br />Whether you're seeking an
adventure or simply a comfortable commute, this bike delivers an
unparalleled experience.<br /> <br /> We ship directly from our German
warehouse, ensuring your bike arrives in just 3-5 days. <br /> Contact us
today to purchase or for more information.<br /> <br /><img
src="https://cdn.trendhunterstatic.com/thumbs/502/unique-ebike.jpeg"
width="800" height="533" /><br /><br /> Vintage-Inspired Design<br /> Our
electric bike features a classic aesthetic that&rsquo;s sure to turn heads
wherever you go. <br />With a durable, lightweight frame and a matte finish
that exudes luxury, this bike offers sleek lines, sharp LED headlights, and
a bold front face. <br />Its wide body and sturdy chassis provide
exceptional stability, ensuring a confident ride on any terrain.<br /> <br
/> Powerful and Fast<br /> Prepare to be exhilarated! Equipped with a 500W
motor and a torque of 85Nm, this bike offers exceptional climbing power and
can reach speeds of up to 32 MPH. <br />Feel the wind in your hair as you
cruise through your journey, whether you're heading up hills or speeding
down the open road.<br /> <br /> Extended Range for Long Journeys<br />
With a removable 48V/15Ah battery, the bike covers up to 75 miles on a full
charge. Depending on your riding mode, <br />you'll enjoy a range of 65-80
miles in assisted riding or 35-50 miles in throttle mode. The battery
charges fully in just 4-6 hours and <br />can be conveniently removed for
home or office recharging.<br /> <br /> Versatile Riding Modes<br />
Whether you prefer an Ebike, Assisted Bicycle, or Normal Bike mode, our
bike offers 3 riding modes to suit your needs. <br />The Shimano 7-speed
system allows you to select the perfect gear for smooth rides. With an
intelligent LCD display, you can track real-time speed, <br />battery
level, mileage, and more, keeping you informed and in control.<br /> <br />
We ship directly from our German warehouse, ensuring your bike arrives in
just 3-5 days. <br /> <br /> Contact us today to purchase or for more
information.<br /> <br /> Best regards,<br /> Danny Louis<br /> The E-Bike
Manufacture<br /><br /><img
src="https://www.mobiliteit.nl/wp-content/uploads/2024/09/240925_fatbike-persbericht-Knaap_0003-2048x1536.jpeg"
width="801" height="601" /><br /><br /><br /><br /><br /><br /><br /><br
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
/><br />
</body>
</html>

