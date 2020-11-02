Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F7672A2EB5
	for <lists+linux-erofs@lfdr.de>; Mon,  2 Nov 2020 16:56:47 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CPyG3720HzDqST
	for <lists+linux-erofs@lfdr.de>; Tue,  3 Nov 2020 02:56:43 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1604332603;
	bh=PhEUIQrSr7tfgLLcTp7LLCafX5k/aSzfcH4Uvw7bJvw=;
	h=To:Subject:Date:References:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=fifunOQnenPzOG/1DQQJrRRzmpaoYGPDK7vm75pS/3/LqDMl+l9tRYlnQJURIslEZ
	 GKja+Zes/h/2E1vvZNoxKqUUuIiVHb6jUYN8zpdGuL+/QdJmKulQzC8QKMAyac9akk
	 A9ieJwRqbM5XCJReYOjMaDMiXk1yLSIwEZnedojRywCiBizTSBpwAPY3N6CPH1DgWQ
	 dn3gjJ2uEYOcV+EOEYfcOxaIbeKpltt7VO9IWKN9ZIO3RRTNjxFEWiLwyAMYcCHWaL
	 CE2aX4Rpc15i5viRJ3voF7i7pogpStRgeyT0yGuB/7cXkK79MMttoD2mmAgIQcxgzV
	 wieMI0iSqLpKQ==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=aol.com
 (client-ip=98.137.65.205; helo=sonic311-24.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.a=rsa-sha256
 header.s=a2048 header.b=SwbT7sZ2; dkim-atps=neutral
Received: from sonic311-24.consmr.mail.gq1.yahoo.com
 (sonic311-24.consmr.mail.gq1.yahoo.com [98.137.65.205])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CPyFn4QLmzDqNH
 for <linux-erofs@lists.ozlabs.org>; Tue,  3 Nov 2020 02:56:26 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1604332580; bh=nSV9oBroJklDtb21dcSWZsGIIugEVxZJ663kTEEwEbM=;
 h=From:To:Cc:Subject:Date:References:From:Subject;
 b=SwbT7sZ21r6V4xiyHHTrlag5vCozhf6rtidwTzttf2bQDXUqz2BdxU4BixbMnPkX2UgF2KBlzJmmxrYZPioigOhz7ioAhaFGZdkhY1y+8C182Mw4zfe5zthywJpJzYNXDMactozjxYZE76Gsvo2zQevGH7XS7dlA6slSu8aNhS4t7RmI/kVn7XTLle1atwCi7yra2yH3SWLqtf05RiUIGqXBXBg7Kob7eqGYXXB45Idve2eDDidINaiOf7423whHo0Dmk33QDPXcaTAPAh0lq2nmJrsGsbjkxiD0yYvoMEn8XAQu7z1w3e6mkP/LbVjMfTXUVtztV2lmsVCGMHQOCg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1604332580; bh=Z3S/dYhZdPVtpemnpL8B/SFMn/X6ypwpIVf8QdbPdXF=;
 h=From:To:Subject:Date;
 b=O/ziM3vQttewl32M16J7Bd0KelPZkJWXgU3MHz/9WhZ4ZEtbbSw6EfNIaTp8gRUwYWhDjdVkSC0SxSfnIxipHIwuxcqBCIyO0bgGvDcszj5kvpQg/S75HpYA3kHuH208K0bA5Dg4Bfvk2KGc8o+8BrrVCzszReaRKN6qZNK4hyrBuOU4pNbWtrUa08D503ea+piCvmlBg5sD0U5v3ne/uPwHyJI0BQOQenpeQlOswlebIxUxBGm2QEAX8wg2+PzZlzxtDrF8fdJhysy3k67naqsqlDuewUIJUwA9VcAPlhEiox3P4DuSI36MtIeXDzfBW1bilotZQ+NLoh/P67sc+Q==
X-YMail-OSG: QfK5pSYVM1n7aipvwPTNSbt091FV0PZ86dkD0UURk3pvTc5MoSofKFJx77LNOhU
 IvTnntmSHD3dOa3hlabKeS52h2paQ_mBuT_MSI4ZInUYH1WZUAcJei7ze.X9bZxUurr85HxRkqST
 MdAVvEGH2KcmyHSjlc_Wn8rSnFzhtFTPtFPgbAlO.1A56AIwMMrUtV.r4tsuksCNnVfaj_zI9O93
 x2qMLsd6.u9b.ZT.Jf2h7hVZb.ETyO1O2Lplhr9RWUAGH0_Ld9j7vpFBBPaiPAR3UWnzuyPHwtuH
 P3BbgAgg19fRitavCqeJ8QPgMzNUUDgeR.T0M8HoidAYmibIPs0fsEBscmaALWtfP.2fW8oqijTO
 lDZfQsS7JYx11VHtt1d7nOxE8D7r6Pyd.F..JTorytQf3lnMFGAhYO9k4R7RvVxgyphxXB..t5as
 YE7YrESiZpD24OkdQ0KXIcFe9DSSawUYdSl6p.YIji2V6F5tRzjggOFVqFWIcXTttW5L2aUEn41Z
 r1F9kz3CdO7Q4cb64RvRUWRaPA.BAx4cy1cq1MT5HO1cS92MMMSjLqWeqHZzRYHs8H7uWqvqSQXa
 tCRnihfNiJ1Lni7HrysuUmb5gxbBkoKF4Ps7Jflc2pR5Yy3_vOHqqVedlvG9yhH2ZOwqIXXWBQzj
 29ZSM2HBd9Nnx4B9c1N1yZPR21ne72HSRYHOeSq2dsV3tUU19Ej2mdKoFJzLsHqEKP5wQsBKV4it
 o80n54Vj62sZKHnqq39ulWQjcfrdG7zqdxiWKjkmvAsPb29u6omsCnyiC94jVJjhMzV38mWkkC6C
 nSqJn7NeSkg_CkE9adF6Klnt1rDK53zVSFbOJETV536lwfKgNPsTjVJppbdPJ7y2zemhK6JYQAKI
 UD.v8Mub5PfG.h2910Lqt_M9r3iRH_4yfQNoVzeYOQt1F2kocOrDv3NPrgLQsG3Sp.rLFeMD7T4o
 8SMKv_WXCiNsN75xGyXa9MRzrcwekxKyLZr9mJdNktwdjV0l.oz40p_nBDVCb0YKKF51vNxfyHBW
 ZWoOQ0K.WdEsdIA_8YKiq.oTfRyUXH95.WaFolDIMxOAgRwqlame5MGjR5GOhH.Y2YAxPNMccm.z
 Qrwv6K67RYVLExE1Lgt9PpdQd.RFUOgTDRlzo4mdnlLPsLgIb0P7kvUYgdOf8cQM_59kPXd0aSXM
 FZLDgab_524qo9G6iz2G07bklR.Rpp4ZX5cp_.cxwPDsxKzccQbh_6nWs1qzfDpulqvFM1_QNav1
 uYNbiEAlRLBsq.ACPF4WWNyt6uvlKM_SaeT_u49sIx1GQ5MnmnUxbeUUxQX6jPwMzcfE59likJ6H
 L_S6T9flBGuKPmb9m2K0W0WDdwPWqlpQoCKaRLbnaR97.8ZJ_k_nxU9t0yK5g7H.qseEVvPdoREC
 CyZvkLo6PwBeaYZs7suRbXSCgXv4DhKiwoARr171qAZC_nHKgCxv.rD1HxPsQt1KkvE_Xb9pqoc1
 0PVnEsDROlylGmKDG.IMA4hcEcrIYdBZPOU..MG6VoVaBeBxhPhNsVIKyYWIn1aL3Cy3cHliJ.k3
 hnIWSl0gX07Mn2Ll0f1KMtybZAoG.6aY2ncnCbZ2hImgCDOCl9d85HiM8dtqCh7kjJp81pSa8SGB
 Ak9Z2HcJviLZnRl8li.bXGY0yLNukVMcT6lFNX_Ml8oP61enb16LefRB3CUXaVo2PQOr2vsYRq8B
 KUrY0KHx28Ekf9jiV3QoUxFhmvHLurvQYao_Pe6lWCQuy3Q.EwSSHKGpBTR7yeZGw7F1BixkGP_Q
 tnVzKjmwPSyLZz7CN3oQ635nXyu7qY_yZai6DnDIFOT_coDhJFSyYpKQxORj5PaolSR3W0Yka1tI
 vS8QzoUdTnms4ZFZlSYxkbU84z9oYDPkey6uTQce_7vHhXvmGOqZbChehqAV38vvQ7xLW70GJ4ic
 FVO4MEli9Z0_JrxCHaJnHy9ehoWtmAopeQSIeGsLtZMedSuBwfqPn_CEgXhmXfQsnSOYrSIZM033
 xVTSj2IpuCWL5wul2P6qMhZ12TeipUPwshGg3wBhaZ0wecYzdney9Nr2GMMLtYzG7_LHgZJEUO5y
 uH_RlV19k6hUuDV4VrMAulecIcfj9xwXj8AMYtnhJTt80N4BavJlQXnWzjJOKowKgJCm3TNqMpk8
 bONyrSesGoRIjGEI.xZO_8aYIThjs_vMZZgDXqG_YxMqVbZWhokY5l35u3uazyGsXS4McS97YqkH
 eP.V.CrUex.r66OAxftvKZZ14DjA4GqqC9PEAcm2bmFyNGdYOBooop5jPRnH7F5YygMiRb9vvMmE
 ToHmsAaqZGoKX7wZLmq.Fgmws_OQ6eipC3IuUJqbhigU4Socmw_k5HeCQ2z65WDrG9POiheF0.GT
 Z752jC0shpdEC73OlTV2XcrAoBadDiDa0pAZMtpEU7kX7TfJ35HSFs3EJjar68Rxnb.Qm.c9XiAZ
 Q81Thc0LKdFJWO_T2O3EJtju9vhXZ5YgtGwaQ5XkHHFr2DMWHvvIANjP506jb3pdCzGlFsiC7jbq
 3EE_xTKhFxvoiHVWECisUnsfVFrS5YPHVxcERbzCNho.SeyEVcKrQ6WAZDHcXU7jtmWzeadOzzsa
 n5wD8IjjhO6R7GPbG7sA89OXqGAfmeVjeTxmBQ27Xt1TUDDOinn35O8uKiBLxePhFM_j9jf9kB3G
 fLTtgvQLd2msPZ1c37uZ_wQd9QILWvJBFeliWN8nOPaU-
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic311.consmr.mail.gq1.yahoo.com with HTTP; Mon, 2 Nov 2020 15:56:20 +0000
Received: by smtp404.mail.ir2.yahoo.com (VZM Hermes SMTP Server) with ESMTPA
 ID 0de93bd81f6e7581799539af1246db07; 
 Mon, 02 Nov 2020 15:56:17 +0000 (UTC)
To: linux-erofs@lists.ozlabs.org
Subject: [WIP] [PATCH v3 00/12] erofs-utils: introduce fuse implementation
Date: Mon,  2 Nov 2020 23:55:46 +0800
Message-Id: <20201102155558.1995-1-hsiangkao@aol.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20201102155558.1995-1-hsiangkao.ref@aol.com>
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Gao Xiang <hsiangkao@redhat.com>

v2: https://lore.kernel.org/r/20201024130959.23720-1-hsiangkao@aol.com

background & v1:
https://lore.kernel.org/r/20201017051621.7810-1-hsiangkao@aol.com

kill a lot of insane logic, and hopefully it can get into shape
in the next iter.

Thanks,
Gao Xiang

Gao Xiang (9):
  erofs-utils: fuse: refactor raw data logic
  erofs-utils: fuse: kill sbk
  erofs-utils: fuse: kill nid2addr, addr2nid
  erofs-utils: fuse: kill erofs_get_root_nid()
  erofs-utils: fuse: move erofs_init() to main.c
  erofs-utils: fuse: move superblock logic into lib/
  erofs-utils: fuse: kill getattr.c
  erofs-utils: fuse: kill open.c
  erofs-utils: fuse: kill incomplate dcache

Huang Jianan (2):
  erofs-utils: fuse: add special file support
  erofs-utils: fuse: add compressed file support

Li Guifu (1):
  erofs-utils: introduce fuse implementation

 Makefile.am                |   2 +-
 README                     |  28 ++-
 configure.ac               |   3 +-
 fuse/Makefile.am           |  14 ++
 fuse/main.c                | 205 ++++++++++++++++++
 fuse/namei.c               | 237 +++++++++++++++++++++
 fuse/namei.h               |  17 ++
 fuse/read.c                | 173 +++++++++++++++
 fuse/read.h                |  17 ++
 fuse/readir.c              | 121 +++++++++++
 fuse/readir.h              |  17 ++
 fuse/zmap.c                | 417 +++++++++++++++++++++++++++++++++++++
 include/erofs/decompress.h |  35 ++++
 include/erofs/defs.h       |  16 ++
 include/erofs/internal.h   | 104 +++++++++
 include/erofs/io.h         |   1 +
 include/erofs_fs.h         |   4 +
 lib/Makefile.am            |   4 +-
 lib/data.c                 | 117 +++++++++++
 lib/decompress.c           |  87 ++++++++
 lib/io.c                   |  16 ++
 lib/super.c                |  79 +++++++
 22 files changed, 1709 insertions(+), 5 deletions(-)
 create mode 100644 fuse/Makefile.am
 create mode 100644 fuse/main.c
 create mode 100644 fuse/namei.c
 create mode 100644 fuse/namei.h
 create mode 100644 fuse/read.c
 create mode 100644 fuse/read.h
 create mode 100644 fuse/readir.c
 create mode 100644 fuse/readir.h
 create mode 100644 fuse/zmap.c
 create mode 100644 include/erofs/decompress.h
 create mode 100644 lib/data.c
 create mode 100644 lib/decompress.c
 create mode 100644 lib/super.c

-- 
2.24.0

