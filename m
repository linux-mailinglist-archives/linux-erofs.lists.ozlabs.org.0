Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id F3BB8297C88
	for <lists+linux-erofs@lfdr.de>; Sat, 24 Oct 2020 15:10:54 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CJM0q299gzDqwC
	for <lists+linux-erofs@lfdr.de>; Sun, 25 Oct 2020 00:10:51 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1603545051;
	bh=2cXfK0G9b4+grMN25SoZdciLsNKaV42EUn1cr0jJyC0=;
	h=To:Subject:Date:References:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:From;
	b=Ohh8Iy+OtwKAmuBO6l7UT0mnVVknvlMRmeaORJj9u0tFgvvdeGr28jsM1mYzxpEqG
	 1elvZGAmUgXJD/oIUy0HM4kA/zM0NyNPUlETBW33YWoozVWGz6cITwRfCSUhwxVkr1
	 nZpgV3l4uDr+iYVqZC0El7PEuw0H9nR0CiwX3ZSAE+7U0UECklGg9RZ9lwoLlT1qxV
	 aO3hg7fGVhy4zy41ynRMyaDGHLmiB21dwcvqJFcEkvCdMPOkMpiTMnNMltN0YeoD9C
	 Es84VXLCCyVZorsfxxfi4tk8v5llU37XEnAqYQIjvAvGdku7RG1zF+SoUJ7Uvxwuen
	 +hP9qcYjdnKeA==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=aol.com
 (client-ip=98.137.68.205; helo=sonic304-24.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.a=rsa-sha256
 header.s=a2048 header.b=QxS11w1m; dkim-atps=neutral
Received: from sonic304-24.consmr.mail.gq1.yahoo.com
 (sonic304-24.consmr.mail.gq1.yahoo.com [98.137.68.205])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CJM0M5YvJzDqNd
 for <linux-erofs@lists.ozlabs.org>; Sun, 25 Oct 2020 00:10:24 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1603545019; bh=nl7QCDFKb3awoIZ+AfatdwJJ/+1EO8mKxTGVnKyx+PY=;
 h=From:To:Cc:Subject:Date:References:From:Subject;
 b=QxS11w1mg8hV3g19mTs00qRotOQfRhqm5ZhFYmm8Xly3nikzpWAGf2l5/Lvm/chothhTafGsxJx4ki8tG6ynwC27I98xgpnKVLudBlAtRHlA5aq5EcX8MCf4oi8v36nL3ltduR53Cbimd0/y7n77RmZJmXPHgNaBMiK9uXxt3axejhB/ERmeNm6Ejfc9e1YEDa4IA+kcbVv7abfSmuPpSZIEgZwH81wJI+XnmSaxDMQCg42NUpVRwJHw3pTDK0L8DhDQksCGepM7HmvCVTVG9ZyisbQIDvJuHKzhvBZqdyLE6/JzR9YYiQBIhdaJwN33pqt5HbvOWIUBGUCpewf89A==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1603545019; bh=92BX/WrNb9c/rrEkKtRPSSUZPQKZcaQ8EV0droLCdlJ=;
 h=From:To:Subject:Date;
 b=LuDWkMLSm0edYPkHbtGeFTUpAo9YfTKWQh5PfQ+x/zdrtWDKdjGgYWbkHKGYswuoTTMGhokaguNjf5sW9HGlV19sTpcwjRuiIwg0+XabkXwo/2cmTwp73pZLcLTC/Ka9xoUQj9tjiOKIcX/jXuzyiilBK02JYTA6w/OOIP+BDaFaLy7wa7s3VLPei5hsYXwWx8b8+Oi4liJ9P9+zeABGUvdsEzUBx87wdVa5Q7TaP2zz1NW7C2NM5brCZ+HQnVTjNDU2c0YBLNqgr2bBju3PNuHx5JBohaqWHveK+zoueMnKC+mFOwZ+5KBes8RlkPs+2wWO7uOQqeCNehcDIVCy+A==
X-YMail-OSG: k72u_vsVM1nmT4PmxzGbU6kfd8mMST8iEW4SIm4cKxY0RXmYaBt1RU12lR2pAKV
 qC3Qop1VoHMM4_hM1v9NFCOQygXq6XESia9c.Sg4hq0Mb29JnjBJynk4tezS7s0VQ2Bcr7p4cJ28
 zqXpsB83ifzfxZiVp2EtdInQNI7Hptim3mnmm6v067HlcLmu8A.7cuSMVevpXME5nkhQR7OA5QLK
 4_wOfTvnSCZ0H9Kf_AekVSDSjNg4DVjQQ1R0vV0xj4IDwg2IQhx1N8sI94UOr14SYbmCs1NyEmOo
 Pjj5azom.wWnayLZgeeoE6PZH2FVlsrhJlBzA1zILlzqoiGMppwdDa7hcLNoRUE_4unRUrq2ZaFf
 4D3hafHUYCSUkM78YWTHzeK71bAwJY3pLIMtXR5RO9sdZh_hz.WaSZNJDfusqOG7CvGsKc6moZoi
 GEaB_CKNajpPaXCQwQmNWVUjdNOaLoUFV.6dfPn1zoXMrMFAO17gxQZrmy.vucvxHI_r5K73fFYe
 T0izepPrpZbphf4_yUT7mtr0vXzyzEoURBBHtAeMRKcMn67ChbnPssWnaYsLRXhCmDOM8QtgH2U9
 A_B3LCbuPYEtQ4gAB215tdGX3dh.6GzawUiMrJQBjF0F8SOH.qa8K_h9Hxl5aXkYkoCoTBzQawEN
 o7lckfjo0Ao1tonZPGPFKV0T6psul2RycJPimvOk7HH8IT_bpu7rxbBMXPQrDZA.j6er.TDic1jK
 9of0hF1P0TcF9ue9d0VjF60A2pCXjbUiknJxVHJw3D79HwePYbi8Do5FHHhyfXRQzMIXv0KRTdKc
 audV.F9mMEVnqZrd_UQYjc_n0QRTBH3AAFlLuQDQLI46cQhgLOKg3O7sODx4OaiHN9gTACn1vz7m
 EpZzklQiT3nthUddzG2F7xxHC3_0tUSUmgsPNuIBjwZPXkw0f6GJJGoug8McYczoXR8Z9FOdfRPf
 Im8XpK1tHGO6A8HLQq9K6_CaZEuGB6382yUtHgBEq6DyIwVlToTzXhmrA623R1AinyLCjGBHVc7J
 uasKFmr3aw_NrK.qqMhYkdrti4e4s1s3uMn53xaAABbaldl9CZBrHw94CVPUsQcej3cOsNgft5BC
 tChqtJ5aPUmxpi.x1vgu5_nMWpd4erYOFynJnM3WihvFhcc6qgyfWlMFdTKIl47DeaE8tb36xdiK
 Whkx2KGFSzo56WTrh8vqyXLyCxhHRJJE8jvkvCsgh3c0EyHP6Z6SmZG47gKC4vxP40p2ebnwZwKP
 K6LvF.BoIs6Zz7ntw6eymK3o3kASspK9TYB36U5g1UFs_wnF9S6DcgjeifOQ5xIQCYON3ikdS9bM
 W0ZyeYmAlv0u2LiqpbYWhxbCOIaL9qYiQEGpwBZHxRFLcdetTPD8AQw2NwOgPFCf1PyIKQBdL_eo
 UcaJ.XAtaN3sXY_W_u6RWx79BmneINTe8RF8LK0qT_RDVx2DoBjObYMnajnrATWsjLEAW5a0XTez
 yqgEPu8dJP4c_vtajT8cP3eHeUBNKdxoC7nBMHpHn4GvctKlt5Y25lQl8u41l6i.sI7Wjr_cv.RZ
 Kk.Nl3Cm7hRBS59UNdelabgoyW_seaB8nVrxc_8r7KFBka84n9NrY.syliiCubnK6bzYQNSbgQT2
 TW2tIAvAY9.NAmK6CJmC3Zzddjr7f8BKDgxJSvD28TKzXze0GWGxOMkPBYydu_wPKQFSRpUoPq5m
 _uc.kW3cyHGa9fcKG_X_Z9xAhK4hw.wCs6ykhlHJUO3x44M8TziG4_Qgk71fU.hitIXq6ynLArEC
 QP396KgoUyA8SMuzvusMgj.i5SjnQjFTzn7iYO_CWDElyaoawEMuXClRO4iu9hVPEoPds1ZS9p4E
 MifYFYwu8E90yVTCAaVOB6uyBEKrpXz1gEPEikZa6Bczh6tomEBdaKqan46b7W6f4ai..9TvZZ96
 aa8uUd3Pl99XsHjWLCBJhrk1WUcgBQpoUEjuYji5UEdnx7tu2nthvBPpWrvsATxdnr10mSFrttiS
 ll3EkdQKSFC_qJVpA.n.dCAzWCiK9muGgctlYXGjHTtoKJuyWoUmOEMbHA6CJs1XmLXnICTgmuSd
 PaIGrF17qlUqjlZUxln3DNp4oos.sKW3E3Cx5qGAMhWq9L0bxVi1cRZOvn1P9.jjW6_yFn4tM9VW
 aJfv7T5N1SWs2j1Mo0JpjFtv1OnLYGxuXYmh2mliXoCApjFmW4FjXIUFomQ.I1.RUHX8Emtmao2u
 9Op7chHB3CM50xb3_lpSjmsFG.vcNu.mIVIR.1nBk1.F135l7Uy5neNnjFy42bdjl1_09hqbGZ.a
 SRRP_gqrhS.ZRjmgnbv.CzkwLUD7ydzQrS1srXgpecA2U_2zd70HNKsmwjJ1YH88W1H6spmRD4eA
 LQiK8WwVKnj7FiM6HmkkRYQjydK3qHpMf79wPSuw32FknLo101HrSym8qMex5xEk7Njd5CCuTykd
 4mEOsMgyFreJbBRFBIutq_RcvMRu3zq_vvX6H3vUcFKYO3pReIhrTygdITkWEbn.4etnq..GoO9S
 2zSx2Qm8xVyZ9A_euJKiFI_AkrBJkLSTXyzwwtSgP4_xst2AbwMZWEZwSAaMv_dNS0M22ws1aoaE
 .COqlYcjCwUH1E9nt7ZHKXCDyuxK3sxKxbGDZSoGZG5n_0a4Ur3Fe0GM2K0Q._oTFBrOHhl3H25s
 sKSQzFuFhQ4pGAS5LfC4rc7NwgROfhLFY73GKOZcL5uQR02i9nfwOFI1jPzNFODwKWeprANQ3W5q
 FS7Olc5vtbAKhjgph1iPCQNL5JVnuQfojRHygz_n207MsH6W_w4BeqsUcgNklT5W1jT0WLQqPYcP
 K7jq4g4EKOdPNllgKwUSczxs3PtJH7W4DHg0jWtAv6xLVLJ23ifIauLi8w.kC4rImm589sZY-
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic304.consmr.mail.gq1.yahoo.com with HTTP; Sat, 24 Oct 2020 13:10:19 +0000
Received: by smtp419.mail.ir2.yahoo.com (VZM Hermes SMTP Server) with ESMTPA
 ID afd45167a3858f59b7d63d6cfac9db14; 
 Sat, 24 Oct 2020 13:10:15 +0000 (UTC)
To: linux-erofs@lists.ozlabs.org
Subject: [WIP] [PATCH v2 0/5] erofs-utils: introduce fuse implementation
Date: Sat, 24 Oct 2020 21:09:54 +0800
Message-Id: <20201024130959.23720-1-hsiangkao@aol.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20201024130959.23720-1-hsiangkao.ref@aol.com>
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
Cc: Zhang Shiming <zhangshiming@oppo.com>, Guo Weichao <guoweichao@oppo.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

background & v1:
https://lore.kernel.org/r/20201017051621.7810-1-hsiangkao@aol.com

changes since v1:
 - fold in incremental patches in v1;
 - get rid of "-Wextra" to adapt common erofs-utils code;
 - get rid of duplicated logging code since fprintf is MT-safe for POSIX;

TODO:
 - move fuse common code to liberofs;
 - make fuse code MT-safe;
 - minor cleanup.

Thanks,
Gao Xiang

Gao Xiang (2):
  erofs-utils: fuse: drop "-Wextra" and "-Wno-implicit-fallthrough"
  erofs-utils: fuse: get rid of duplicated logging code

Huang Jianan (2):
  erofs-utils: fuse: add special file support
  erofs-utils: fuse: add compressed file support

Li Guifu (1):
  erofs-utils: introduce fuse implementation

 Makefile.am              |   2 +-
 README                   |  28 ++-
 configure.ac             |   3 +-
 fuse/Makefile.am         |  17 ++
 fuse/decompress.c        |  83 ++++++++
 fuse/decompress.h        |  42 ++++
 fuse/dentry.c            | 130 ++++++++++++
 fuse/dentry.h            |  43 ++++
 fuse/disk_io.c           |  72 +++++++
 fuse/disk_io.h           |  21 ++
 fuse/getattr.c           |  65 ++++++
 fuse/getattr.h           |  15 ++
 fuse/init.c              | 117 +++++++++++
 fuse/init.h              |  24 +++
 fuse/main.c              | 167 ++++++++++++++++
 fuse/namei.c             | 242 +++++++++++++++++++++++
 fuse/namei.h             |  22 +++
 fuse/open.c              |  22 +++
 fuse/open.h              |  15 ++
 fuse/read.c              | 213 ++++++++++++++++++++
 fuse/read.h              |  17 ++
 fuse/readir.c            | 122 ++++++++++++
 fuse/readir.h            |  17 ++
 fuse/zmap.c              | 418 +++++++++++++++++++++++++++++++++++++++
 include/erofs/defs.h     |  16 ++
 include/erofs/internal.h |  79 ++++++++
 include/erofs_fs.h       |   4 +
 27 files changed, 2013 insertions(+), 3 deletions(-)
 create mode 100644 fuse/Makefile.am
 create mode 100644 fuse/decompress.c
 create mode 100644 fuse/decompress.h
 create mode 100644 fuse/dentry.c
 create mode 100644 fuse/dentry.h
 create mode 100644 fuse/disk_io.c
 create mode 100644 fuse/disk_io.h
 create mode 100644 fuse/getattr.c
 create mode 100644 fuse/getattr.h
 create mode 100644 fuse/init.c
 create mode 100644 fuse/init.h
 create mode 100644 fuse/main.c
 create mode 100644 fuse/namei.c
 create mode 100644 fuse/namei.h
 create mode 100644 fuse/open.c
 create mode 100644 fuse/open.h
 create mode 100644 fuse/read.c
 create mode 100644 fuse/read.h
 create mode 100644 fuse/readir.c
 create mode 100644 fuse/readir.h
 create mode 100644 fuse/zmap.c

-- 
2.24.0

