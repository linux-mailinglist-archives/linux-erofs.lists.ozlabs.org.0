Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A19BF10CDAB
	for <lists+linux-erofs@lfdr.de>; Thu, 28 Nov 2019 18:18:59 +0100 (CET)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47P49r5sQ4zDqDD
	for <lists+linux-erofs@lfdr.de>; Fri, 29 Nov 2019 04:18:56 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1574961536;
	bh=lP0FVBOOLlolrA4m6W12uHzPyejsp88sIGiMCc8X5ZE=;
	h=Date:To:Subject:References:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:From;
	b=f8xZi8014mserLZCYvbCBxj7bl3nAAUePkuv/ar3yEQanAL8slbuGkr+UTj8wQDHZ
	 RMbMOrvuOAgFVGCsdMUJWZYNUKwl6cz+G0xFn18VELpoJwyeun3sWgq1y4oRhhyekl
	 2dG0Q9PwMYmbO7MFetfs2MhqCXqlYG/4S1c3Yc2EvR48nJcl+0frbOriJIyhZJAwe6
	 gsOsvyqd3fJZJxl+WwcvopDeYWJ/2MyusvUw45BC9Q0YOyHGbQV0mKNM4HNpFiS2EY
	 POQ5LPqrMWsCEbNbfM3aRz8IdrLqmSIwYB70uCw3v2tdFgDuD873sJ0l5jcyw3NDOM
	 n2rjKPL1TGipA==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=aol.com
 (client-ip=98.137.65.82; helo=sonic313-19.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.b="h10ju8+H"; 
 dkim-atps=neutral
Received: from sonic313-19.consmr.mail.gq1.yahoo.com
 (sonic313-19.consmr.mail.gq1.yahoo.com [98.137.65.82])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47P1jX3TG0zDqvr
 for <linux-erofs@lists.ozlabs.org>; Fri, 29 Nov 2019 02:27:42 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1574954859; bh=BBopnqo6qohFLaZDooxmr9jLgdzlSTJflqclumYEoow=;
 h=Date:From:To:Cc:Subject:References:From:Subject;
 b=h10ju8+H2GjcW9b8CtTWsyLgQ+A1aV9j7mgiwYISBqkLVtZ9bSeEHfjw8xz10X5eKaatMYzrPvx+NeIf8Q/xIkGC2ZnvugK1X+88M61YMyC8q+fMHPc8t0pT8lfF0FP5vQ/0AQ5jc6CcFU/AARkCK748lMvtV0eJQA5ec2l+rWNq89dZLiygeGUzd/Avr4mAqxGmwZWlKGSfnkEx7098XVcOrCcL+piD40E4YIc9+nxVzsOFMmRMzii983RA+j83JdkcQpYsKMPDmGbY8HlH1ImMm+5JC9jy3tBoSR7uAWOpfyOqAWT+Tq526KW9xchL39hCFF14Z+IKUs0+yD3KbQ==
X-YMail-OSG: Xm6URX4VM1nRaeWmaNTm7ugAZVF1L..zbE2al1IEpUB6LFNtWbxbj7kKssMf3ZQ
 u6855OT2XAlkeoc9s.jbZ5pRjpzDaCZBbpYQRwjGQT5SqwO8RU6nrYngsHcwNMev24UHrntN2LfC
 RfOwA7jPdEXC8v0Wu5OciarIVZ42HzbBbNdQmwHh69_iv.zCrpQZwyyWOXjYJLXwyTjdgKSyDL3d
 SzA5DR_n1fMh_q4uxXvb6VeiMiUM0C.frGcJVur5ZejGqIbMOTriLRfFmlhqEOhiuVRGYPMYBicH
 mo6Qza1uphzTQDaoKSHn24QIqi9GqWFl_iUma86XgqMe87o1E9ucCst4O1.V_btr2ubB3XzEko9b
 Rw.EZLY42n..cbgL7v4r6Pj37V4bmFap56c8i6q4y0w8b5TwTUz2e7RHQiYCaxFdfcS8MM9Q20Hd
 c9t5BYXtG_hTcUaARsdRPiUDcDrULNxywVOsHy6RBJv_IxuqNibd94391R0NQpKEmvI0oujl.ulE
 q_zdzRMddCyfoIyXhR34NPo0hUw8318Dtv_1Wxj5VqLR5jRzrnAED39emgTV63el6xOrNcQOYR0Y
 2gxyXhMTY1XUgaI1Q3O1N5fE.gkdWf3SIOwcWdJzTkchmmLVriFpgxrg1n_wsaCF2ARxFs7flC77
 EvLXnktbStcSwUE8J87RkeebghSEEsCzB7ZTQtnoMSy2YcNXty.9XThCggTUXx3DWQtPfbiyoAkn
 M74jxHBL4QI6rv53NtX.3gKMUuVXPyGcnTjoKaOfHsJzOEY55Tah7ihCYrU0jGXHN0YQ.9Durc3E
 GsiWG4BYu9aBotsVbXGOEtnVxF1aOU.JGV0z7lIiPHnw8U9WzKW1BALEb1kZ_V5MtWWFA36J3VZV
 MT83bWHyACiqJ.ni3H7LKMvEqYaFMDJbWERynFvbf_HCWF7.Tr0JPySc.m0qW15TYIIF1spc7ORB
 wQyMDsLg417WhVOKmTviO4FWsVv4.G_Wy80RXIwqchVQcAQJMaJcbbl0jlB3FPndF8dBdsVsei3J
 kwulrVk43s2PCV8R2k9eM0_.j3cyebDCWE2dNIyFjbG1DhMpd9AScUXmnk6yO77SQz8pHEwvNAes
 t.kjcGagwuEEXebvtGtH86cIw7I.E3wYT0GLmYqXHlhRhgIfT8ZxusbHEwaZuWcXplj4ENJyUKwn
 QSqEfWi8P8sPc5_.nbJANbJQMNa1zVXEeqIGF927vXBRDDI78sTVAoPdPqvZICvYHiVXiYNBNNIT
 KxHLGOBCF__10cffNyDzp2FiaDL7Kr8xT4bjlAF19EC_Egn0y9L_mdSTCCd9MCotKKw19sflv8fQ
 XGeweunuehWEVgT5we1aSDaaIvtD1WgrXhEOjRNCbRTGMxSqF_u_9KXAgWYBVW_OwT.nrSjo-
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic313.consmr.mail.gq1.yahoo.com with HTTP; Thu, 28 Nov 2019 15:27:39 +0000
Received: by smtp403.mail.ir2.yahoo.com (Oath Hermes SMTP Server) with ESMTPA
 ID 3a3072f52d7e668a9fb4b87cdd2c6c03; 
 Thu, 28 Nov 2019 15:27:34 +0000 (UTC)
Date: Thu, 28 Nov 2019 23:27:16 +0800
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [GIT PULL] erofs updates for 5.5
Message-ID: <20191128152711.GA4993@hsiangkao-HP-ZHAN-66-Pro-G1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
References: <20191128152711.GA4993.ref@hsiangkao-HP-ZHAN-66-Pro-G1>
X-Mailer: WebService/1.1.14728 hermes Apache-HttpAsyncClient/4.1.4
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
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Miao Xie <miaoxie@huawei.com>,
 LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Linus,

Could you consider this pull request for 5.5-rc1?

No major kernel updates for this round since I'm fully diving
into LZMA algorithm internals now to provide high CR XZ algorihm
support. It needs more work and time for me to get a better
compression time.

All commits have been in linux-next and tested with no smoke out.
This merges cleanly with master.

Happy Thanksgiving!
Gao Xiang

The following changes since commit 4f5cafb5cb8471e54afdc9054d973535614f7675:

  Linux 5.4-rc3 (2019-10-13 16:37:36 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-5.5-rc1

for you to fetch changes up to 3dcb5fa23e16ef50b09e7a56b47d8e4c04ca09c0:

  erofs: remove unnecessary output in erofs_show_options() (2019-11-24 11:02:41 +0800)

----------------------------------------------------------------
Updates since last change:
- Introduce superblock checksum support;
- Set iowait when waiting I/O on the sync decompression path;
- Several code cleanups.

----------------------------------------------------------------
Chengguang Xu (1):
      erofs: remove unnecessary output in erofs_show_options()

Gao Xiang (6):
      erofs: clean up collection handling routines
      erofs: remove dead code since managed cache is now built-in
      erofs: get rid of __stagingpage_alloc helper
      erofs: clean up decompress queue stuffs
      erofs: set iowait for sync decompression
      erofs: drop all vle annotations for runtime names

Pratik Shinde (1):
      erofs: support superblock checksum

 fs/erofs/Kconfig        |   1 +
 fs/erofs/decompressor.c |   2 +-
 fs/erofs/erofs_fs.h     |   3 +-
 fs/erofs/internal.h     |   7 +-
 fs/erofs/super.c        |  39 ++++++-
 fs/erofs/utils.c        |  17 ++-
 fs/erofs/zdata.c        | 288 +++++++++++++++++++++---------------------------
 fs/erofs/zdata.h        |   8 +-
 fs/erofs/zmap.c         |  28 ++---
 9 files changed, 190 insertions(+), 203 deletions(-)

