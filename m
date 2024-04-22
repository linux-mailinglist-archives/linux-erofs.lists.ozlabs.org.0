Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 946A68ACC0E
	for <lists+linux-erofs@lfdr.de>; Mon, 22 Apr 2024 13:31:47 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VNNPX30w0z2xQL
	for <lists+linux-erofs@lfdr.de>; Mon, 22 Apr 2024 21:31:44 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=sjtu.edu.cn (client-ip=202.120.2.232; helo=smtp232.sjtu.edu.cn; envelope-from=zhaoyifan@sjtu.edu.cn; receiver=lists.ozlabs.org)
Received: from smtp232.sjtu.edu.cn (smtp232.sjtu.edu.cn [202.120.2.232])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VNNPR2dcpz2xQL
	for <linux-erofs@lists.ozlabs.org>; Mon, 22 Apr 2024 21:31:39 +1000 (AEST)
Received: from proxy188.sjtu.edu.cn (smtp188.sjtu.edu.cn [202.120.2.188])
	by smtp232.sjtu.edu.cn (Postfix) with ESMTPS id 6C8211008C718
	for <linux-erofs@lists.ozlabs.org>; Mon, 22 Apr 2024 19:31:35 +0800 (CST)
Received: from zhaoyf.ipads-lab.se.sjtu.edu.cn (unknown [202.120.40.82])
	by proxy188.sjtu.edu.cn (Postfix) with ESMTPSA id E825737C93C;
	Mon, 22 Apr 2024 19:31:33 +0800 (CST)
From: Yifan Zhao <zhaoyifan@sjtu.edu.cn>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v2] erofs-utils: fsck: extract chunk-based file with hole correctly
Date: Mon, 22 Apr 2024 19:31:32 +0800
Message-ID: <20240422113132.276631-1-zhaoyifan@sjtu.edu.cn>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240422100521.206071-1-zhaoyifan@sjtu.edu.cn>
References: <20240422100521.206071-1-zhaoyifan@sjtu.edu.cn>
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
changelog since v1:
- use lseek instead of write zero to the hole

 fsck/main.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/fsck/main.c b/fsck/main.c
index e5c37be..249ccd4 100644
--- a/fsck/main.c
+++ b/fsck/main.c
@@ -470,7 +470,7 @@ static int erofs_verify_inode_data(struct erofs_inode *inode, int outfd)
 		pos += map.m_llen;
 
 		/* should skip decomp? */
-		if (!(map.m_flags & EROFS_MAP_MAPPED) || !fsckcfg.check_decomp)
+		if (map.m_la >= inode->i_size || !fsckcfg.check_decomp)
 			continue;
 
 		if (map.m_plen > Z_EROFS_PCLUSTER_MAX_SIZE) {
@@ -513,6 +513,15 @@ static int erofs_verify_inode_data(struct erofs_inode *inode, int outfd)
 		} else {
 			u64 p = 0;
 
+			if (!(map.m_flags & EROFS_MAP_MAPPED)) {
+				ret = lseek(outfd, map.m_llen, SEEK_CUR);
+				if (ret < 0) {
+					ret = -errno;
+					goto out;
+				}
+				continue;
+			}
+
 			do {
 				u64 count = min_t(u64, alloc_rawsize,
 						  map.m_llen);
-- 
2.44.0

