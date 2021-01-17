Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 6703A2F943E
	for <lists+linux-erofs@lfdr.de>; Sun, 17 Jan 2021 18:46:47 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DJj5w4ynQzDrR8
	for <lists+linux-erofs@lfdr.de>; Mon, 18 Jan 2021 04:46:44 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1610905604;
	bh=Ayq9GtJk/YOjXH8w59YS4nb/u2UDL4+cToKhJAoOAKo=;
	h=To:Subject:Date:References:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:From;
	b=ky4woEW7CgsVHXzZb5sXfKepdT+7SJfzxiiaveeA5CJB9edxVtug+zWUh3afWmUP+
	 B+hU5EhioaC870KGCquVyWr84+wzoLVo7/09hLGK4iflwv9hJ4GtIIHbW6Qjfrtgzg
	 hGp1ejdkttHbEe9CeWbXBrdl3jJ2tFANAndnesqXs2xak/lTZh2BJaNQwgWDb9wn9a
	 0/8FdHUqopc8KBim6676CtVAz4n30RZH+HTuAr2o+3Le82fslcy/1a8KL7qEAHJJBc
	 SoNlKLeEJwjv785lS+OIKBht7/4i5P5MR3SSmzRsuLNBZRx2CGsQIfxAFAu2hMjNlP
	 Y9bLnTXiY7QbA==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=aol.com
 (client-ip=98.137.65.205; helo=sonic311-24.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Received: from sonic311-24.consmr.mail.gq1.yahoo.com
 (sonic311-24.consmr.mail.gq1.yahoo.com [98.137.65.205])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DJj5d46lTzDqts
 for <linux-erofs@lists.ozlabs.org>; Mon, 18 Jan 2021 04:46:27 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1610905581; bh=wMMNB98/M1bNWJlZQgJRWhKmtLvmUXKvr0mc4xmWx80=;
 h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To;
 b=pg255kxBOqCg2QKIrJ9X4RVapbCl6UzphVDqTD0PETtrxrPIfFmbkedkEPjvBdWoykMM/FazSmGzIyRYYLOp3N3tIi0Cz0Go5tsJF1B6J4etSzmfVig3VKNPctL1G8Nj04vDsq4aDQQin/JJyLSLcBEC7hglxm4/68PVki+yZRAQgkRtplfO+t6tAesp74Ltw7APwAT0igxJ4BBLEUgmxX3iQHv6c/JNykzZlLpfPgY3rO5qTeIP+fjVmIN0YrMDrGRhBHjNvUj5Q6bAaFKH9fGUvarMEXnYXYfwMrGMeEjMGZfAnCiNhbsVV5jgVxQTnNoeUcYc6oJmPh/J1RcYtw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1610905581; bh=V0nGpWJp9DfGKwM1n9Z2Y+sFW3AsoiKKRx5mZEGFevl=;
 h=From:To:Subject:Date:From:Subject:Reply-To;
 b=S9GoHotXKJvGUjMCL64h4RXBFwNR6ATFv2Vpzj77dxSRGHBa2znk56FuD25xotE3PbfSbclmE0Q86eRW4U+Sd8WmWwa6d02mf+SJyqlrHPZEg/SZjPHcBCmyfxCAt6fLCfPdYPP5z3zt2L+xhf0hQdkd32JkXmdq7FkPfNWNstvafrY6rTf5pQOonJfCppGdWxStVpnmA9F2O/VBLhtYKO03upVD7+nRPD/O8H+oxDjykqyZsxlJIK4OfYeMLtGsLHHXX7yk7EpSlRxNFVflO06WyB+NZhk8HiPeR80sWsSBQiUikGvkuhWPYZ1GFksViQ7irl2kuzkoGohhKvjWsA==
X-YMail-OSG: MPHCIuUVM1mCtKa974Tb6Ninlvk7q.fdcD8vLDBBOS_97XkUZ6klrnYobhbCjko
 zY.OuD9ik0F1MOYl7d5BNohUxtGVatvLrNTroLM2rW.VEptdcfoLFJ7ccWgF09RzdO4H0MokiC5q
 41ri2kRT3Rwuugr9D.lGFSC8fc4a7eSdecvTIkyKoYNmK658tR8fVduO4OKcuv5fLZvZdsIy1lfN
 muVxuTxw2IvgsI5.hGpFCBxljdx5tRUOV.9BpaVtgEcRFzOOx7cFJRXT1sqNDNa_L_rUP3bBQGVX
 XkJS0LR1TdldPMjYz8fiXqlM7OevRBHBWURFTeMjA_yw6E4wZ5xl1Bqj3xDZ1zZ6sTgv90SOtvGZ
 9V0ZB4WAl9yEFnSbNr1t7JZSRs6xoGdmjBJKNPUe.NG_MoE2bcaXW8GQsBssFdnYZaHY9RBPoG8g
 HspaBHqZ6IJP2nz474aV8AIEZQCpZi3GsVIHVBAbzBn9He_0kWLveGd5IlPqzgVAYZZHzTSTzIpx
 WwX7tdgKV8wgF.fyaUiqYexib0CKC70ws7blOBKw8wppdd22L_z4i.0cOOldVI3xPfd0tXXdfw28
 ksYEs5RxPYqKowANb0eNhu6dpwKuaTdYuKdPex0P7oL6Zma2QwvDK_smjcaHwlw_cicSPzEbb1OG
 600U4ijskj3hutYUEtDqVZOrs6xhYyQlE87T3GPnv3JuxWCEjs.XiiGf7V_LhReUwxhkoGH9Gv_t
 iT8eTGAG2O3ov5rTaepgA_lgeNWWW.DnP4aAjFPtREcckbM9y39L4U.WF2q.YwxYZ5dXvG2NafGm
 Md1NBE30SJq0RK43hFgOaAgHYMq_6N3dGJzWEp2v7povx0MMaB7RTc5Cbt0r85lGyHcXIDHbP8EX
 2LYSN7HQaizwRprzEzajGmCo32bLoyqJypKF6Xu.D4dWNGDO3E4xC3UJjixJmQjClW7JOl_uBX8k
 7.Kk1zWgFAAiimqF30WDb_hmi4COhQjobqPfYlQ6xpyc5pgpzI0HzDmG6G92G9jPC5vcZZ.tIzbz
 4177fv3SUghZT09x4gPXjtesex.TuMkMbTOSQJQ0JIL5QhLIDaO60ruAO7TeMphHNk06C_sEWCeK
 nKOOFDHiJ9t85kPJbf5AxVPKzYkZIZBxFsDvqD8ypdxMifEsOu1sL4HMkI0E7dICYWTo8E9_HBOz
 19gaAo1ynyWFi4ZwPKAc5EBoFNUcyt87spq4QFuTAou9w7J1zmkl3QglU0RxXcbM6JpXTeKMmo5y
 K8SIgbbjfU7s28ebQgrugPdKRHmMSE0iXkVrQI9ORLHo3_rn50d1OkCLjYRJ0C.tYWY4bSp7Ldru
 Ije3p.cjbX_.frmvOFJ148p9yr.HEdlZv_yJrq75NUz.OwvqwmvhHCabZbB4lfNcAdDz_VqQZ2TJ
 RDDEPcKGD3RE1W0HQBUj7uiUuVaQen_xRQ2Yf.fBNfZe4ZOyU6_284Gl1y7CO6B3VwbyKikcklcs
 QyuVjyvZ8Cb8NCXYf7hpokY2OroDBWid3HqdS5QPHpwZdWfKuJqWzHJBPU6fzbQYfJJ29eO_GCTg
 vg0it2e1c2zIwGTlt4RmkUOJGuJ6ZYC0qbtkmdV2LQtdryztBWB_A8wGb7e_.RrFeiHvb4R9D4hi
 FRQptNjEcjZ9v7dQ7q9ZuEFuwxA_jRzQwF74n1fsChSa6hHKgNEHyvwYsDpvU90.2so29wJv1Cap
 16W1X6dI34Iy_U86iqU7ND.K0jqy_kFxb4LtMX.i5HE7Cs2uMiXSM_zhUoP8Ot5mh1.9VRvyzawo
 M1htQm0rr.2YmSH7.tUdsoTKgMlypHy1Nqh9CDEWwY0FfcWJk_sK1a3q3yx13qNeQBidVMmU0ybg
 RwAo8vxc2PqwbI3eYjNPYoDcCcb0w8i2oubgRGUAbsQxbHV_VUYydB1OwNKqI8bvHka9wVPTjGHH
 rx3rE19DevH_SE65h1obZKonqiwGoqp2fUe.IJ32Pqr9puZRygD7T7RNUwJrl8mooeJhCNrMQHlo
 FrOGNgiyeFGyrk7RwEQyZ5mKfTlXkwNNOPJ0kfqvttJd_03KpSpKF9R3Hev_xIcnZtZMdH2ogVSn
 ETvsih4.Xzr92Jfsj.hfpPTEwNpSbesm9qjKjtwDTY7bG29qKZX2VQZMi5_wAqyBHv6NPBjXAOh_
 HjW6GpBBrMaQNp2V_NbgXaL7nDc7.eqJraUrnmrEKROWcBZRi_MjICFNsF8Jib4a9M8DtgcSBTgY
 ret8e5gD5GV_at1RQcSM5qZs41HZP5fzTU_vlMvQ9er6Ncv6SRqWyixS3ApsOonI8f7FLPmNajWy
 fBNcq3zBBEUas0.9RC2jtr.B4lKGsMlR3w0xVSgarsnx1Rr5DG1QNQjJ3KKfNhwMnRdVOjvUGfEv
 Ht2awNazjovxvIM.ATBVkuT1hm6yczeBZayxz.fSQkwVoaF_7zf5y9Nv4HUIKQ932BrVXcsGkJki
 HQKtErBOPioN0QFQELv6ue60GSrUieG9cZIPUkheyjc0lgjwiEQagITohE_dhd.CNOUZL.i2DxGW
 _R5ReL8K05bXEc7XADDs-
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic311.consmr.mail.gq1.yahoo.com with HTTP; Sun, 17 Jan 2021 17:46:21 +0000
Received: by smtp401.mail.bf1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA
 ID 84aafc302758bb6691fa0c94699b2296; 
 Sun, 17 Jan 2021 17:46:16 +0000 (UTC)
To: linux-erofs@lists.ozlabs.org
Subject: [RFC PATCH v0 0/4] erofs-utils: add LZMA fixed-sized output
 compression support
Date: Mon, 18 Jan 2021 01:45:59 +0800
Message-Id: <20210117174603.17943-1-hsiangkao@aol.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20210117174603.17943-1-hsiangkao.ref@aol.com>
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
Cc: Lasse Collin <lasse.collin@tukaani.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Gao Xiang <hsiangkao@aol.com>

Hi folks,

Thanks to Lasse, liblzma finally has a preliminary usable fixed-sized
output compression support. I've made a quick integration and it seems
work. The preliminary C/R result of this is:
 459382784  enwik9_4k.squashfs.xz.img
 401649664  enwik9_8k.squashfs.xz.img
 371617792  enwik9_4k.lzma.erofs.img
 360972288  enwik9_16k.squashfs.xz.img

* Also -zlzma,1,
 389115904  enwik9_4k.lzma.erofs.img

So it's worthwhile to take the further step and get an entire solution.

TODOs:
 - make a formal configure.ac / Makefile.am rather than such hack;
 - save DICT_SIZE to super block rather than using a fixed value;
 - support threaded compression to boost up build time (including
   segment compression);
 - look on sorting out kernel side support.

Thanks,
Gao Xiang

Cc: Lasse Collin <lasse.collin@tukaani.org>

Gao Xiang (4):
  erofs-utils: clevel set up as an individual function
  erofs-utils: add liblzma dependency
  erofs-utils: mkfs: add LZMA algorithm support
  erofs-utils: fuse: add LZMA algorithm support

 fuse/Makefile.am         |  2 +-
 include/erofs_fs.h       |  3 +-
 lib/Makefile.am          |  2 +
 lib/compress.c           | 16 ++++---
 lib/compressor.c         | 23 +++++++---
 lib/compressor.h         |  7 ++-
 lib/compressor_liblzma.c | 93 ++++++++++++++++++++++++++++++++++++++++
 lib/compressor_lz4.c     |  1 -
 lib/compressor_lz4hc.c   | 21 ++++++---
 lib/data.c               |  7 +--
 lib/decompress.c         | 62 +++++++++++++++++++++++++++
 mkfs/Makefile.am         |  2 +-
 12 files changed, 211 insertions(+), 28 deletions(-)
 create mode 100644 lib/compressor_liblzma.c

-- 
2.24.0

