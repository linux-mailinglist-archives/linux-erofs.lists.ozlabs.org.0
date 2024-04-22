Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id F2A6C8ACA2E
	for <lists+linux-erofs@lfdr.de>; Mon, 22 Apr 2024 12:05:43 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VNLVF1Gq7z3cYj
	for <lists+linux-erofs@lfdr.de>; Mon, 22 Apr 2024 20:05:41 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=sjtu.edu.cn (client-ip=202.120.2.232; helo=smtp232.sjtu.edu.cn; envelope-from=zhaoyifan@sjtu.edu.cn; receiver=lists.ozlabs.org)
Received: from smtp232.sjtu.edu.cn (smtp232.sjtu.edu.cn [202.120.2.232])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VNLV73530z3cVD
	for <linux-erofs@lists.ozlabs.org>; Mon, 22 Apr 2024 20:05:33 +1000 (AEST)
Received: from proxy188.sjtu.edu.cn (smtp188.sjtu.edu.cn [202.120.2.188])
	by smtp232.sjtu.edu.cn (Postfix) with ESMTPS id B52DA1008DC9D
	for <linux-erofs@lists.ozlabs.org>; Mon, 22 Apr 2024 18:05:24 +0800 (CST)
Received: from zhaoyf.ipads-lab.se.sjtu.edu.cn (unknown [202.120.40.82])
	by proxy188.sjtu.edu.cn (Postfix) with ESMTPSA id 53D3637C984;
	Mon, 22 Apr 2024 18:05:22 +0800 (CST)
From: Yifan Zhao <zhaoyifan@sjtu.edu.cn>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: fsck: extract chunk-based file with hole correctly
Date: Mon, 22 Apr 2024 18:05:21 +0800
Message-ID: <20240422100521.206071-1-zhaoyifan@sjtu.edu.cn>
X-Mailer: git-send-email 2.44.0
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
Cc: Yifan Zhao <zhaoyifan@sjtu.edu.cn>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Currently fsck skips file extraction if it finds that EROFS_MAP_MAPPED
is unset, which is not the case for chunk-based files with hole. This
patch handles the corner case correctly.

Signed-off-by: Yifan Zhao <zhaoyifan@sjtu.edu.cn>
---
 fsck/main.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/fsck/main.c b/fsck/main.c
index e5c37be..c10b68e 100644
--- a/fsck/main.c
+++ b/fsck/main.c
@@ -470,7 +470,7 @@ static int erofs_verify_inode_data(struct erofs_inode *inode, int outfd)
 		pos += map.m_llen;
 
 		/* should skip decomp? */
-		if (!(map.m_flags & EROFS_MAP_MAPPED) || !fsckcfg.check_decomp)
+		if (map.m_la >= inode->i_size || !fsckcfg.check_decomp)
 			continue;
 
 		if (map.m_plen > Z_EROFS_PCLUSTER_MAX_SIZE) {
@@ -517,9 +517,14 @@ static int erofs_verify_inode_data(struct erofs_inode *inode, int outfd)
 				u64 count = min_t(u64, alloc_rawsize,
 						  map.m_llen);
 
-				ret = erofs_read_one_data(inode, &map, raw, p, count);
-				if (ret)
-					goto out;
+				if (!(map.m_flags & EROFS_MAP_MAPPED)) {
+					memset(raw, 0, count);
+				} else {
+					ret = erofs_read_one_data(
+						inode, &map, raw, p, count);
+					if (ret)
+						goto out;
+				}
 
 				if (outfd >= 0 && write(outfd, raw, count) < 0)
 					goto fail_eio;
-- 
2.44.0

