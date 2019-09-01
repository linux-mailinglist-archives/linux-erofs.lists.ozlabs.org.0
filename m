Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 690BDA479B
	for <lists+linux-erofs@lfdr.de>; Sun,  1 Sep 2019 07:52:23 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46Lj6D2CcdzDqty
	for <lists+linux-erofs@lfdr.de>; Sun,  1 Sep 2019 15:52:20 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1567317140;
	bh=lWeRYc1+QDNq8i6eNz19W8EJLIo0EgiOoNUhYBadr5s=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=OaSHCiXHl0paF0e3uBFuTeJRBOoVDZGnnsVd23f80V+DFClC/v0UVQppvNjSwDO9z
	 t9qw2NCw0Hk8KAyxTy0LnTnp2OH8hXU387kLcfQqS5pBwbu7JQuxQ+elgwJJSN5H54
	 nyCVj3ramwcSIDQ7eZLv1QSiZXZgz0EFRTLnEnQS0yBjqFSSMz/BSbhwKdrHTRAk9K
	 I0wFWDjawykSPfVKUvHV2pkfO6iOXOTlxmCiF1/w54IAe3uoFXkKjc9q3PYimdzCvf
	 bXzSQvbIZAPB0m8wtbxCwQyA5vlk1g7VfHrQpmKuVlF4XJad0QifpXPLakNEMkov4k
	 d+LTkchV5wrYA==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=aol.com
 (client-ip=98.137.65.84; helo=sonic313-21.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.b="EchoCK6d"; 
 dkim-atps=neutral
Received: from sonic313-21.consmr.mail.gq1.yahoo.com
 (sonic313-21.consmr.mail.gq1.yahoo.com [98.137.65.84])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46Lj5v4p3MzDqlm
 for <linux-erofs@lists.ozlabs.org>; Sun,  1 Sep 2019 15:52:02 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1567317119; bh=ngiBIgLQwzykiSUDwOXrihAxoles6AqD482llk2jyD8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject;
 b=EchoCK6drKyqLiGt9m40X/zvE9mgUTB7IR3RZy4rMS9npASfy4cHaRt4lytOQbk5xUoak2tEGGkJ+8VzmlXFQS7hPSs3lGpX+I+KbhyidIMHXk2h9c0UtQXmWQUiirizirSJeSpXfiDaqkjif3rq6w4QTl9AbJyaFOZMEBbOcL8pZbOnuFjfT5KhEwu/TlKWQvf6F+RhN1zZ6FJntT5IC9XPb9PdrkELqb3btxSd88qUEd8KpZ5vrDhFeiJTP9Cfstv0GLTUkztaiB5ssb+FppW9BR4EcTbseQ4B57hmiGca4v3DKpQCf+e7CIrY2ju1QRqlihCXAsigDJLDigORXA==
X-YMail-OSG: gj6ee2EVM1k7lMxJPisAy8532wBcyUVBL3W_b036PmvPNzSd2Y4AivS_aB7hzhM
 wRO.70SaMKauFUiXa4wd5Da0uh9RL_AH35OUEPkjqDS2a_t9V_cJf0pCzmHB6IpJhoXCwRVusZFl
 Z9t_ydjMugmJ.mu42IJSC8TKiiC7kmyEcBml.C4uHXDFSkq8fAo1A9abdNuQ.jzcFBzhHTMuD_yk
 rwIi8mBWhB.zGAsvADH5boeM2z.H7F4xlSbJaobO6EGH5BbR3kGaa_kjDEtbECPoo.yDz5sWpeWF
 p6cjs82qXWR5YuuqVvcPB029MxDaJnkEtgeL3GhIAXNYK7bjMPcsZxgmljJP8RlzzeNeTAGgv5Nz
 m0v91e.5f5746da0vGED5.Jcj4SyA3IH5RtnsgABPiNkV_lPyen_2p2Nfyzj_gm5Yhrh7xkVnQYJ
 H.bnI_bD3n6B.whu89C99g912TET3SbDtBxvpGtrcUSdxS77RsTKlMqm5jgWRoUcy69eFUdsFQ57
 bBMhgT0Q23Xmm.bxtHWL_BaxAt9F4uuTD2yAKEEJ92cnSCAUkd5DUjyigP8Vw9ciE4jZm8xtAOeu
 elN6Gxjvh8D5jWTcXvdy9r9QwLrSasF1JitPgTArWNUiulAeYgIb7k8mPV7f9ZVjZ_Kol.QmttfH
 Ff30CAq3vwmfC1nI1Co.5D5kDFwyYXZV8tIVheOXwWMvdOVunnO.EUK50Cq7zEW.J.yQkRtcT8vT
 BYVD0.3mTFn5m48LYoSh.6.8z.M.yW52V86lSiAdKWbskqht7ntueOvkxeKwPUONVwoakT9GyFFf
 96hGM2Ykd6rsswIgd5ePulR7IBbNe4bBZ.J9P7tcz1OI_7a9_t65GdrhNFbZQonGlhM9RXvGujJK
 HGZslKCs42UsOc2WLOe46z_CM_eJo0CTL9gprJcuov_xXRSKPhz2s0YclXaRV7QJUqASkBziag1b
 8jjI.4_zu9XWKMo.nOY.Dp6LXMXlRC3cVZwjaCUm2oQkojic.hRJN0BpUkE0XCGbEUgYj1sVWaD7
 6aUnR2iXU8UcC6iqY8r55jz3jy_8iInotL_aDXTNpS79ZWLYxzK1_HzxAbnkLri83p_pV1vOILJ_
 ETsb9eIO1AqoryEn_d9WKg5tIfvTKJZnqZMr9ryLpKZcx_4GvgRl5RCvHudApM.Pf8y2gPP0f5Ac
 xFDOHDzWd3Px204_fxLeTGodu81YFYP6T0aG7Tr0Hook5BxR6uhDsuLmTSWksjCHrytYIaL7uWSX
 UHt8.BdiigzpiDNC78APJIfb80ny73yt5dBMD9rA-
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic313.consmr.mail.gq1.yahoo.com with HTTP; Sun, 1 Sep 2019 05:51:59 +0000
Received: by smtp406.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA
 ID 426e3b5ec1af9e36f409445c51071a70; 
 Sun, 01 Sep 2019 05:51:57 +0000 (UTC)
To: Christoph Hellwig <hch@infradead.org>, Chao Yu <yuchao0@huawei.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 02/21] erofs: on-disk format should have explicitly assigned
 numbers
Date: Sun,  1 Sep 2019 13:51:11 +0800
Message-Id: <20190901055130.30572-3-hsiangkao@aol.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190901055130.30572-1-hsiangkao@aol.com>
References: <20190802125347.166018-1-gaoxiang25@huawei.com>
 <20190901055130.30572-1-hsiangkao@aol.com>
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
Cc: linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org,
 linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Gao Xiang <gaoxiang25@huawei.com>

As Christoph claimed [1], on-disk format should have
explicitly assigned numbers. I have to change it.

[1] https://lore.kernel.org/r/20190829095954.GB20598@infradead.org/
Reported-by: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
 fs/erofs/erofs_fs.h | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/fs/erofs/erofs_fs.h b/fs/erofs/erofs_fs.h
index 49335fff9d65..d1f152a3670a 100644
--- a/fs/erofs/erofs_fs.h
+++ b/fs/erofs/erofs_fs.h
@@ -53,10 +53,10 @@ struct erofs_super_block {
  * 4~7 - reserved
  */
 enum {
-	EROFS_INODE_FLAT_PLAIN,
-	EROFS_INODE_FLAT_COMPRESSION_LEGACY,
-	EROFS_INODE_FLAT_INLINE,
-	EROFS_INODE_FLAT_COMPRESSION,
+	EROFS_INODE_FLAT_PLAIN			= 0,
+	EROFS_INODE_FLAT_COMPRESSION_LEGACY	= 1,
+	EROFS_INODE_FLAT_INLINE			= 2,
+	EROFS_INODE_FLAT_COMPRESSION		= 3,
 	EROFS_INODE_LAYOUT_MAX
 };
 
@@ -184,7 +184,7 @@ struct erofs_xattr_entry {
 
 /* available compression algorithm types */
 enum {
-	Z_EROFS_COMPRESSION_LZ4,
+	Z_EROFS_COMPRESSION_LZ4	= 0,
 	Z_EROFS_COMPRESSION_MAX
 };
 
@@ -242,10 +242,10 @@ struct z_erofs_map_header {
  *                (di_advise could be 0, 1 or 2)
  */
 enum {
-	Z_EROFS_VLE_CLUSTER_TYPE_PLAIN,
-	Z_EROFS_VLE_CLUSTER_TYPE_HEAD,
-	Z_EROFS_VLE_CLUSTER_TYPE_NONHEAD,
-	Z_EROFS_VLE_CLUSTER_TYPE_RESERVED,
+	Z_EROFS_VLE_CLUSTER_TYPE_PLAIN		= 0,
+	Z_EROFS_VLE_CLUSTER_TYPE_HEAD		= 1,
+	Z_EROFS_VLE_CLUSTER_TYPE_NONHEAD	= 2,
+	Z_EROFS_VLE_CLUSTER_TYPE_RESERVED	= 3,
 	Z_EROFS_VLE_CLUSTER_TYPE_MAX
 };
 
-- 
2.17.1

