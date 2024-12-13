Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F3649F050A
	for <lists+linux-erofs@lfdr.de>; Fri, 13 Dec 2024 07:48:34 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Y8g0H6qfQz3bN8
	for <lists+linux-erofs@lfdr.de>; Fri, 13 Dec 2024 17:48:31 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=200.136.52.33
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1734072510;
	cv=none; b=eL8uNzoOH/pELxXcFEjI3VaQxUpsCeRo2pjkiF970AdPWrLXV4Inh2enSjrigznKzqOVi6F39ukrNzerJMT96+0fb709uQhnk3SakPa8omoVBnYpu1F/VOBFvBfVkI0ICK4WNV6KbpN3xfCAhRaB7LNGsYQbgYYXVYu8p+FBM4TLGqDCeLscBU+2AsR87mk1qvhLIggUKL7RLPLp2/+na0eaBg63wEK5jaR6BnBkCqJVb8A6oSnGcKyQY4bHX60fZFBwJ1znl9UCzu9RkYDqAzu2TX7rC8s7UTOF/4R1mjXJIOsHM4/KierXJjZOK9M2LuT7MGCoRwd4Wbqize85/g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1734072510; c=relaxed/relaxed;
	bh=Cgr97JBiSX1QIcd2ZZZsKVChGTY1ZlWJ/4AhaVFA7Wc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WqfDWcK1VApFXAv17YwElZqg+eFNn6uu9YWy+KdZJr0bzSdM7JvNJHI06ZMHRkQN31bIKxtxSrfE+4oqUi5Jfc07c46y0qLdBgvac/vrPTOOy0UxaW/WUuW6chrAI9Of15IG/Qtrhq2fCPGhYhyRc0PpyWP+r4PBbl5MG5smgKBgeUhhBC0bL0nxA/Ph11+/NRR59HRJJPh18v2Bq2z3sPaH4PiRnebjd9wl/OEInb9RadDdeqR6kQbi14Jm6uY6tqHCvEjDvY8a5pdZLn78jGcc1JNzZYkqA/A2HSK/6QhRkdThV9T4CyONgfLHdgjYX8ZSY/tTZOvGh7AL7I3Pjw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ipen.br; spf=pass (client-ip=200.136.52.33; helo=arara2.ipen.br; envelope-from=btv1==0775a20b9c2==tcwm179185@ipen.br; receiver=lists.ozlabs.org) smtp.mailfrom=ipen.br
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ipen.br
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=ipen.br (client-ip=200.136.52.33; helo=arara2.ipen.br; envelope-from=btv1==0775a20b9c2==tcwm179185@ipen.br; receiver=lists.ozlabs.org)
X-Greylist: delayed 1141 seconds by postgrey-1.37 at boromir; Fri, 13 Dec 2024 17:48:29 AEDT
Received: from arara2.ipen.br (arara2.ipen.br [200.136.52.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Y8g0F3pkQz2yL0
	for <linux-erofs@lists.ozlabs.org>; Fri, 13 Dec 2024 17:48:29 +1100 (AEDT)
X-ASG-Debug-ID: 1734071344-055fc729ec148a480002-dl881O
Received: from arara.ipen.br (webmail.ip.ipen.br [10.0.10.11]) by arara2.ipen.br with ESMTP id nm1sGEo0UjsYuMXF for <linux-erofs@lists.ozlabs.org>; Fri, 13 Dec 2024 03:29:08 -0300 (BRT)
X-Barracuda-Envelope-From: TCWM179185@ipen.br
X-Barracuda-RBL-Trusted-Forwarder: 10.0.10.11
Received: from ipen.br (unknown [102.129.145.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by arara.ipen.br (Postfix) with ESMTPSA id B6F8CFBE54C
	for <linux-erofs@lists.ozlabs.org>; Fri, 13 Dec 2024 01:25:17 -0300 (-03)
X-Barracuda-Effective-Source-IP: UNKNOWN[102.129.145.191]
X-Barracuda-Apparent-Source-IP: 102.129.145.191
X-Barracuda-RBL-IP: 102.129.145.191
From: <TCWM179185@ipen.br>
To: linux-erofs@lists.ozlabs.org
Subject: I urge you to understand my viewpoint accurately.
Date: 13 Dec 2024 12:25:17 +0800
X-ASG-Orig-Subj: I urge you to understand my viewpoint accurately.
Message-ID: <20241213122517.67DC087D7B8503BA@ipen.br>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Barracuda-Connect: webmail.ip.ipen.br[10.0.10.11]
X-Barracuda-Start-Time: 1734071348
X-Barracuda-URL: https://10.40.40.18:443/cgi-mod/mark.cgi
X-Barracuda-Scan-Msg-Size: 512
X-Barracuda-BRTS-Status: 1
X-Barracuda-BRTS-Evidence: 34fbb5788938ad5710ad28835fd12206-499-txt
X-Virus-Scanned: by bsmtpd at ipen.br
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=1000.0 tests=NO_REAL_NAME
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.45577
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.00 NO_REAL_NAME           From: does not include a real name
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_PASS
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
Reply-To: t.mazowieckie@mazowieckie.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

I am Tomasz Chmielewski, a Portfolio Manager and Chartered=20
Financial Analyst affiliated with Iwoca Poland Sp. Z OO in=20
Poland. I have the privilege of working with distinguished=20
investors who are eager to support your company's current=20
initiatives, thereby broadening their investment portfolios. If=20
this proposal aligns with your interests, I invite you to=20
respond, and I will gladly share more information to assist you.

=20
Yours sincerely,=20
Tomasz Chmielewski Warsaw, Mazowieckie,
=20
Poland.
