Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A607AC2FB1
	for <lists+linux-erofs@lfdr.de>; Tue,  1 Oct 2019 11:10:15 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46jD4h3FWBzDqGJ
	for <lists+linux-erofs@lfdr.de>; Tue,  1 Oct 2019 19:10:12 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1569921012;
	bh=kn1FN48dWMtKd+RApOOahlyqJFzmSD4JxKWhCL3wSK4=;
	h=Date:To:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:Cc:From;
	b=EH50zIpgGcTifSvLHVTkIzJz7tJGkHim3DcKgNBWCXo7qpI6HgUEtevyUe+o3pTlK
	 SElm6Hfdhnl+nAyrhDLixS/tSbZTDFHTdRel8TStSBWVTY1zjQSiBpRahFUTPOpEH0
	 IfHU8e1Nr1x4b1T9mUIB4T1PezvEbBi0NunVHuIQzxnsPm8Qo8K4J4U0MmP9KmjVMO
	 QV92YxcYs28uYO5KYUgnqUbjt8wHBizyww1I4LiLWqcflCKxE9xOhmcrUnUXMapJcN
	 wXN3ZS4qV6wpE6jQ0+zUwW7pGmJ4JhRTqGxlcSGvwc3MpP19Z0pNlEkAul+305TWHS
	 AbbCIKR+1oVcw==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=aol.com
 (client-ip=77.238.176.205; helo=sonic306-19.consmr.mail.ir2.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.b="U61gxEK+"; 
 dkim-atps=neutral
Received: from sonic306-19.consmr.mail.ir2.yahoo.com
 (sonic306-19.consmr.mail.ir2.yahoo.com [77.238.176.205])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46jD4Y2LrRzDq6k
 for <linux-erofs@lists.ozlabs.org>; Tue,  1 Oct 2019 19:10:02 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1569920997; bh=/Hwz0MxqOic/tYrg0VLHTdYvhqlYjwGMfuUdJ4Fp1gw=;
 h=Date:From:To:Cc:Subject:From:Subject;
 b=U61gxEK+IDw4uA0RGTv14T/OvCrEnaFObS7Rk+qMd+ExdBGY4iLyWIlC9ZSN83BhK0QMpSTuMmI6/dEs6GsGKID32blYobZm1QfcsosYvlnXoqKzrOZZLr0DMZX+FZMU+Mj5AJvKPvxj6yVHjUNvxawJy5w39kF8Z0X+kG1s4GBstkyPsLq14SVJsStFw5T8fG1T2IjaH4GzM1nGQYcBntqDYlm2m9URDwKk3oBaO+dFyNvC3fpXHdOPgLsXrBoIQsVInYKwDVvddI3ZZYdQuhgEFaKgdyy0cAZRHf/ag2Gwa8105xX6EkMJh4DABGfpm4Um7CaJIADF4cpcAMHAwQ==
X-YMail-OSG: 5mUTXrMVM1k6R82NABifyxjoDszBtHVPR2e.tbio8GPgSirabd608Yq.SXoqhNt
 yNMRlGhgfg4LzQcXcl8W7ViIGWt0b4zzFl1I0e5sSciWQ0q3s5hid81LFyWRU0sSfirwtDUxovFC
 9eeOJ3ca5VS3CumyG6deR0Nzgf1qI.b8ga_1A9zymtOByx4DVjenHexP26aF26rAs7ye6FYFHAJS
 BVAVCeI63RZIE7Pl_Mk7_9iy55J0zfVZ1WD6GPzaT43cM3gg66VFJWXOG8afjFz9iV53pQ7vZTnW
 c5IxHP9xyU23x8Y4JV99QvpR1mzXv9mmM7Cj7OEKmImSDNUkH8YGI0cpCHVefT4MfjPWrPB1LVXe
 sMyRED5yXJGtLdeUCx9P.tSeddXvoNihEhWj20JDaeA0g79Hg2MpxJDH4lM4TyAz.6KCpEm_.4nN
 rvnhnC36KUorRfKGAtqOhnjx6Rq.I48tzo2UPOZkeiWcPq77EGIn_aQz3tRgt5QeDXqfGIiCi9HJ
 vaz22IZIZNCafrJEUkwgUsApkIZtzuuXARWrGfX587vNste_cfLhRuCjuGffvyuvjchDHiskDxhY
 14GTRaB1aht5citBSO9fpOSHndeB2SHGJYiJBpi47mGO._8cxiliKH9K73MIdgC0CqKPhNDjHOJd
 mtXgkXqJoM5lUMtXri1P7SXwTACgYvroesASs4TYcXJWYsLXJpeYvpaPgGPkDCUiZIa6sUwYopQr
 t2gXMc.EReqivzkzQPzuDgqT1YzmjR9ThIlaQoCmz.mMd_36G.uoKanct7Qnp_Ckgoxg9bCTasxO
 3_TmeDGFqmlvqeU8.0bAAvU5_9dYjt.d_BKX4zKS4Ezc9NqkIP_Xgj4UVpHaernyxqu5Nh2Hwkk_
 oCih6J_ocH_coPSAx23.1kFLaCILEJMZnwfB0qKUxnfv4aNK4DI4ZFIhMs.zZTQSazFuKGYBRtUO
 o0y0SLk7U652r8jGnpPtkwhXd1YO84Z3cxuPjq93_Gbs_XP04.jaad2dTPxPqoSshu3ZpMBN1RIm
 VKk0iBTH_kE9nwG6gJKJ66JwCYbwe1Z8m0oqfnxEIoQd1shsdE0dUO3ppFdTg8vNfrZch0eSQxLF
 Hy2fYdGwMSP9eyoTNWFrfK_yNrJXFVaNxBdgHraOd17yma8CHAX8ck7bO9IjPhFQG34DNnKzyQ0z
 o63v6mYlXQ1gGaeBL3Cs.BlNK98PcolUiyP1raRxfAi4C1NKV7qvqhk8PlJyUnvh0rA5A58s8Tky
 RTPnbrfgdISglKo89GLbP3Pvz_puVB64q8IKOS_DKavZ4NRz1J2Ac6NOoJXoiC1WFltjz70KJcGP
 K
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic306.consmr.mail.ir2.yahoo.com with HTTP; Tue, 1 Oct 2019 09:09:57 +0000
Received: by smtp405.mail.ir2.yahoo.com (Oath Hermes SMTP Server) with ESMTPA
 ID c999365307370019789162bfab3ecb7c; 
 Tue, 01 Oct 2019 09:09:53 +0000 (UTC)
Date: Tue, 1 Oct 2019 17:09:43 +0800
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [GIT PULL] erofs fixes for 5.4-rc2
Message-ID: <20191001090938.GA30542@hsiangkao-HP-ZHAN-66-Pro-G1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Miao Xie <miaoxie@huawei.com>,
 LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Linus,

Could you consider this pull request for 5.4-rc2?

3 patches of those address regressions due to recent cleanups, mainly
founded by stress test on latest mainline kernel (no more regression
out compared with older kernels for more than a week). The other patch
updates sub-entries in MAINTAINERS.

All commits have been in -next for a week (since 20190924). In order to
avoiding using a random base of a random day, I just rebased those fixes
on -rc1 stable point without any change, which are now in next-20191001
as well. This merges cleanly with master.

This is my first pull request, due to National Day holiday I'd use my
personal email. I refered many other past pull requests these days,
kindly let me know if something wrong...

Thanks,
Gao Xiang

The following changes since commit 54ecb8f7028c5eb3d740bb82b0f1d90f2df63c5c:

  Linux 5.4-rc1 (2019-09-30 10:35:40 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-5.4-rc2-fixes

for you to fetch changes up to dc76ea8c1087b5c44235566ed4be2202d21a8504:

  erofs: fix mis-inplace determination related with noio chain (2019-10-01 04:54:45 +0800)

----------------------------------------------------------------
Changes since last update:
- Resolve 3 regressions due to recent cleanups:
  Fix error handling due to avoiding sb_bread in erofs_read_superblock;
  Fix locking in erofs_get_meta_page;
  Fix mis-inplace behavior due to decompression frontend cleanup.
- Update sub-entries in MAINTAINERS in order to better blame.

----------------------------------------------------------------
Gao Xiang (3):
      MAINTAINERS: erofs: complete sub-entries for erofs
      erofs: fix erofs_get_meta_page locking due to a cleanup
      erofs: fix mis-inplace determination related with noio chain

Wei Yongjun (1):
      erofs: fix return value check in erofs_read_superblock()

 MAINTAINERS      |  3 +++
 fs/erofs/data.c  | 10 +++++++---
 fs/erofs/super.c |  4 ++--
 fs/erofs/zdata.c | 12 ++++++++++--
 4 files changed, 22 insertions(+), 7 deletions(-)

