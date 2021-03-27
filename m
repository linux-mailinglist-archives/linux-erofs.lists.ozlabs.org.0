Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 97E6234B41B
	for <lists+linux-erofs@lfdr.de>; Sat, 27 Mar 2021 04:50:17 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4F6lGv4Q9bz3bty
	for <lists+linux-erofs@lfdr.de>; Sat, 27 Mar 2021 14:50:15 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1616817015;
	bh=X0tRARu0MegMUcBxQZECsDMdTCraDyBuqxwTQHTyjb8=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=jT4StUUWMJLKt8Hh3OWYUMCqV5wGvDFvL/oA1GS/7Mb2bM+hY85kCbbm5CWq6zBQo
	 bt/wadQnNQFsuHuUtznjS3rA+BQUexLkdFAP94taBsNaHMILzRVr/Z00Po+SB6S4VZ
	 VIuHiLpc9IeTpqvuB/Mx98jaxssqLT1fpR6GwlQet8Oq5rQtPE+6gFcBFdi7B38qEH
	 l5IYdjVhmWKkXTs4RdeekYPwiKMsRjG4/u3Y+P+7Vwi4FeDRK66Ghsgfc4cUxZgiwl
	 G472wUdRbx3Xhyz4bmlLRETVPFEGmIwwuVrVbeGd1UIE5D88vy7+kbflVayWJBA7B9
	 S4Tnw0cwU34lw==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=aol.com
 (client-ip=98.137.65.84; helo=sonic313-21.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.a=rsa-sha256
 header.s=a2048 header.b=hhkhWUXi; dkim-atps=neutral
Received: from sonic313-21.consmr.mail.gq1.yahoo.com
 (sonic313-21.consmr.mail.gq1.yahoo.com [98.137.65.84])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4F6lGs5YMKz3bsh
 for <linux-erofs@lists.ozlabs.org>; Sat, 27 Mar 2021 14:50:13 +1100 (AEDT)
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1616817011; bh=8asE1r15VOTxTmizgIL6mTGVZHh+2t/2ozQm1NpkqKP=;
 h=X-Sonic-MF:From:To:Subject:Date:From:Subject;
 b=AvAspnm9ChSpZbNQwA87kS9dhToZkcy27+BVQ4t12fYCdgWxX0jGJqFTAaxiYdQbf9aiUX9dGE5xyoOxnqIkswGCRLO8K152lI4pXg5S7ocVrBkqk4DYiQCD1atzb/FEIF8qH5EHxGjUrxFmJ+uDGFWs6p8WWvhYJ+NBjAjOPX/hpTJIDsHoyO26/oaSv/Goxx+n+M44EhTyBDOaTAaEZTv4J06XAl40sqJ3NMEK4X1Nl6Tu5WDjb+3jNgyjfNr7KYgbT8Er4hvQJC1nN+oLR+okNt8AkK54lLPhTIPBZBuyza0O3HD2glj6VSiCBExFI4aqea+noVp6GU8mqr+Axw==
X-YMail-OSG: BybiNLgVM1lnkAwxlO32W3G0jclqFn11pOAxGgpl97VxqohB_zB2x4KZsAac90g
 rpogc3Z6ILsOReQc5U6P57i4I43vKwkoLD6jBRtZ.xSZlFHbWyFjDYCaTeTB5FSUPmp8FwOFVJ5L
 wjodL84ESQex_SyHxRKl_wVVbqI51dz2Cw5vNimRfkGRHVMlPPs9zCCQftRaUSI9EBxTJvd9_oeE
 q4LnT9ql0UAIYHxeCJ0x5mEphVFsLP1DBYjlI2866eVTqS5UKyhtpPRcBbPsKW0CdWg8UEgLZ0mq
 Ic9ovqPOZXVR_KpgCh6kpyz14UCdQbtPXwjdBKB_k8t8OZVYO8_YWdhjna.lO4LcHdef4L93HPUi
 fO5B_8W0bfgaNEH6gbN5BCFdB9zIPs.XXe61JOmaCcaHhND0ezacU8CR3t6GPHFFTV9N.xNwUhXy
 yypyQmjSOT8NGbwmJTCjKqdysAjqRR.48Q30yop94ONEtDfY02PEUUnZ6NGiV1NrPweGdOwEV.IA
 ApOOpa2p0C1vf_Fz34gU_LmzdjSOkpyxkBCSIzaNYDR7UXMIJCH028pVyZuMVuYBaVmPY7XcQAOp
 Klp3vEqKSEEJA4Kp9_pGJ.VdruTJMvmz7.dVE_vc8V4PbEc8ka_Vayq80MViIJ3o7Pn_G3kePTmc
 VJY53Q.r8SUV6z5SlcxpTCETKuuIb29zyVRkR4G6k.cfMClRv7tIxx3DIginRdTYXPcX1xxgMt61
 rgZdweBQO777FiB78eLGCxLgtxbpARl2GIWufkD7nxt8KgQDVBC_TSS8UQMGZ_WigYMPI71AzGZS
 fEdrzc5o_r9Q3.FNVz.cvs9tKZvAQAm_mL._WbuK7unuEePCbhm.m.qMkDuuCjStt9lPPId.so7t
 ck6sksvMAid_tccOvMkEUFgFPGr1CQgyWVygDuqdl4e6PmufM7qHJobfyUdf5dfHb2_mFzvMZgz8
 agwhSfyZ91DR4y1f3.uAHzd.UrF.4vEdt87KiWGWdZSjGTfvWaLD0jbWEtpxsTx61mcBwu8geeli
 tbI_RigB4L_Im9rAohTouoUq0VUY9p3Tfx3cyuX6E.1Ofvt62ckEEgUbtk6kGNoO2C4FFU5WxaEZ
 nwbiacmUXcON4zedQYQnQNji.TZ9fTLKp5PnkglzBgZQ3Dcbxm5Bcj3cTnvFP0hD0NN31BJOwn_.
 YyutxFA_OfP6ebUQpUCoMyYXR0WBSBmeNrx5zHgVeTvsbz9HwCS6JD6iVU0rNK6aKIxHdGH_sxW0
 YVbRqvuF3iLrqO9s0ORYaRENXXHddxiQaGyBC7cpyPI2W7vzbJKO9trATG2KmzRhRn9sGDuaI5G5
 jH0xZ9r1iV2Vl37qOJHxbjmivq0ESM4Y3UNXjUvgufTM1Utw4LmF_AlZyl8EG298dR0yFfH4gKqf
 1avbkNuiXj64aZWlSdwcKTONf8FabfNwTX6qHUSB48_XkNJcaoZjD6LwNUKRrSTH8INLOENKstc7
 Ff4D6nfiGTlCicNkpiDKLASLTrxf0zhVQb3xiO6h.qidPmKlC3hLLwWWkBnzUQpxpWRKTZw2pI2t
 6t.MymBWKCpGUACImJo9bjdJf75lS0jtn.j7XL0yl91S2GdFMD9zQch.OrWyBN75XoTXvsyI5ok7
 z0XbTtWA2rLBWJ.NcJELwYe7M7j.lNl3WNE9VpHYpYFChf7eoXosbc_md2uu.G8A_s1RD7DXOG4D
 JNmRi63asI71xdfGAIuxfugVNzOgExtl76vMQRqEu3EON7UuMdeb.SOUs6rySXqAw.NsuFNohx5z
 QpWxH_hSj2WsRgPqyX27xei.pLsdrSFbWom0N2Rkjl3Ixj9VIEsUUPUNvPEU2FHcqHUR_vQDI.UI
 AWTH8dhukFhqcS1sojdJYJhLy3DmPWZnyaL5DRxx0KjK6v7WYn3clQLorBXzdbazT99Hn4uMouIU
 MVQ3XyHHOtrgc3riXe7h7zFI1YcgkqIEKtrBEcVdyYKhO3QzAHfMgITIctZIaJX9.VC.6goRWvUG
 u0tLw4xn70Ud4GN8rDb2xOabkkeHhN0pmVgo6d.g9ZHJqipMCz87pYi1mKi2k8W5lmeflhE50QkL
 LnUOiTejEmwKrwpsV3sUEiOKpa7Sb9ikYvYb0ZAJ1Y3.vG0m6eyL7tXBBHEI._1xCc5Qz6J15GPc
 Y.WRaKuEwBrxRayOh6qB2wrl3ymikhFaRyYWhHQws0Aq4FhukRS8h1sr9QdTqfGX729rjvpjpOQ_
 oW4Q9_tI82_aPqIxtKtZuk8sa3pBewDIySsxZIykROPF1D5GIz_9.UZqZSZdjdlVs7sSLg3FOoK6
 8hiC0Z6KobCmu8R4lIzk5zJWQD7BcJWTfZULt.h0_yeCz3IoMbF8Rgc70g3.PizMmHV.10ztgxxu
 0M.2Mxeu_fnPPUOywguKvloxk1enu7AdCZ3s0sTtB_evTV8BkyfwL5v576lostSckIb7tXTzShFb
 XlEsx0XpMqN6OEw45JEQjO6E1zmk1SchThh2mI7xVzCIc81sEA_E37cpWpmjzTfbzFmeEi6GLNrZ
 U4h01.L.HpHxVVIHUqnI4XnaGj5AN14NUx1Ioygtd_FLnjcI49ZdPVgFxiTskS6iqQK8JrkIHayD
 MWTi4zOqf6nhn2.LWSh7lxafdMzgyN4lVKchGOfN9x5DQilkcHadfyK3Y9NQ1jUH8s1oupk9CsGa
 9rQbGypRdIcmSYiSmW58-
X-Sonic-MF: <hsiangkao@aol.com>
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic313.consmr.mail.gq1.yahoo.com with HTTP; Sat, 27 Mar 2021 03:50:11 +0000
Received: by kubenode529.mail-prod1.omega.ir2.yahoo.com (VZM Hermes SMTP
 Server) with ESMTPA ID b79f63fb2a60f2e9a0e41858735ab882; 
 Sat, 27 Mar 2021 03:50:04 +0000 (UTC)
To: linux-erofs@lists.ozlabs.org, Chao Yu <yuchao0@huawei.com>,
 Chao Yu <chao@kernel.org>
Subject: [PATCH 3/4] erofs: introduce on-disk lz4 fs configurations
Date: Sat, 27 Mar 2021 11:49:35 +0800
Message-Id: <20210327034936.12537-4-hsiangkao@aol.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210327034936.12537-1-hsiangkao@aol.com>
References: <20210327034936.12537-1-hsiangkao@aol.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Cc: LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Gao Xiang <hsiangkao@redhat.com>

Introduce z_erofs_lz4_cfgs to store all lz4 configurations.
Currently it's only max_distance, but will be used for new
features later.

Signed-off-by: Gao Xiang <hsiangkao@redhat.com>
---
 fs/erofs/decompressor.c | 15 +++++++++++++--
 fs/erofs/erofs_fs.h     |  6 ++++++
 fs/erofs/internal.h     |  8 +++++---
 fs/erofs/super.c        |  2 +-
 4 files changed, 25 insertions(+), 6 deletions(-)

diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
index 93411e9df9b6..97538ff24a19 100644
--- a/fs/erofs/decompressor.c
+++ b/fs/erofs/decompressor.c
@@ -29,9 +29,20 @@ struct z_erofs_decompressor {
 };
 
 int z_erofs_load_lz4_config(struct super_block *sb,
-			    struct erofs_super_block *dsb)
+			    struct erofs_super_block *dsb,
+			    struct z_erofs_lz4_cfgs *lz4, int size)
 {
-	u16 distance = le16_to_cpu(dsb->lz4_max_distance);
+	u16 distance;
+
+	if (lz4) {
+		if (size < sizeof(struct z_erofs_lz4_cfgs)) {
+			erofs_err(sb, "invalid lz4 cfgs, size=%u", size);
+			return -EINVAL;
+		}
+		distance = le16_to_cpu(lz4->max_distance);
+	} else {
+		distance = le16_to_cpu(dsb->lz4_max_distance);
+	}
 
 	EROFS_SB(sb)->lz4.max_distance_pages = distance ?
 					DIV_ROUND_UP(distance, PAGE_SIZE) + 1 :
diff --git a/fs/erofs/erofs_fs.h b/fs/erofs/erofs_fs.h
index b27d0e4e4ab5..1322ae63944b 100644
--- a/fs/erofs/erofs_fs.h
+++ b/fs/erofs/erofs_fs.h
@@ -196,6 +196,12 @@ enum {
 	Z_EROFS_COMPRESSION_MAX
 };
 
+/* 14 bytes (+ length field = 16 bytes) */
+struct z_erofs_lz4_cfgs {
+	__le16 max_distance;
+	u8 reserved[12];
+} __packed;
+
 /*
  * bit 0 : COMPACTED_2B indexes (0 - off; 1 - on)
  *  e.g. for 4k logical cluster size,      4B        if compacted 2B is off;
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 1de60992c3dd..46b977f348eb 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -441,7 +441,8 @@ int erofs_try_to_free_all_cached_pages(struct erofs_sb_info *sbi,
 int erofs_try_to_free_cached_page(struct address_space *mapping,
 				  struct page *page);
 int z_erofs_load_lz4_config(struct super_block *sb,
-			    struct erofs_super_block *dsb);
+			    struct erofs_super_block *dsb,
+			    struct z_erofs_lz4_cfgs *lz4, int len);
 #else
 static inline void erofs_shrinker_register(struct super_block *sb) {}
 static inline void erofs_shrinker_unregister(struct super_block *sb) {}
@@ -450,9 +451,10 @@ static inline void erofs_exit_shrinker(void) {}
 static inline int z_erofs_init_zip_subsystem(void) { return 0; }
 static inline void z_erofs_exit_zip_subsystem(void) {}
 static inline int z_erofs_load_lz4_config(struct super_block *sb,
-				struct erofs_super_block *dsb)
+				  struct erofs_super_block *dsb,
+				  struct z_erofs_lz4_cfgs *lz4, int len)
 {
-	if (dsb->lz4_max_distance) {
+	if (lz4 || dsb->lz4_max_distance) {
 		erofs_err(sb, "lz4 algorithm isn't enabled");
 		return -EINVAL;
 	}
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 3212e4f73f85..1ca8da3f2125 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -189,7 +189,7 @@ static int erofs_read_superblock(struct super_block *sb)
 	}
 
 	/* parse on-disk compression configurations */
-	ret = z_erofs_load_lz4_config(sb, dsb);
+	ret = z_erofs_load_lz4_config(sb, dsb, NULL, 0);
 out:
 	kunmap(page);
 	put_page(page);
-- 
2.20.1

