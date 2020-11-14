Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F3DC12B2FA5
	for <lists+linux-erofs@lfdr.de>; Sat, 14 Nov 2020 19:26:07 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CYP0s00f0zDqS2
	for <lists+linux-erofs@lfdr.de>; Sun, 15 Nov 2020 05:26:05 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1605378365;
	bh=eVMDM9e54SkziMoR4fnUZmhzP55lhiXvDPC8QerhUag=;
	h=To:Subject:Date:References:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=apx/dy06KlcqA+zwtLWzNNcQ9veYsI/rCmxlyDhO2nSzDsOInINIcxCIC2yajo2xg
	 WzZcq3fWeUoOT/+XdSk2gwY8xpHfEODRkxj9QVm4mo/2Z3Mnr9M2HmD5kqnemuBdCc
	 LpuxclvacFqDCRqReJB34Ai2aqqfA2ldF+XROCVW0p0XhiZPPHJHJ1yOISYRBt9mm0
	 s57hS8CyMqMUXjJs3KMVUuYTF2fhEUfKElTjrsoSQ2mbQ48iWK20FSD6//EATehylt
	 K+dyLtaQAnYIknBstX49yNkyauxg8EADLKekMpzZwGDBLpfDI/4K3cBEWJ5D7CP5W0
	 d+3zHgKTDfHjA==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=aol.com
 (client-ip=98.137.65.30; helo=sonic315-54.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Received: from sonic315-54.consmr.mail.gq1.yahoo.com
 (sonic315-54.consmr.mail.gq1.yahoo.com [98.137.65.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CYP0X2NfPzDqRs
 for <linux-erofs@lists.ozlabs.org>; Sun, 15 Nov 2020 05:25:45 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1605378336; bh=SEMtw1L0x8/jamfwRlbkhLKlc5l9yuH3IdQHkIJ2KGg=;
 h=From:To:Cc:Subject:Date:References:From:Subject;
 b=rligTdocyR9ab+ZwmJXI2kIgWXQH/Ro4UDxqzIPlHyKqYdbRjZq37MbXoPH7GCojHB4LuFTLuYBkna23G+Zkc975XtwC/vhtYEkpqWfiKwh0g/XhleAZ7yBIiSM9lbypW4eHwx/gNc2Wc4mp7MMRhzAZcgpbG4JejgwaYuKLS0EvGIY9BBd0SAa04Oq4X+fjNZhGw/YheCNxs+G0ufk1qa/giOMqjOQ+kJ2hc6lyMnitlY/UulV6qZTpaFVkKw2jdw0DmntTNd/Wa7w5X4Z/nAWmGwPJWMYwASbZVYy895Vjc/TVnwGB7s7rBR3sGyWe5fEcMDBFrN68cPX46jTFJw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1605378336; bh=OUxAq+UzY1qhvXtQpinsLSoJ/XjJQ57TFGP1+1raDI3=;
 h=From:To:Subject:Date:From:Subject;
 b=k+Y7Eonoidglfb/cNrqBgq3gEv1F1zz1CXg2oXptJxa7kX6epPc44zechA+ZRlANW3JjQ3XgbtGcM5xDwGMJcGtRYU9WzsqzVRZU60fJFt3jUksdrcw05zRsCXlTYeQ+KIuhJHZ4uvaqLtxsIndo7nRemkKUVTvErg31JEyY7dlvhk3/tgRx/lSd95QIfY6ZQABA0wNLpp3vFdpt0iKdJ7fhpKgPutWCY6p5PETJjnjlpJQN8WbrW3lmH1wnCvPcp2LP1Oyp+7xX578/MMv+CVnr6pQYzFM11rv7abEMWqCuuUWPnpdkkupoiII5sVQkd677FxnmpKjFsaxqD6/skQ==
X-YMail-OSG: zBCevrkVM1nd3jNd4YF0W6kNP9hlL4GmGDr12gD._IJDaB9vNQ5rnWVsdAxPpAN
 X7rWSNNCq8XIvQUZJggYSf1YnonnpLe2Nb2yu7ahyuz0ypyZWaTqH6Z.s66uUERJ2AomDe2r2wmZ
 Z3HGESpjX8Y7cJXR1SFke2PU9ntbwentWjnF3nFbEOo.MZRVPp_zgXsO40cA7kgWBeae9t5zY2Di
 PF.jOz6tqJ5Cqjg1VpGsoJFV4ADwJVd8tvHfFRPeBVbWJtJIYitzMFMM_FOmLf_s8fM2jglrtOtj
 _uxfAHQfpT_zd4BWgXMrEaYYbnUmH6.4TqNfOr67LK82iLxC1_C_4aNLQqW0J5ZvOz8KNRY4yUHJ
 SV89QndfSpfJ0U_tBIFNDoZcxZ9nGrYN.Hv0OTaGkRyxpKmcDMgrQE3Mc2PY8MrIMKvawQmpu6.x
 twCT5dtFjws_A1EQ2rRoD.7scxfgsYBm.s5hJjKFLaJFVUSeICmqB3rP2fVI0C9M6Jkbh0IdF0hf
 SKdUN.gCfE7Xg3Hx8iAnP2HI5zpZU.fNWA8rfH63ncYPgWYQ.XiPjCzJw.a8ltApee.bjqro4fV2
 Lv_WMpZuqW7wISMrctCPXHFK_8y6KiedaYPbJfu2T5HzYebsLYjKWzm.UlEVofVdrpZGSnKD8TEw
 Mkk2Ad33aXBuFP3a2WU1PEbHHw08RpOHM1nqCsgedLvR_ws3tvCYl2kbklYoDFGv6B1srYWfRQa8
 aGbFdnuxIZCT0kzsscNfOYus3E0pEX6wZYpZEYm0pOLrokh9XLs3VcYBzSdBhIs8yBwASCvQcidz
 VALPh.2QChUK.Lmn4lXRAMDo61hoccKFzo8alYqUooJNAAj61Ta1hGSTm062zzNyEqQz8WetLJmE
 T7KA_uVn7xJ_eFY7ZcwX45hYGZ6OuLnCZ2AsK90IFcoTtkLuKbLwM8w2BVC7VLCu86hRQH_Psmn0
 0ICTI42.AA0W8LFq1M6t8V2K2SYlXvTRti6HGY.IlPCvqWaY1F8zAOTWX_HGejJqrkSsXNv3AsSY
 AFu5iSOg48TdNjA4cnYeCx.ol_qFSuojBP7NUbzEFAkWRn4Q_t28tt21ciGALHQ.wnTwJQmu6lOc
 jwu8NzfyEdYAvFOCz_E1tSqppAX4BjswKy1OZd6Ywb6732tS881ZNy9DZaAMnCklaZ5vItFQL97s
 HgTKcLEHqUZWPDGQHpwJ9rQhlCK.T9yuAMT7goVs8A5diwe4pc68OLdXNxwKsRqtaelzCO643S8n
 3zmAa_.B6MGua0vVn5iYrd6EH7H8hT_p404kfapwebkfve1DP0yknaXsnIivnSfvnmoQvcU8rair
 Tff1JUqJGnwiTo6q1II9E6cpIC9GP.f79bCfcq3KU1Uc.BrbDdge4BzrtbVG1tCISQCTsesVqJBN
 kEzlpE.C2sykqAZdmjJoJdVwNfTbaPtatihy8cNF8Rf53j7ZG9D.00P5eXw.diHFACiymocL1Y_p
 UcLUFbsuWi8DVyj5KE9T9AQLmkYbZ2P58Gmu8BojMA_zC_geUif2w4J8tjTB0kLW9fNMjpSAEaVf
 O.C4UiVR5sQuaIFwigmmip_JSGgyVHhpuz8yRqUn4ehfpzjh7JU_dxMOlTszwzav8dPHG0S_uctD
 cOEJ5KcbgWPWGLPq34oW1x59PCkl0FUhFdNZAanGb4s6koHL.4ihANxDRcG0RKEgNmMj1h0Kdimv
 6ZtZpuJiLDH_SeL.yqXIH2nn4Hti7x.RjdWEQEgG3APVQOTtgBGImKuUinpopJTlXjoPrEzPlaLo
 ypdRUp0wvbVGOu3ilJd.yk21VahXvAF3Owgu_i23kqx0Z0r0aiQpuWljN75VnczxRwLyyO4Uq5a8
 hTwStM.RaR72NH8jvNY3pQMi.7r4nGsqEJOJdOdvdLNAHfeGoIPDq59k_7EBDQSpY9Ekju_wi1kr
 EyTiP4ATU9d1Sal5jC2iv3iZStlV4I293qw79G5okra.3SzNHr0Au47iF0b_0Kk0ButaER3UkW1v
 Ue17yFgnj0PznFt.erbVGk.mtHtFPBMVjOdnXWGMPb7Ceh46T5x2fmbtl1Zp0XHiwuJ8Qmc1Fv60
 XQKgZp0P_mHZx1EvhD_yteGTxiUxP8TlbWzJ2AJSzH6tZW2VZGb7HpFstNeCcAx4Kl_wcNTcXemw
 k_hOqq8orZ_aGQAmC8KDZYPHgmPvAFXZLVd2cTSvEQn725fjySlSRa1eMibH_vyftH_vOBeXnz1J
 ZeNUPyrm41faaHhLk1U_j7wELdTKRmNPT8vRx8dXuxhTuG9EE0cIGd3CZtFJvVYHVC.Nb57CEnzl
 e56ipvwrvYdDgzzXP97IoX2Gc7w.I2CkMjc85179P59XPM48RjzjZJQlvLwVadlpxnaI8Ou2C7qZ
 Grf0c_S3ULUf.y4vZ8DU.WIeYVNkUOenrGv3h5jSny8Wmx2K8Z9run24yFHwaxuZgZixwtc_Or70
 WGg.mT6LvgWD.Cn3mGf3WEOhxkexQ4jS6WouDZV07gnBfeUE7aO3eRpx2vTypnG5h9duZd7.SatW
 fcptMkrtIjh6dWgt4ottLQtjrpa.TRnMSVhp0C8IfwUso3e1NCfvOeaxagCtRK9Jro0QXnDg3lU4
 nyeNhQeUoHOa4QXLA1snvIwYVvixFGYjwUmzh6PAxZJ5v_X4Yroy0UjgXLl2TTtFSaRY70utCBAs
 Bu2s-
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic315.consmr.mail.gq1.yahoo.com with HTTP; Sat, 14 Nov 2020 18:25:36 +0000
Received: by smtp417.mail.ir2.yahoo.com (VZM Hermes SMTP Server) with ESMTPA
 ID 85968d25ae8d25f4ff6dfa3538a98c18; 
 Sat, 14 Nov 2020 18:25:29 +0000 (UTC)
To: linux-erofs@lists.ozlabs.org
Subject: [WIP] [PATCH v4 00/12] erofs-utils: introduce fuse implementation
Date: Sun, 15 Nov 2020 02:25:05 +0800
Message-Id: <20201114182517.9738-1-hsiangkao@aol.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20201114182517.9738-1-hsiangkao.ref@aol.com>
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

Hi,

v3: https://lore.kernel.org/r/20201102155558.1995-1-hsiangkao@aol.com
v2: https://lore.kernel.org/r/20201024130959.23720-1-hsiangkao@aol.com

background & v1:
https://lore.kernel.org/r/20201017051621.7810-1-hsiangkao@aol.com

All main logic has been cleaned up. Send out delta patches this round.
As the next step, will form the formal patchset for this simple
erofsfuse feature.

Thanks,
Gao Xiang

Gao Xiang (9):
  erofs-utils: fuse: clean up path walking
  erofs: clean up compress data read
  erofs-utils: fuse: get rid of erofs_vnode
  erofs-utils: fuse: move namei.c to lib/
  erofs-utils: fuse: kill read.c
  erofs-utils: fuse: clean up readdir
  erofs-utils: fuse: rename readir.c to dir.c
  erofs-utils: fuse: cleanup main.c
  erofs-utils: fuse: fix up configure.ac / Makefile.am

Huang Jianan (2):
  erofs-utils: fuse: add special file support
  erofs-utils: fuse: add compressed file support

Li Guifu (1):
  erofs-utils: introduce fuse implementation

 Makefile.am                |   4 +
 README                     |  28 ++-
 configure.ac               |  22 +-
 fuse/Makefile.am           |  10 +
 fuse/dir.c                 | 104 ++++++++++
 fuse/main.c                | 222 ++++++++++++++++++++
 include/erofs/decompress.h |  35 ++++
 include/erofs/defs.h       |  16 ++
 include/erofs/internal.h   |  87 +++++++-
 include/erofs/io.h         |   1 +
 include/erofs_fs.h         |   4 +
 lib/Makefile.am            |   4 +-
 lib/data.c                 | 206 ++++++++++++++++++
 lib/decompress.c           |  87 ++++++++
 lib/io.c                   |  16 ++
 lib/namei.c                | 205 ++++++++++++++++++
 lib/zmap.c                 | 415 +++++++++++++++++++++++++++++++++++++
 17 files changed, 1461 insertions(+), 5 deletions(-)
 create mode 100644 fuse/Makefile.am
 create mode 100644 fuse/dir.c
 create mode 100644 fuse/main.c
 create mode 100644 include/erofs/decompress.h
 create mode 100644 lib/data.c
 create mode 100644 lib/decompress.c
 create mode 100644 lib/namei.c
 create mode 100644 lib/zmap.c

-- 
2.24.0

