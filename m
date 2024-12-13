Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 495019F1331
	for <lists+linux-erofs@lfdr.de>; Fri, 13 Dec 2024 18:07:16 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Y8wk15GMJz3blN
	for <lists+linux-erofs@lfdr.de>; Sat, 14 Dec 2024 04:07:05 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=93.119.104.100
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1734109623;
	cv=none; b=SNBbsHS56iUls6UZFnggSgdiYrFGt0/wpwhVeWx5p28eLMPbsGZ99q1mZSTlCd+33dPbyJHok2hzjw4Dsxa3Xi0zXfxvbRBEipl3irrCFEK986ZLf4aCpliD/tJllvSj+l+f5uRFpg6HhAgHj3SHapLg13nnP+FRLFPrK9PKNrlNbtg1ohkB+WyXqFoMyy6mQqExOZQhc7hp1BuAJcIFF67VyW16kunNOvcv+SmOGPeELMa1ykt4P4lTAvS9ZeScB3o2E3kLdqJ5skPGNKlJHijjdBbi4jj/w8bWkMNnrf7UOz07Mdtarw06A6RPKQ+hGPlzTJmy/FWBumP13Aojdg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1734109623; c=relaxed/relaxed;
	bh=xUZjC1S59kIz0WSnE2jn4ZYi2PhK1kqmAt7b5FbPJ+U=;
	h=To:Subject:Message-ID:Date:From:MIME-Version:Content-Type; b=Cc2NHzurTnOrL7hlvg5FVcQjWR/pRsMNyi76Va4k6kgpvBjgHmwLCaNsbxCO+WLKpUZE0yATrmFCueiQQ5r8nf5kVQqLA0KpNm2LNkepnby9h7nr16BWMN27fD+ERmX22Oqx6ypTrI/ZDJI2571QUBZkzUu7aaJILPuyGchxBdN8oRD45lU9iKPdEepXWQEKB/HSSZT4WLLomp31V0i3Qd2RPr3dX+1EouNqitF6A1RqSMLguctII75aK2gcmq6MExRDX+9BE9JK0/a5uNcZsEwV0XDa/Zy1IgdJYFYy3uoHtO8jHnSgrvKLYPeLgqIe6PX0T7YvZGgc+P8FL/qTjA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=iqiwang.com; dkim=pass (1024-bit key; unprotected) header.d=iqiwang.com header.i=@iqiwang.com header.a=rsa-sha256 header.s=default header.b=I3OvUPHq; dkim-atps=neutral; spf=pass (client-ip=93.119.104.100; helo=mta7.rev.dc985.cn; envelope-from=eustocksz@iqiwang.com; receiver=lists.ozlabs.org) smtp.mailfrom=iqiwang.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=iqiwang.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=iqiwang.com header.i=@iqiwang.com header.a=rsa-sha256 header.s=default header.b=I3OvUPHq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=iqiwang.com (client-ip=93.119.104.100; helo=mta7.rev.dc985.cn; envelope-from=eustocksz@iqiwang.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 130 seconds by postgrey-1.37 at boromir; Sat, 14 Dec 2024 04:07:02 AEDT
Received: from mta7.rev.dc985.cn (mta7.rev.dc985.cn [93.119.104.100])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Y8wjy2PBZz3bV6
	for <linux-erofs@lists.ozlabs.org>; Sat, 14 Dec 2024 04:07:02 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=default; d=iqiwang.com;
 h=To:Subject:Message-ID:Date:From:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=xUZjC1S59kIz0WSnE2jn4ZYi2PhK1kqmAt7b5FbPJ+U=;
 b=I3OvUPHq//xxHAXLGJL0lD0+d7GX6Y/Jacd+KiCXyM8WAD3aWazT/oB258/lki8GzbjAudaC5UCr
   Q+/YRPXlVHVbiDJstByfAjrJlvdgvZ5+7RKiO+cHOjkwDSdYUv5L/YbdOE8S92FEkzi5UuJCadE5
   UmaHSnyCElSpdLLD/48=
To: linux-erofs@lists.ozlabs.org
Subject: fat tire electric bicycles
Message-ID: <d13dbfcc8614a13dba233b3af18cc6d4@iqiwang.com>
Date: Fri, 13 Dec 2024 14:55:15 +0100
From: "Darren Young" <eustocktr@iqiwang.com>
MIME-Version: 1.0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.0 required=5.0 tests=DATE_IN_PAST_03_06,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_IMAGE_RATIO_02,
	HTML_MESSAGE,MIME_HTML_ONLY,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
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
Reply-To: ebicycle@super87.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

<html>
<head>
</head>
<body>
Hi,<br /> <br /> As the holiday season is fast approaching, we want to take
a moment to send our warmest wishes to you and your loved ones. <br />May
this festive season bring joy, peace, and exciting new opportunities!<br />
Since our establishment in 2014, we have been a leading manufacturer in the
electric bicycle industry, committed to providing innovative solutions for
modern, eco-friendly transportation. <br />We are a fully equipped factory
specializing in the production of electric bicycles, electric motorcycles,
and mobility scooters. <br /> <br /> As a manufacturer, we control every
step of the production process, ensuring that each product meets the
highest standards for safety, performance, and durability. <br />Our
commitment to innovation continues to drive us to create top-tier electric
mobility solutions for riders of all types.<br /> <br /> We are also
pleased to inform you that we have a warehouse in Germany, allowing us to
offer fast delivery to customers within the EU. <br />Orders within the EU
typically arrive within 3 to 7 days, ensuring that you can enjoy your new
eBike as quickly as possible. <br />For customers outside the EU, we ship
directly from our factory, with an estimated delivery time of 20 to 30
days, depending on the destination.<br /> <br /> If you are interested in
purchasing, please provide your address details so we can check the freight
charges and send you an accurate quote.<br /> <br /> We are excited to
share our newest electric bicycle, which combines powerful performance with
a smooth, comfortable ride for any terrain. <br />Whether you&rsquo;re
commuting, exploring off-road trails, or enjoying a weekend adventure, this
eBike is ready for it all.<br /><br /><img
src="https://www.ebikesexpress.co.uk/cdn/shop/files/Rocket88SFatBoy-SuperMonkeyElectricBike-250w-BlackFrame_5e9c539c-5764-4daa-82ce-2ab8ea898876.jpg"
width="800" height="800" /><br /><img
src="https://eridefox.com/wp-content/uploads/2023/03/Ouxi-V8-Electric-Bike-ZBC-_00146-6.jpg"
width="800" height="800" /><br /><img
src="https://shopcdnpro.grainajz.com/1300/upload/product/8788e0c92cf0b91789adae756d37ef342b4d75a0cd91d72f0f17aa71675a9b3b.jpg"
width="800" height="800" /><br /> <br /> Here are some of its key
features:<br /> <br /> 1.Powerful Performance: The 48V/500W brushless
motor, peaking at 500W and offering 55N.m of torque, enables speeds of up
to 28 mph. <br />It&rsquo;s ideal for off-road enthusiasts, daily
commuters, and anyone who loves a bit of adventure.<br /> <br /> 2.Extended
Range: With a 48V 15AH removable lithium battery, this eBike can travel up
to 47 miles. <br />In pure electric mode, it covers up to 34.17 miles, and
in assist mode, the range extends even further.<br /> <br /> 3.All-Terrain
Capability: The 4.0 x 20 inch fat tires and full suspension system (front
hydraulic and rear air shocks) ensure a smooth ride on any terrain. <br
/>This eBike is perfect for off-road adventures, tackling rough trails or
even sand and snow.<br /> <br /> 4.Advanced Features: Equipped with an
intelligent LCD display that shows real-time data on speed, power, and
mileage, along with 7-speed gears for flexible riding conditions. <br />LED
headlights and rear brake lights enhance visibility and safety.<br /> <br
/> 5.Safe and Quiet Ride: This eBike operates quietly at just 30db,
ensuring a peaceful journey. <br />Front and rear disc mechanical brakes
provide smooth and reliable stopping power.<br /> <br /> 6.Certified and
Reliable: The eBike comes CE certified and 90 percent pre-assembled for
easy setup. <br />It also includes a one-year warranty on the motor,
battery, and controller, with a professional customer support team
available to assist you via email.<br /> <br /> As we head into the holiday
season, now is a great time to consider adding this eBike to your product
lineup or enjoying it for personal use. <br />We are confident that this
model will meet your expectations for both performance and quality.<br />
<br /> If you are interested in purchasing, please provide your address
details so we can check the freight charges and send you an accurate
quote.<br /> <br /> Wishing you a joyous holiday season and looking forward
to a continued partnership in the coming year!<br /> <br /> Best
regards,<br /> Darren Young<br /> The Manufacture of Electric Bicycle<br />
<br /> <br /> <br /> <br /> <br /> <br /> <br /> <br /> <br /> <br /> <br
/> <br /> <br /> <br /> <br /> <br /> <br /> <br /> <br /> <br /> <br />
<br /> <br /> <br /> <br /> <br /> Send address to unlist<br />
</body>
</html>

