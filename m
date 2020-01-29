Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B23E14C481
	for <lists+linux-erofs@lfdr.de>; Wed, 29 Jan 2020 03:05:23 +0100 (CET)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 486mz43n83zDqNW
	for <lists+linux-erofs@lfdr.de>; Wed, 29 Jan 2020 13:05:20 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1580263520;
	bh=D7IX4fx4E4IRshwCmL6MyaIUQK4/oQ1Aact0POu7XLQ=;
	h=Date:To:Subject:References:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:From;
	b=VaQjtL5Lk8+BB1kletZBqVdRjsmbCPsB5qiuK7y8fT0GMs8s8OSXWfO4V+ld62iwx
	 hi3nJw1btibrcMilcaLSHfxOoY8Sh1WY+ehSlxTvTIwJa+JDRA/a4Ml/zlVcad/Mm7
	 t9WS0PpveeKy6biHn62PuN2mw11/3fjOta42k20S7YwxuT5ljdBQZGsIj8lddFEJWw
	 H5Yr++lpLRv+CrHMRUCJUBArnfJRRVrbAy5vmLmpAu27t4EDuBc/AzGWIZ3dJqD0/m
	 5CJh5V0fzo7BeMle2YoQeIu04gnw1pbv9Id0KuQpPhkad7SbWn9NHOiB9l1kthnt+V
	 3qC+TMAvuvf8w==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=aol.com
 (client-ip=98.137.69.84; helo=sonic314-21.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.a=rsa-sha256
 header.s=a2048 header.b=e1EroSJN; dkim-atps=neutral
Received: from sonic314-21.consmr.mail.gq1.yahoo.com
 (sonic314-21.consmr.mail.gq1.yahoo.com [98.137.69.84])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 486myr6qkqzDqMN
 for <linux-erofs@lists.ozlabs.org>; Wed, 29 Jan 2020 13:05:07 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1580263504; bh=sYL6ZHN2CvlM1IdDrBrWu/a7XoJkY3p5D/tO15+rwAo=;
 h=Date:From:To:Cc:Subject:References:From:Subject;
 b=e1EroSJNRWZ8kxm+7PYZN7MwF6xvzHbiExOvrRQrWrwIOHzvo/8NV++nFeMrsVWL75sX+rc9kKDgSQY5nWuo0+NllKiJOMT5q2jVkF+/kkrtEhG/BVDkEzqdT05JtGHRHI/KcTKT0sVXxuGguvQGQxsdGstjWLXIkBjwJaWDYGcm5r8E0gkpfZaQR8+wbKGGqaL2UgVKvaASY2mVYtzTwVk5f+afOYK863IJqSMErli3sf9Jp0GLOaKmU1NCenQkqefsBMlvOk9CyJuve6ycsXrj6rkn31O06EdWCp0li9Clx+Rk7hQ5ROnn9heGh3AMIFPKhgr2kzSQ0TvCOaPmfA==
X-YMail-OSG: MM0T8YoVM1laGNf25r0JB4NT_.Aq6PW3p_8D72naMKanE7VJjo2F4bDapMtaB0w
 DG4AhySfhDU3NKJKdTwGfODEfRvYenP7jf375iURiUADoKksLnOwr4PCPNWK0k3Lu1LkhsPSKfv1
 9a4vlU5zDKp259k3NfPUF0uP0qNffutuH1Kc.RTH401M1BmnwVWBIaDmW52JLQBqHmMSEVR6tt5j
 oAzWwbMyFKyS_a6Kg4qmBPy9lCUtvEdrB8JcvNwgfnO1NL7N9B_m3dSDfmFHx3OsJbln0sey4WF_
 Jfhj1P6dsdxV5V4srX.v3quSBPOi12Dx7U3isi3PRVgSennZp7DfaoC7Pqu3QYJlFQR2PkZh6A20
 oa8gxDmpo6fNgayJFIbm8X7V1I5zVGIKY0cNkC1OumYyGSxzyCoT1fsQMNLyDwSjVMltPJyzJLev
 kpZw_eTra2F_UjIi1lMB8CUMiQVIxwXgk8zqT6fxqa0qEzAr1TY9QqmcIMxRSrAYDVTq3pHPyX6V
 60nfKFkxtKg0NH7q5xvgfGX6FCpQo5Ou0fpmxZRFo9PHZvlM69msTx1WrSKlbgKbDW75XGeprl94
 76_8eUH9p.2_exo93nivcTc1h6qg947OcGXYrpGMLmlgmSVatKv.aA5KHTS00cEGDb8H8vEiG1jA
 s4qH6eQE6yRlxGZ.kuxmXWnS6xMBKKX0MjEXjK4Es_GI0yvDhjvqQ6G_x.GmTMLNKGICYE8rSOPA
 IXKULkM7fOkmvIbM.QYSdQxwORCkYuXZ9JUcPwE6nx7mcTsWpsZJm3OczfbvfVb93h0MtVqt71.l
 mvonbabrBA3LScYMMb1CnZnBXKaDP7d5j67Dk3qNbmcKM0wOScn6etzg36lgFLMpZs5pTUm4CIHg
 3WfjBTU3QA4DBh_L3JV1ViFX0aiMOPXPGTYJl3tXkshopzm7347T1c0slT.izy_X0Ix9uVuA1loK
 SOfFVNEJK6q1RTkpxiAFehzWZAZjvJVrR2qvmtveIyhwSMLo52SCsfaonVSMQpEFnTIKW586zSkU
 ugak9p20ubEbdFJPtw5CEAC9rImfhZ_LOgdPvxCR5eotpTIOwxnq.yfPqxOmIPhfdM5aHW_wjX2R
 bVsgTOqmCBKwKfT1MZi2jx0_lXUgZ9dz.2CarxZal3rJQKJKOpt6bUyuvXyzuPfoMu1a7e3VMTDE
 VY5Tpf5s9s2FKSFbOqM15xjp.pq5kKxy.7y2zuWTUlz0lAwA0zUwJqvtAmhkPBF5UPivtjC5imbo
 UARbgWFiezK0MTHDVcnaQiHH5gRvEpehGyAOw2fIHVP9VcurKregm7yV5GbwUa8IGWdUc5X.Ge0h
 739Zx69mg27w8_9fYOc6nFQUrqNEXvPoYrCdUq58gARMjqS_VGPGcTis2UYx7eMoItMixPo_Mi3x
 vgyVy3QI.tuditxPLPlh8DR3JxPwFfwjjkwF4Lrgj
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic314.consmr.mail.gq1.yahoo.com with HTTP; Wed, 29 Jan 2020 02:05:04 +0000
Received: by smtp430.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA
 ID 43729e285804c5913db09e10a57cdd94; 
 Wed, 29 Jan 2020 02:05:00 +0000 (UTC)
Date: Wed, 29 Jan 2020 10:04:54 +0800
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [GIT PULL] erofs updates for 5.6-rc1
Message-ID: <20200129020451.GA5348@hsiangkao-HP-ZHAN-66-Pro-G1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
References: <20200129020451.GA5348.ref@hsiangkao-HP-ZHAN-66-Pro-G1>
X-Mailer: WebService/1.1.15116 hermes Apache-HttpAsyncClient/4.1.4
 (Java/1.8.0_181)
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
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Miao Xie <miaoxie@huawei.com>,
 LKML <linux-kernel@vger.kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Andrew Morton <akpm@linux-foundation.org>, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Linus,

Could you consider this pull request for 5.6-rc1?

A regression fix, several cleanups and (maybe) plus an upcoming
new mount api convert patch as a part of vfs update are considered
available for this cycle.

All commits have been in linux-next and tested with no smoke out.

Thanks,
Gao Xiang

The following changes since commit c79f46a282390e0f5b306007bf7b11a46d529538:

  Linux 5.5-rc5 (2020-01-05 14:23:27 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-5.6-rc1

for you to fetch changes up to 1e4a295567949ee8e6896a7db70afd1b6246966e:

  erofs: clean up z_erofs_submit_queue() (2020-01-21 16:46:23 +0800)

----------------------------------------------------------------
Changes since last update:

 - fix an out-of-bound read access introduced in v5.3,
   which could rarely cause data corruption;

 - various cleanup patches.

----------------------------------------------------------------
Gao Xiang (3):
      erofs: fix out-of-bound read for shifted uncompressed block
      erofs: fold in postsubmit_is_all_bypassed()
      erofs: clean up z_erofs_submit_queue()

Vladimir Zapolskiy (4):
      erofs: correct indentation of an assigned structure inside a function
      erofs: remove unused tag argument while finding a workgroup
      erofs: remove unused tag argument while registering a workgroup
      erofs: remove void tagging/untagging of workgroup pointers

 fs/erofs/decompressor.c |  22 ++++-----
 fs/erofs/internal.h     |   4 +-
 fs/erofs/utils.c        |  15 ++----
 fs/erofs/xattr.h        |  17 +++----
 fs/erofs/zdata.c        | 123 +++++++++++++++++++-----------------------------
 5 files changed, 74 insertions(+), 107 deletions(-)


