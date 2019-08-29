Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 7492EA268F
	for <lists+linux-erofs@lfdr.de>; Thu, 29 Aug 2019 20:58:25 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46KBhZ5LB0zDrby
	for <lists+linux-erofs@lfdr.de>; Fri, 30 Aug 2019 04:58:22 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1567105102;
	bh=OEZh/ctsesBRc/QtTLGBmAr/R4BSWdaJ9oRK1r9HLZw=;
	h=Date:To:Subject:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=bLAmkhDxAEjj+r9+mbBb6/9eOFbBQH7yRZXXFE0A/WB5/hKihAtxnxipF2dKTBO/C
	 CsVsonl0uVyNGKXqlSDQ1+ypfyC7B4tnuraJdXZyW7I1lspjxgc65xy/XoPW4bpjZy
	 fiGL3lchcAHcFS+vI3jlhwNzU+xS2/YqCKxMisH/7g3BqaJYfcCxvmfYPD/6eS4iKC
	 qw8X/1mJQqQxiPNwOO/IrnwEkWJXgiWJ1EkT8drBAf8/xb2CeroNSFHXC3ZTv+rV5U
	 9Lyd4+9/J/FVoCbO1G+PsJVsljf8P+R8Y7CZkRDZKIhadeW/hLg1ehC3hmt7mfeyWo
	 V7W5cFB/IjKxQ==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=aol.com
 (client-ip=77.238.178.146; helo=sonic308-18.consmr.mail.ir2.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.b="DAagERDO"; 
 dkim-atps=neutral
Received: from sonic308-18.consmr.mail.ir2.yahoo.com
 (sonic308-18.consmr.mail.ir2.yahoo.com [77.238.178.146])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46KBgZ4170zDrfP
 for <linux-erofs@lists.ozlabs.org>; Fri, 30 Aug 2019 04:57:26 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1567105041; bh=xvUFAFsLiQVngerBLgBQpnYPOm7q0BCalX6FGZiM+Ww=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From:Subject;
 b=DAagERDOXrHhMUC8zEcq68gmd0VDfcWX0hbLUvkchU472lelQqvE4xGhRwcIap1gw1U7VWAR9tN4oLe510R1614jkaT6rGwhaWjeC6Y9wd+fWOjU2f88hMHI3KXlHwhfHCmjJ6rHyLscVa+ejy1NVRFNGlaKESwezvxnjihcCQR9yGkUcm6FeW8cjJqd/4WP885Uth2uRjha7N0zPlUHdQPRBBzXRQvyObViDntYGqOKVuoZVWF0cV+1sk9A3vJ4/UyWKD8IopW53GoAMitDu81w4yb3+01jVbCJPRCnAe/IhNrheLwvesgDWJbBeBHK4U5baBnkhx5sgB4o10BZHA==
X-YMail-OSG: xR_woKYVM1naap7cqEV1L8CUGlYle8X5EFiEEsFTDvJ_B6Q_WpVmRKMxGFuAs_w
 MTW7BINu4UH.7oZDrB6s4TS2shswFwTKhoXPPFUZXjcu1SvHgOmJHoN_WKb9AMfcTDPTsEs4IH95
 9YwToRGQDRY0c1ek7drmu.IUZOwM722QE05q1Vvtpy7ty9yhEPh7PzAfBLG7FDqhH14XIbudPoJ7
 HpgrHn3iT8yOnz7fA3afkNouDCPaVzFivQF.HdCuFD8xJmO7.oQqR_9BQv5kBHb6mJYGmWwR3bQc
 II0bTNtP61ZRLwUE_nkAmkEjwHXh5Ej2vj2YWlpOGsTLPs9OA_O8E9iBbE880h_f4PH3ZxOxOH_r
 .A8rHaKQN19lBmDmw_JwpYt1MHDQmFpWG832BBXBCkfXRO3iuPu0uZvB.3MW71b2szl7ehe8b3Gq
 1aPHOhNOZgffGSl_mWiHq6ClZxIFowyju.R.C9I4WzatFtRyNIiSC.O9.f8p4sA5eZHc7ORYcsIq
 UNtGSaM60Pv8_XhitGftXkcL0EpEwMEDUJ6xfcCHMNwx3GiJmqPglbgPSBPL9iOOEBgJqqPJf1zJ
 UsRRBfV8D75SFqqbujZuehLmnvglfzIAcwrXq3m5p85Hjp96D2yXhgBVRexuxsW8n4hi0uu2Mvbf
 kk2EJ84LI1mq03MMxsgNEX0WAnGWMzHPZxbdB5hO9As8nJ8ecEBWQlz2ieBuBDaus4cMsI2yM6OG
 UdSn7RLq8uXtFpDXSSijAdCkbxVBLS_2s7aGLPlWmXKVHavLFoetKe95WS9emodRsknWumeMX_uf
 QiTcIKR3pwowCSS09aEYNDXEm.BA8V9I91JG2QBT7LzTDckKnCXetPrYODIM2koS.IvIc6TrRQ0i
 1bzZddGjdYGYbna.J5RPgR1eI_3.KJ3dEYRkg66pt7WKQ6tni0aSI4PH5ORjw0S8tvs_gznpRF3M
 ..KXIQ5oLUiqx6PiuJfo9kh7gM1DrRvUK.JtJ9zQNSzwV_n29q.TM6OimUke0_RM7c0aWUAKXyEG
 kuITRnwu0rilVIdI8_JKJ_ST5FUsL4FwiFomxNprLcG_p9liTFrFmdQczOgMJooq8XEO_VHFVXub
 20YYGxWAzbfsMm9DMmpHcWW7g72zDzaB_HB3dwdEvWOrdY2JqDkYi_qA07_r694OAerHM5w0QmFt
 W5ukpVPVVZ3MMtbiBSShmgC37M6K_dgcOBo51qBX3uI7XdA36PhFHBpvG.7ty_FB962Oj3E8eaFV
 HcmWgpPqn.ncxdFxqlHsKL.Y-
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic308.consmr.mail.ir2.yahoo.com with HTTP; Thu, 29 Aug 2019 18:57:21 +0000
Received: by smtp420.mail.ir2.yahoo.com (Oath Hermes SMTP Server) with ESMTPA
 ID 82b6ee7c086d1bafb8e1884cc30d4767; 
 Thu, 29 Aug 2019 18:57:18 +0000 (UTC)
Date: Fri, 30 Aug 2019 02:57:10 +0800
To: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH] staging: erofs: using switch-case while checking the
 inode type.
Message-ID: <20190829185706.GA21327@hsiangkao-HP-ZHAN-66-Pro-G1>
References: <20190829130813.11721-1-pratikshinde320@gmail.com>
 <20190829135607.GA195010@architecture4>
 <CAGu0czRasWHj53uF5zAoDRjbxU2sgN6HtazN_9Y-mkK6NjO-LQ@mail.gmail.com>
 <20190829141522.GA15562@architecture4>
 <20190829150436.GI23584@kadam>
 <20190829151352.GA100055@architecture4>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190829151352.GA100055@architecture4>
User-Agent: Mutt/1.9.4 (2018-02-28)
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
From: Gao Xiang via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Gao Xiang <hsiangkao@aol.com>
Cc: devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
 linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Dan,

On Thu, Aug 29, 2019 at 11:13:53PM +0800, Gao Xiang wrote:
> Hi Dan,
> 
> On Thu, Aug 29, 2019 at 06:04:36PM +0300, Dan Carpenter wrote:
> > On Thu, Aug 29, 2019 at 10:15:22PM +0800, Gao Xiang wrote:
> > > I am very happy that you send a patch about this, but we have
> > > to take care of handling "fall through" properly at least,
> > > and I don't want to introduce some extra compile warnings
> > > instead at this time.
> > 
> > I can't apply the patch so I maybe missed something.  I don't see
> > a fall through issue.  We have the code so you could use ^^^^^^^^ to
> > indicate which lines have a fall through problem.
> > 
> > > 
> > > EROFS is sensitive for now and I have no idea what the "real"
> > > point is.
> > 
> > What does "sensitive" mean here?  Now that it's out of staging we
> > aren't applying clean up patches?

Again, due to language obstacle, I have to give a detailed explanation
of what "sensitive" meant here.

I meant it seems all topic had no relationship with EROFS at all, but
someone mentioned erofs in different topics, I have no idea what is
wrong with EROFS, and I have no idea where it is like POS.

As your unlikely/likely concern, I think I discussed with you earlier,
in fact, most of EROFS unlikely is due to error handling paths, which are
meaningful in my thought.

If you argue that it has little performance difference, I think unlikely
in IS_ERR can also be killed as well since for most use cases in Linux
it is true that they are little performance difference at all. But I
think totally it will have some impact.

Anyway, I didn't find some formal standard about this, and I remove all
of these as you like.

Thanks,
Gao Xiang

> 
> Of course not, I mean we should avoid "fall through" problem
> but I have no time to verify this patch since I am fixing what
> hch said as well.
> 
> Thanks,
> Gao Xiang
> 
> > 
> > regards,
> > dan carpenter
> > 
