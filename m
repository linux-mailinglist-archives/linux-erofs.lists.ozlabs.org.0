Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 908E92D2955
	for <lists+linux-erofs@lfdr.de>; Tue,  8 Dec 2020 11:58:27 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CqxxF01qRzDqVb
	for <lists+linux-erofs@lfdr.de>; Tue,  8 Dec 2020 21:58:25 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1607425105;
	bh=O5YLBZ1OMn/oLFNcFa7hdg0VoZy6oETqYoLdA+cZT88=;
	h=To:Subject:Date:References:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=edbB/rstSfsx987QGfTiFFgsTvZofPA2z716HimH4WE7pU1wbIm4KPiws407d1PH8
	 84Glx65qFvKPZErYfB8Olw1+bbt8uFqDYemIt4Y53oN/lr8jQEzERBjosJgLnLk/qD
	 LUrn3KuOZpYaDvGdwJCr28H0tGg3S7cqIzXb9oENXynj/UKMX8RTHA0upixi+RPJ6j
	 tFLKKv2TGcz7Yd5H3RPei7cjuiNhbvu5mAvvzvf1LtzqFVp2eKb12r9RHLSDnjGg5X
	 nLGFYGjV7ChLiBHqVNs/jufvmlgkS7Zpx0opV29UwWt4n6Nk7npPGPuYJiQvlANduu
	 80tRBhLVr7Q2A==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=aol.com
 (client-ip=98.137.68.82; helo=sonic306-19.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.a=rsa-sha256
 header.s=a2048 header.b=Ei5UY2LD; dkim-atps=neutral
Received: from sonic306-19.consmr.mail.gq1.yahoo.com
 (sonic306-19.consmr.mail.gq1.yahoo.com [98.137.68.82])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Cqxwy6M4bzDqVb
 for <linux-erofs@lists.ozlabs.org>; Tue,  8 Dec 2020 21:58:09 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1607425083; bh=VNqMr3jKoS+DukRnzjU0CCkuLupVCxwfirNXOR3+NV0=;
 h=From:To:Cc:Subject:Date:References:From:Subject;
 b=Ei5UY2LDLbOnx9THdrx7r+XyRgjvNHig2kck8eEmkkvhXfGhF71XyJClsmEr/fjneVUTN+39SYigeYqbC5Ix4OkpZNDBeaQbUiKBsEDaXos8QW8fYyPG2jJo1eep4AH0YVQekwOkCTWIXRE+GUOSpSmDly00HBTJq4SmK5UUz40780bEzTe3qRlOFdtrjZLsHRuMKVTlvPLukfFAQ6prDHgZE21UQ8aI0RvISfN/Jvkhiu7kl0H706ivM3KyzaEGw/d8FjYNwbdw70XYxLWDvec9CruJy9paU+UnH1v0rM/SpQnb9BYzWqhMwF7XGbSBHIV/R/eD15k5CSVDOzY+yg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1607425083; bh=23lp2ba+UAcL8NBFq/RIZjFuASIFY9ySNSULyhwiQdj=;
 h=From:To:Subject:Date:From:Subject;
 b=ZtzGPPIcq6Fj5kYUNIjGY4EU5dwgo0wN3uDlwIB0rwpPs1GJZ+lJV1YyHTvfKe41pjjo/0q4/M8SlcRX8S0+lFqKVduo3RHGrlQV9M6DGquC6qlwxHkFrer4bnzPEtx2PZh/5jPmaeSm/grGkzQUZRQ4QhjAHqbtER7BvsJTxmr+KiXTz4jJqg7ZedGVNIl1VjIW4Sr+5Sa4ckM0wh2kwOd/tqdqdcMuLmrqGubkKQaK/rNiQvpdwImLonFf2k2Zn0p2fLh4sUfPwiMEAB4Y0hqGdIKexHTNJv0T2BvS/q7aLXfIWI/NihIZJE4d6XLsyniibxpd+nYW9upiuLYo3Q==
X-YMail-OSG: cEyVkAwVM1kn0fMfiu74tvIZ1eksOU59fmv.3fCNQEMd2ZC7sMj0MOlQK5Xj.df
 iqcBOGA5Di4_2IXbjr4qvysfFxTm_M37ibD7mlV7F7kkXR8LOuz9RlHfE3t2g5ekM.L65yMHlGcn
 QtP_GDkEMR986mzU2zzlmAHdbBtZYR_YNmrL6NPY0pxgzzXcRpiASZfSZjrUdxMoOBqRu1GpMCHL
 oKpbqk0quOnSjXkbDf4H1N_24BkGkBbhrA3gQ2w1o5WM9Ztym51v8mu4s6YasMvS2Tdw7xhyrFgX
 GkptNtWpNwcN7SshqfXQdF9NqV6RNGlBbuuuAtOgmaVTvp18Av0i0YT6XM9OxIRy8OUhkgK2gUN9
 BX7Y4bfm4oO6jRPldqV4SByz.ayowbkMwh9PXlu8IaEiTxPDvrL3_W.pLSBM.NAqlzCEkE.F0QoV
 5jy7casMm42ZMnesE5sgxuFUvKGfrUiqOORCqtKvb2LjAaMNNtvTHX7899PpfcFuU1w6NGnL4cSr
 lGAWQjlDA0.1xuJVpR.mRna6roVLuDoz7twg_.Chh.9jDmqXJxhF2DO43BZVUdLsn.K1XAYf8Vad
 L.cFcxFs3HisljKtGkBU5GHTHtCm6LuWLgAsFm2lInj4hu3qKqhDz_qvZZKaY7ZwqFEkDcu9Y2Qa
 Ry7_MRAU7YtaA7Gla9AgzlleUHswP2dacdDiF5Rb510lgM8oaID4JjhGzvb0qC_cJPq6K5nt49EQ
 XOZdbrZBJHpCfnxq4RPBgpttXmlIIWyjfbJYOJgGcOwnThVEKxybiGwv5vNMWiZbapTX18wXyfsx
 MvnqzTY5NtIFk903g9EDo7lbdFIcW3IeAUgyrEINqp.MqJCglX2BdQFg3sunRQ4o1fTqNogxcr.o
 W_WR4yBVLcGyEvDpW1p7tbyA24ilVRi1ltYLdDBlR_of57fc7cGfH5f.OfyfG_5iMX6sTg1T2J0F
 Y_5L8C17uelGbaWw2TktFa3QhFLrucHYdk1xLYIzH8I8f77ZP3k8uy.x5Wc6kiByBoy9NVY1aRIs
 fzIqbmwXe.iOGMWCa5cPLlMgmnRKD0JrS7uzvvgheQVI28fjCoe0qpYNPOfupDRUsTwMI5bkaK7h
 PMYL0x_H9pGv15Wm3eqyX9qy8iE0bEToyvtul6TF27SGnZf4I.pck8aKr6rmJOx8BMUpOmY_92xu
 XWMqUn_JXc15sd2Qjli0mwzA_rgU3ha9hqw.fG2poEq9CHQvugwUMjlZZSqXfsmAARUtitWsToLE
 LaXXEdlclPGSVXtaGsIH5ycL8yLWLS14aYvAEpJOrcorRwngGaDB4mPI3GcHS6GCxH9.qqKTZnxC
 peu9muyNpYkbGmgHlVOiqc2I7qkPL70v19DsQE2USPAkmpYoh80Hr89pykFKuvYIZazKx3N833Bo
 jvYU8MNzE66lJfqMNBHiY0MFWB_UKyRPgaYYFKN1024dkmrTdtWRqRtSasH8PVjsFGPGrZLJ.PyG
 I.EftMASrQSJW47X6YnnTlTXpuCSM4gexbwj0MjSzoPtSmrmyCP038x0FM7zjf3fyMMz7B4SCopa
 8KBVg0BY_zmFziYNcEo_0VGQ7vnYLPlfmp_dZZNSObvcvhUYYDeiaXr6.8JNCpsDxSMVpMPqeMk5
 7HMfpWbDq3mmGBnVb1kIq9QXAAjxgu6mH61eECScmSXAAy2zw6C16UsDOG0ExXuxq4hCCWl.yneS
 1uGeFU6XIoabUni9r_OOl6oUgaiX3OlQs081wdKfI9alITusGHdtPF6EdxpuDCUHKklKWvmuFFoH
 ToUgWnIIHt.EDauLqkeXUI3EbX6s4y4ooa42oX2gebstnpXiCZDnuxG4P542u3mwFmPnKehp9YFW
 P8TnACjZPYfHcdByI8h60g4DDoPGFKLExX4fj18Mhi54W4Zr9Cbus2ake4MvEQ8YuHfaR9RDoux9
 qnPFTyomyr1LPeYdg29c0c_7qHlGdKlRI5MhWxU9SGQmQa9udROqDvEqx5p7zTswHrlJf2KTFCCs
 oZopp0GgKYn3knZn7fL7isYHLDnpM4pg1MZC34uxj43nMNHuJvptdWbWKyGVZ00EGsXwiKAGC..T
 NsiLUQXsJJPS3tOf9hkMjzCNG9fGlzW3mtEddrsWw1Zj8xo1A2euq_nX1rJuFoAKO.NGu6gEIXbd
 e8MJ83Q2nBFifBtrv.b2zPPHLae2QTPDDJLnkTsMd4BJQg1DDD6B6PJQRjRkQ_8BbzuspsltzfDe
 BkFV3JQb5Kj61F0mC_Yij7obpDrWNh7XUC_FO4_db_zQpO3qrDZ5ig9xTTrDuuXLC.M8nk2qoHpn
 iR6erafNEH8nop0a35LUYU3WQtqMAPIKXsmMNEi6.dQDbbFsXLm.mIsuNUij3pIuY6FQ7BvRtv.2
 RsAw7UzToWRTDlDiP.43xm5pG4WWee6NfB4TmAhGqGs8_IXjYGp2HtT4_Z27tdPqfZa9WqLpM1bQ
 oYQ--
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic306.consmr.mail.gq1.yahoo.com with HTTP; Tue, 8 Dec 2020 10:58:03 +0000
Received: by smtp409.mail.ir2.yahoo.com (VZM Hermes SMTP Server) with ESMTPA
 ID 035c98433a10899da22310b8761a126c; 
 Tue, 08 Dec 2020 10:57:55 +0000 (UTC)
To: linux-erofs@lists.ozlabs.org,
	nl6720 <nl6720@gmail.com>
Subject: [PATCH] erofs-utils: fix multiple definition of `sbi'
Date: Tue,  8 Dec 2020 18:57:41 +0800
Message-Id: <20201208105741.9614-1-hsiangkao@aol.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20201208105741.9614-1-hsiangkao.ref@aol.com>
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

As nl6720 reported [1], lib/inode.o (mkfs) and lib/super.o (erofsfuse)
could be compiled together by some options. Fix it now.

[1] https://lore.kernel.org/r/10789285.Na0ui7I3VY@walnut
Reported-by: nl6720 <nl6720@gmail.com>
Signed-off-by: Gao Xiang <hsiangkao@aol.com>
---
Hi nl6720,
could you verify this patch? Thanks in advance!

Thanks,
Gao Xiang

 lib/config.c | 1 +
 lib/inode.c  | 2 --
 lib/super.c  | 2 --
 3 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/lib/config.c b/lib/config.c
index 315511284871..3ecd48140cfd 100644
--- a/lib/config.c
+++ b/lib/config.c
@@ -11,6 +11,7 @@
 #include "erofs/internal.h"
 
 struct erofs_configure cfg;
+struct erofs_sb_info sbi;
 
 void erofs_init_configure(void)
 {
diff --git a/lib/inode.c b/lib/inode.c
index 3d634fc92852..0c4839dc7152 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -22,8 +22,6 @@
 #include "erofs/xattr.h"
 #include "erofs/exclude.h"
 
-struct erofs_sb_info sbi;
-
 #define S_SHIFT                 12
 static unsigned char erofs_ftype_by_mode[S_IFMT >> S_SHIFT] = {
 	[S_IFREG >> S_SHIFT]  = EROFS_FT_REG_FILE,
diff --git a/lib/super.c b/lib/super.c
index 2d366928e12b..025cefee3aac 100644
--- a/lib/super.c
+++ b/lib/super.c
@@ -11,8 +11,6 @@
 #include "erofs/io.h"
 #include "erofs/print.h"
 
-struct erofs_sb_info sbi;
-
 static bool check_layout_compatibility(struct erofs_sb_info *sbi,
 				       struct erofs_super_block *dsb)
 {
-- 
2.24.0

