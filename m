Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3962D290F06
	for <lists+linux-erofs@lfdr.de>; Sat, 17 Oct 2020 07:17:55 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CCrrJ2XsXzDr0l
	for <lists+linux-erofs@lfdr.de>; Sat, 17 Oct 2020 16:17:52 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1602911872;
	bh=EyBbOTLciGBVBe9ur5RGlOtmlnboX022ZqVpmxIoyj8=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=V8SRzeXIwCRS+Mr5HCUrQJVP7WlWEerQKZAWW1ZJpA0AL4IFAB7Bgz6GgN5DNRaX1
	 JMGulEu/vC7N6Q85IbNMCofbgCvjxBawhf/7125/tK8+Ec7Phay+dS5V7CqHVT9OjM
	 RPzvYwgpOQ5rNdgbC0pCvfdStMhESLAHkamIj/h4xxew+MHpPE/U4P/tgW/qh31cNA
	 OBC8VwSCwZkwlsVUnYaziGvt1wYJJZfYUeTF4LCKqUii9h23mZEIyeLEpUzhFFKIY2
	 zkDZjIOMXCUKEcoUB6uP7reKgZlKXxMnfrNqd+NwEVYyl+nUd+V3mN5T/O3OfugFdH
	 cngc/H/YZFTQw==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=aol.com
 (client-ip=98.137.69.206; helo=sonic312-25.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.a=rsa-sha256
 header.s=a2048 header.b=VoTIdxLk; dkim-atps=neutral
Received: from sonic312-25.consmr.mail.gq1.yahoo.com
 (sonic312-25.consmr.mail.gq1.yahoo.com [98.137.69.206])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CCrrB3H0kzDqyg
 for <linux-erofs@lists.ozlabs.org>; Sat, 17 Oct 2020 16:17:45 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1602911861; bh=u5qZ/wQHqconFjsrIF85xs21lLXr44pjOBQJhVcExcQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject;
 b=VoTIdxLk0rH0BgfnEujJ37o7aMqhiCJjyLj5sB9IF9Ti9RC6/neNyUS8A2t9eIY+gEZ+xqi4YWKYyYbSWJoqEsgpS8SVuC6hsmLDot1VT6D+js8l4O1r+6krRQFMgc5fu1DWilB3MQGYC5phiWuRUULIx7xQUjLSNSyug6SiOdYlG40O7EUfH0FtAEDRSkeTLYc6H2vKjf33pjog4REwPPd60V7WjVVR4UtmcF8ah+QUF5Dxenbbr9Iy612+GOo8iIizUYIDEhBe7/cARyOtLb4ropfXoqI0IqLG+pVwwuYLowlBPGygb1N8BwsKa81jyKm8q4zmH33leHJKSjbMVQ==
X-YMail-OSG: xdFdErwVM1lu8JaYeUsdANpLlzYRzVX_g1ANMQZbiC65xDbwX_4FZ24A.7SqZTx
 iacX1C.0Z31_pQwEVEcIcePCjFQ1_N2HqW2JD3.xUUhpEhVicX1XouqrTKZ1kwIf3vRphDOMy5T7
 9FzguXjf5QfoiQCn7JnJUqrRD_nYvl7kolLVThytphXzMVBRCcOTtn8d8zF6fW24UMnWOJiTKM_N
 M55VojWk6W7ov9FVkgIm89v9TUNsZ2KGuq9lMXRYCGDzYxwpdw7eWGV0IYEah9cljzvboIoVARl_
 6LyS4J.Iz6jXkJIw3jd38M5IfM.SwY_uIlbwVLNgkshwyCPnmaX_SUreHN0Lxt2qrtP8i8kSxlmp
 Dm7jxg2b3BVC9_wEodIGp.kAkawBNi8uNfObAQHUK7xjUmkXNIzsVJFM5URlu0ON16EJauQGkJ2Q
 22imOOJMrEw02ttUcoIUnvFAbuxmml8XPiLbiPHsXaiWCq7ELzhVT1cuGQ8xpyPredPPEcxkutQG
 Cor_js0ia7Fs2TmHjklqBcZGEDb4ciMAizvzxXIEXPOBB0K6Dc6P8Yz_zAzE0jTxaopCYONT2KRB
 Asa839eo3jY5PS9.qwhGYIp4JRSRqq2uMjKDrWD4P5h22v7b2F3Pop7r_Fvt.qJg9eWUlQ2m7Pew
 ckF6U3SlY6BSZcTbDNCmXGA12snt0aFzmuQGvFMTtDiTRAJqArl9l6970kRApzZqM7cPG0GUHPhS
 sz.WAYdIRO9AZh_J7fWz3j3CUe4h4NunfhsLO6UZm.p1Pm6Fflj.fcgr5TL3iJja4uTjKHkAF8wC
 bNlCCogDjOPKO_JQG3_.sQOoFMcmClBFBBrqtqJTiDImyObnPgy.zq5jb5u8ozTx2eUE4rmk8UtK
 KA0RezrixheMbgcJQ1QMJ..IZdM9hTTuulym6L_fEP.QBKnci3bPgMXsaSu94gwlCewGlR8hOOGB
 hsE_IafbWKFIGR_VDaS0GQnCeW4LSwxiPTfIF2gkFDc8JX5z2bewfy4Ses9PV8Zr4GO2T7ydLbyp
 HmyV54ivJGf3g62iXXfzZKxVPdy8AMb5OnPAapunki7sXMiY7JE_imS5BVPCqwL9fS0ZNoGHwDwY
 aZXbJC0mXg7QYpchgWS.0jF1bdaII.5V9viM0NhLO5aCqz9jfFLt1dipwNgEyNyEp3oK7bumccQp
 E.eVIl8gsoJmpxapg7fR8fw7um8OOLfqzixlnniTjNFpOovTYpUc22c0xsf.sN7g.9ly.cgmQxDK
 u9flJMPh2gjT_Kgt5m25GOfkh4BUXjgqWz3X6uYRMsNlp_XvKgPw8MnT.G962agJJLbZyKT1wpH_
 3UfoV.4srAlH22KC5ZvGBQA8WEugu_AF8W1bri5OdyN7LQxzIOiiGYe3nnSGqKnY8COm9stP30OV
 KKOBw8_OLX2LN.nyMhav7wN9ZCT_KUX1l8HtQsOVIs5dR3gvyBb6MV3cN0pVk1Uz7T.bq6utoPfg
 Dl95AjJ_.pD17qrQIGYdCIZ3tCy0rLySGZoWoNfI5vS6CM.7Kbf2UIq4dMQC6v9Mr0UbzfY5Q0K7
 nvaIXvd4j
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic312.consmr.mail.gq1.yahoo.com with HTTP; Sat, 17 Oct 2020 05:17:41 +0000
Received: by smtp424.mail.ir2.yahoo.com (VZM Hermes SMTP Server) with ESMTPA
 ID 9d3dc137a63e5241cc606f3cba181f35; 
 Sat, 17 Oct 2020 05:17:38 +0000 (UTC)
To: linux-erofs@lists.ozlabs.org
Subject: [WIP] [PATCH 05/12] erofs-utils: fuse: use proper expression about
 inode size
Date: Sat, 17 Oct 2020 13:16:14 +0800
Message-Id: <20201017051621.7810-6-hsiangkao@aol.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20201017051621.7810-1-hsiangkao@aol.com>
References: <20201017051621.7810-1-hsiangkao@aol.com>
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
Cc: Zhang Shiming <zhangshiming@oppo.com>, Guo Weichao <guoweichao@oppo.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

[ let's fold in to the original patch. ]
Cc: Huang Jianan <huangjianan@oppo.com>
Signed-off-by: Gao Xiang <hsiangkao@aol.com>
---
 fuse/namei.c  | 4 ++--
 fuse/read.c   | 2 +-
 fuse/readir.c | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/fuse/namei.c b/fuse/namei.c
index 510fcfda5a76..0b71072027ce 100644
--- a/fuse/namei.c
+++ b/fuse/namei.c
@@ -172,8 +172,8 @@ struct dcache_entry *disk_lookup(struct dcache_entry *parent, const char *name,
 
 	if (v.datalayout == EROFS_INODE_FLAT_INLINE) {
 		uint32_t dir_off = erofs_blkoff(dirsize);
-		off_t dir_addr = nid2addr(dcache_get_nid(parent))
-			+ sizeof(struct erofs_inode_compact) + v.xattr_isize;
+		off_t dir_addr = nid2addr(dcache_get_nid(parent)) +
+			v.inode_isize + v.xattr_isize;
 
 		memset(buf, 0, sizeof(buf));
 		ret = dev_read(buf, dir_off, dir_addr);
diff --git a/fuse/read.c b/fuse/read.c
index dd44adaa1c40..3f2e49c390de 100644
--- a/fuse/read.c
+++ b/fuse/read.c
@@ -65,7 +65,7 @@ size_t erofs_read_data_inline(struct erofs_vnode *vnode, char *buffer,
 	if (!suminline)
 		goto finished;
 
-	addr = nid2addr(vnode->nid) + sizeof(struct erofs_inode_compact)
+	addr = nid2addr(vnode->nid) + vnode->inode_isize +
 		+ vnode->xattr_isize;
 	ret = dev_read(buffer + rdsz, suminline, addr);
 	if (ret < 0 || (size_t)ret != suminline)
diff --git a/fuse/readir.c b/fuse/readir.c
index 9589685c9122..46ceb1d90a7f 100644
--- a/fuse/readir.c
+++ b/fuse/readir.c
@@ -108,7 +108,7 @@ int erofs_readdir(const char *path, void *buf, fuse_fill_dir_t filler,
 	if (v.datalayout == EROFS_INODE_FLAT_INLINE) {
 		off_t addr;
 
-		addr = nid2addr(nid) + sizeof(struct erofs_inode_compact)
+		addr = nid2addr(nid) + v.inode_isize
 			+ v.xattr_isize;
 
 		memset(dirsbuf, 0, sizeof(dirsbuf));
-- 
2.24.0

