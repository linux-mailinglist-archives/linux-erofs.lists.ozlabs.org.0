Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 216AD9B4069
	for <lists+linux-erofs@lfdr.de>; Tue, 29 Oct 2024 03:27:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1730168876;
	bh=+5vh7IMjqeg3OgZBQNuRDxCjJXPgdVT6rqCrcGbGT80=;
	h=Subject:To:Date:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:Cc:From;
	b=CHMmyeViE8krZEAbijrLU5TVpsZa2t+veYLQM2xEpXCm5dAz3e6jQTOspc7PT/HvR
	 F7VKi1N0Io9+tlQjPddh0yX2NOEbWGQuBAjt25NmugLLd8xXyYqbcDQAnKswwyzKWn
	 eiISixkXZ4jLs+chGWicVoPK8NNnzagqREMJwrc7Yd4hxxtmgrEWC8gQ321JYit6J4
	 QJEDf8G29ieylyhF0DdddIcI420GpbRhlbZED2uWehpglOuBH7XShlw3XV054oecki
	 KVwD5oer52XsYkL+d7a4hN4AM0ZRd/Wl9oxBM0t8hYc1Tq/9g3FJdebJwRdqnXPGIt
	 41KbQvoYTGeZA==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XcvLN0l4dz2yYk
	for <lists+linux-erofs@lfdr.de>; Tue, 29 Oct 2024 13:27:56 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.185.126.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1730168873;
	cv=none; b=eFQdvivrQ3pTIDQrH587bEr/mkJHPTmly27ZI944xe61UeX0beb3b1B7n/NPp7BohYt9IkoBw8ZCX+z0d73IsC6cYJWxs02P1e6gHHE+siviR5eKF6Y04yI5hugZOYVqE2H5yPlTBxdXytWIJRbXAujg5vRRRpOsLY+papxbJdQovGj1LOJ2H4YKygc7MEl4L3v3utzLKTjwT8UAJocZ44iqc4rl+naywrzhIMMoCO3VoTSS+7DO5S4Eu6Be8wpZpI4hoKB6sRYtcw+h3azG7brut5jH6issNjQhuLtQ98JWV7wZphRGlsv7pWSw26oGUcEKaL+PEdUMcd4jopngSg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1730168873; c=relaxed/relaxed;
	bh=+5vh7IMjqeg3OgZBQNuRDxCjJXPgdVT6rqCrcGbGT80=;
	h=Content-Type:MIME-Version:Subject:To:From:Date:Message-ID; b=ICZyI9crSFQbak20xB/V53AV4rIWeT8RmWQlRYUvn/xho1/Wdxyr5VYmnVrMp9osmzGzDpdHd1dm49S/JDR53tMhg8/ViohOqc10XaqHvIbzzgP/1ytnUTruB8yHORGyuRuvJYxe6U47YFOFbGQuYy0AwYhYFR5gbOALomgstLMxS0J3W4Dvpvhh8hr6ebNcrbzd+yJgJvUHyEAIHnNs47rvndiPxiQCFyDVHQhlXU9w1yEaXXK3pIk0YjHt8JpjVp4Nk2mpNlK4luEpgl5nm5k70M5ebPsMKPkVnEazLGbVriIfG3z35F/vtrK38Y6UDIYSmma1cQkRKK140cnkmQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=ukraine.onlinesales.wheatseed.shop; spf=pass (client-ip=205.185.126.254; helo=ukraine.onlinesales.wheatseed.shop; envelope-from=evanbohdan@ukraine.onlinesales.wheatseed.shop; receiver=lists.ozlabs.org) smtp.mailfrom=ukraine.onlinesales.wheatseed.shop
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=ukraine.onlinesales.wheatseed.shop
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=ukraine.onlinesales.wheatseed.shop (client-ip=205.185.126.254; helo=ukraine.onlinesales.wheatseed.shop; envelope-from=evanbohdan@ukraine.onlinesales.wheatseed.shop; receiver=lists.ozlabs.org)
X-Greylist: delayed 82 seconds by postgrey-1.37 at boromir; Tue, 29 Oct 2024 13:27:51 AEDT
Received: from ukraine.onlinesales.wheatseed.shop (mx.ukraine.onlinesales.wheatseed.shop [205.185.126.254])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XcvLJ02w0z2yDx
	for <linux-erofs@lists.ozlabs.org>; Tue, 29 Oct 2024 13:27:51 +1100 (AEDT)
Received: from [205.185.126.254] ([127.0.0.1]) by ukraine.onlinesales.wheatseed.shop with Microsoft SMTPSVC(8.5.9600.16384);
	 Mon, 28 Oct 2024 19:25:50 -0700
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: Re: Dear Respectable, I wait for your response to this my message
To: linux-erofs@lists.ozlabs.org
Date: Mon, 28 Oct 2024 19:25:50 -0700
Message-ID: <WINDOWS-UO5E16EjVfu00032e8d@ukraine.onlinesales.wheatseed.shop>
X-OriginalArrivalTime: 29 Oct 2024 02:25:50.0127 (UTC) FILETIME=[DEC5ABF0:01DB29A9]
X-Spam-Status: No, score=2.5 required=5.0 tests=ADVANCE_FEE_4_NEW,
	FREEMAIL_FORGED_REPLYTO,SPF_HELO_PASS,SPF_PASS autolearn=disabled
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
From: Evan Bohdan via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: evanbohdan@gmail.com
Cc: Evan Bohdan <evanbohdan@ukraine.onlinesales.wheatseed.shop>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Good day,

My name is Evan from Ukraine.I have tried to reach you but find it difficul=
t due to internet scarcity here in this town.
I am contacting you because I want to come over to your country,I have some=
 huge funds I plan to invest in your country because I want to relocate my =
Late Father business due to ongoing war in my country Ukraine and visit you=
r country to set up new investment business you may advice profitable in yo=
ur area.
I also have some millions of dollars belonging to my late father that i wan=
t to invest and 995kg of 24+carat 99.9% purity gold I want to ship to your =
country and establish gold jewelry manufacturing company.

I will offer you good monetary rewards for your help,due to how russian dro=
ne bombards this town frequently,internet network is disrupted because of a=
ttacks on network installations,please for fast discussion, you can add me =
on whatsapp and let's talk faster as i want to leave this war zone as soon =
as possible,this is my whatsapp number below.
+380-672575220
Email:evanbohdan@gmail.com

I wait for your earliest response.

Regards,
Evan
Whatsapp/Tel:+380-672575220
Email:evanbohdan@gmail.com
