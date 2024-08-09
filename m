Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CB3794D457
	for <lists+linux-erofs@lfdr.de>; Fri,  9 Aug 2024 18:15:56 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Vy4ua+kT;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WgTY62BB3z2ypm
	for <lists+linux-erofs@lfdr.de>; Sat, 10 Aug 2024 02:15:54 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Vy4ua+kT;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.131; helo=out30-131.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WgTY14JGBz2yYy
	for <linux-erofs@lists.ozlabs.org>; Sat, 10 Aug 2024 02:15:47 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1723220143; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=wgFf7IPkfjASt2zPLrFZ3J1oOisxBxtUd2W0zJY0DPI=;
	b=Vy4ua+kTrY+pKiA4qbNPaFPV6XowPerHbQrwH8Xl5PAJNS2svE11zT82HGZKpIj9/p5+yp87cZCUwzV9E/jENY6vx21hXP1IWY7TuXQM+TtGjcdL57Y8eiGvldBq6GVyI24N4cnoiSprq1Gz1acGTsjAMDvggpbBFIL/q7XNtB0=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WCQfCN5_1723220137)
          by smtp.aliyun-inc.com;
          Sat, 10 Aug 2024 00:15:42 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: lib: fix heap-buffer-overflow on read
Date: Sat, 10 Aug 2024 00:15:36 +0800
Message-ID: <20240809161536.3961647-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Wrap up into kite_mf_hc3_skip() for now.

Fixes: 861037f4fc15 ("erofs-utils: add a built-in DEFLATE compressor")
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 lib/kite_deflate.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/lib/kite_deflate.c b/lib/kite_deflate.c
index e52e382..8581834 100644
--- a/lib/kite_deflate.c
+++ b/lib/kite_deflate.c
@@ -746,7 +746,7 @@ int kite_mf_getmatches_hc3(struct kite_matchfinder *mf, u16 depth, u16 bestlen)
 	unsigned int v, hv, i, k, p, wsiz;
 
 	if (mf->end - cur < bestlen + 1)
-		return 0;
+		return -1;
 
 	v = get_unaligned((u16 *)cur);
 	hv = v ^ crc_ccitt_table[cur[2]];
@@ -795,6 +795,14 @@ int kite_mf_getmatches_hc3(struct kite_matchfinder *mf, u16 depth, u16 bestlen)
 	return k - 1;
 }
 
+static void kite_mf_hc3_skip(struct kite_matchfinder *mf)
+{
+	if (kite_mf_getmatches_hc3(mf, 0, 2) >= 0)
+		return;
+	mf->offset++;
+	/* mf->cyclic_pos = (mf->cyclic_pos + 1) & (mf->wsiz - 1); */
+}
+
 /* let's align with zlib */
 static const struct kite_matchfinder_cfg {
 	u16  good_length;	/* reduce lazy search above this match length */
@@ -1057,7 +1065,7 @@ static bool kite_deflate_fast(struct kite_deflate *s)
 		int matches = kite_mf_getmatches_hc3(mf, mf->depth,
 				kMatchMinLen - 1);
 
-		if (matches) {
+		if (matches > 0) {
 			unsigned int len = mf->matches[matches].len;
 			unsigned int dist = mf->matches[matches].dist;
 
@@ -1072,7 +1080,7 @@ static bool kite_deflate_fast(struct kite_deflate *s)
 			s->pos_in += len;
 			/* skip the rest bytes */
 			while (--len)
-				(void)kite_mf_getmatches_hc3(mf, 0, 0);
+				kite_mf_hc3_skip(mf);
 		} else {
 nomatch:
 			mf->matches[0].dist = s->in[s->pos_in];
@@ -1115,17 +1123,19 @@ static bool kite_deflate_slow(struct kite_deflate *s)
 		if (len0 < mf->max_lazy) {
 			matches = kite_mf_getmatches_hc3(mf, mf->depth >>
 				(len0 >= mf->good_len), len0);
-			if (matches) {
+			if (matches > 0) {
 				len = mf->matches[matches].len;
 				if (len == kMatchMinLen &&
 				    mf->matches[matches].dist > ZLIB_DISTANCE_TOO_FAR) {
 					matches = 0;
 					len = kMatchMinLen - 1;
 				}
+			} else {
+				matches = 0;
 			}
 		} else {
 			matches = 0;
-			(void)kite_mf_getmatches_hc3(mf, 0, 0);
+			kite_mf_hc3_skip(mf);
 		}
 
 		if (len < len0) {
@@ -1136,7 +1146,7 @@ static bool kite_deflate_slow(struct kite_deflate *s)
 			s->pos_in += --len0;
 			/* skip the rest bytes */
 			while (--len0)
-				(void)kite_mf_getmatches_hc3(mf, 0, 0);
+				kite_mf_hc3_skip(mf);
 			s->prev_valid = false;
 			s->prev_longest = 0;
 		} else {
-- 
2.43.5

