Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id E545D28F37A
	for <lists+linux-erofs@lfdr.de>; Thu, 15 Oct 2020 15:40:30 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CBr582wzczDqR1
	for <lists+linux-erofs@lfdr.de>; Fri, 16 Oct 2020 00:40:28 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1036;
 helo=mail-pj1-x1036.google.com; envelope-from=jnhuang95@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=Te2LJm93; dkim-atps=neutral
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com
 [IPv6:2607:f8b0:4864:20::1036])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CBr5033tczDqMm
 for <linux-erofs@lists.ozlabs.org>; Fri, 16 Oct 2020 00:40:19 +1100 (AEDT)
Received: by mail-pj1-x1036.google.com with SMTP id az3so1865488pjb.4
 for <linux-erofs@lists.ozlabs.org>; Thu, 15 Oct 2020 06:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=hFnZ1ctE5iW7lEBAaRyA5LfNVdPI/FftfcYyc2lKcyM=;
 b=Te2LJm93DJOFWlgUH/k8IjpKvdGxFuTvNBHW4GuQWUJkT7BXyo4I+31huGLcXkyrRz
 saS9KHGxqLaEr/Nk4L9C26pEoaRBtKnrkOXHlp2ipMzWzX1UBlO6qFCIiraz+4AYyC38
 MUAYNDhiT2eACBcgPVJR13VlOiitGEpXehsTRHWS1TDmud25TzDkosPNX7zEV4s2yU72
 w+MlSf0A/b2EGHo2erHFZl1b7Eo5RSoQFBDGS02v4Z6RSCzDpW/WePzy8BBAWGbpHXC/
 0rC3rFXlztMwEr2kukYY3EIdA1xCtSgIsbQg0ph/khxVTNaNur3tOIkDYk8Ze9I9KeXU
 ashw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=hFnZ1ctE5iW7lEBAaRyA5LfNVdPI/FftfcYyc2lKcyM=;
 b=DqJ5+hr1b9FJbGNLjmTVrKC1ouB6YxhTR6p3ryuj4oIitpOAHevJuDwyYSlZvS1jNh
 67BpdZ5BRlR2uvCQwEFJaLqFCQaL/tgj56Yli05oId/K72fhNOI1aysRC6wdPtaTI335
 KhFWuZO2xpN6fBtkCf1VtJzT/Z4Ej+pdYzBeovV9LVnm5oHcQ/TxiQ0Zw7ZdauKCC6pd
 /cqm9fQZwkzSD4Ec2jRW1/5TA2aO8HtHeqk7cXs9DkayGo2TI2jfc9NRkJdaLYUgfq6X
 dPRFwEf6q/Fiz+w3XGgENTZTWAOsc2liwyo+005fngSbZkJRbZHxmMsvWivvAZh0S8+E
 q/WA==
X-Gm-Message-State: AOAM531c1+DXaCCW06/OBgoTMe6EeRpXtWJy1FyIBLtIlMp/TQcatlGW
 8A2bJ4jE0+VMt+pwPda7Zd43eAzZWvRnFfPy
X-Google-Smtp-Source: ABdhPJxndX6DULjd/DwhZN63mBVmuI61iChXndM+aKl09Kv5QcGKkeqEwG715l/zuhFOvNr9tIky8w==
X-Received: by 2002:a17:902:402:b029:d5:ac47:c33f with SMTP id
 2-20020a1709020402b02900d5ac47c33fmr4103762ple.60.1602769216145; 
 Thu, 15 Oct 2020 06:40:16 -0700 (PDT)
Received: from localhost.localdomain (69-172-89-151.static.imsbiz.com.
 [69.172.89.151])
 by smtp.gmail.com with ESMTPSA id a19sm3426058pjq.29.2020.10.15.06.40.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2020 06:40:15 -0700 (PDT)
From: Huang Jianan <jnhuang95@gmail.com>
X-Google-Original-From: Huang Jianan <huangjianan@oppo.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 2/5] erofs-utils: fix the wrong name length of tail file in
 the directory
Date: Thu, 15 Oct 2020 21:39:56 +0800
Message-Id: <20201015133959.61007-2-huangjianan@oppo.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201015133959.61007-1-huangjianan@oppo.com>
References: <20201015133959.61007-1-huangjianan@oppo.com>
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
Cc: guoweichao@oppo.com, zhangshiming@oppo.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

The file name doesn't end with '\0' if it just fill a block, so we shouldn't use strlen to get file name length, fix it.

Signed-off-by: Huang Jianan <huangjianan@oppo.com>
Signed-off-by: Guo Weichao <guoweichao@oppo.com>
---
 fuse/namei.c  | 10 ++++++----
 fuse/readir.c | 14 ++++++++------
 2 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/fuse/namei.c b/fuse/namei.c
index ded9207..21e6ba0 100644
--- a/fuse/namei.c
+++ b/fuse/namei.c
@@ -87,7 +87,8 @@ int erofs_iget_by_nid(erofs_nid_t nid, struct erofs_vnode *vi)
 
 /* dirent + name string */
 struct dcache_entry *list_name(const char *buf, struct dcache_entry *parent,
-				const char *name, unsigned int len)
+				const char *name, unsigned int len,
+				uint32_t dirend)
 {
 	struct dcache_entry *entry = NULL;
 	struct erofs_dirent *ds, *de;
@@ -99,7 +100,8 @@ struct dcache_entry *list_name(const char *buf, struct dcache_entry *parent,
 		erofs_nid_t nid = le64_to_cpu(ds->nid);
 		uint16_t nameoff = le16_to_cpu(ds->nameoff);
 		char *d_name = (char *)(buf + nameoff);
-		uint16_t name_len = (ds + 1 >= de) ? (uint16_t)strlen(d_name) :
+		uint16_t name_len = (ds + 1 >= de) ?
+			(uint16_t)strnlen(d_name, dirend - nameoff) :
 			le16_to_cpu(ds[1].nameoff) - nameoff;
 
 		#if defined(EROFS_DEBUG_ENTRY)
@@ -146,7 +148,7 @@ struct dcache_entry *disk_lookup(struct dcache_entry *parent, const char *name,
 		if (dev_read_blk(buf, blkno + nr_cnt) != EROFS_BLKSIZ)
 			return NULL;
 
-		entry = list_name(buf, parent, name, name_len);
+		entry = list_name(buf, parent, name, name_len, EROFS_BLKSIZ);
 		if (entry)
 			goto next;
 
@@ -163,7 +165,7 @@ struct dcache_entry *disk_lookup(struct dcache_entry *parent, const char *name,
 		if (ret < 0 && (uint32_t)ret != dir_off)
 			return NULL;
 
-		entry = list_name(buf, parent, name, name_len);
+		entry = list_name(buf, parent, name, name_len, dir_off);
 	}
 next:
 	return entry;
diff --git a/fuse/readir.c b/fuse/readir.c
index 367f935..9589685 100644
--- a/fuse/readir.c
+++ b/fuse/readir.c
@@ -17,7 +17,8 @@
 #include "logging.h"
 #include "init.h"
 
-erofs_nid_t split_entry(char *entry, off_t ofs, char *end, char *name)
+erofs_nid_t split_entry(char *entry, off_t ofs, char *end, char *name,
+			uint32_t dirend)
 {
 	struct erofs_dirent *de = (struct erofs_dirent *)(entry + ofs);
 	uint16_t nameoff = le16_to_cpu(de->nameoff);
@@ -25,7 +26,7 @@ erofs_nid_t split_entry(char *entry, off_t ofs, char *end, char *name)
 	uint32_t de_namelen;
 
 	if ((void *)(de + 1) >= (void *)end)
-		de_namelen = strlen(de_name);
+		de_namelen = strnlen(de_name, dirend - nameoff);
 	else
 		de_namelen = le16_to_cpu(de[1].nameoff) - nameoff;
 
@@ -34,7 +35,8 @@ erofs_nid_t split_entry(char *entry, off_t ofs, char *end, char *name)
 	return le64_to_cpu(de->nid);
 }
 
-int fill_dir(char *entrybuf, fuse_fill_dir_t filler, void *buf)
+int fill_dir(char *entrybuf, fuse_fill_dir_t filler, void *buf,
+	     uint32_t dirend)
 {
 	uint32_t ofs;
 	uint16_t nameoff;
@@ -45,7 +47,7 @@ int fill_dir(char *entrybuf, fuse_fill_dir_t filler, void *buf)
 	end = entrybuf + nameoff;
 	ofs = 0;
 	while (ofs < nameoff) {
-		(void)split_entry(entrybuf, ofs, end, name);
+		(void)split_entry(entrybuf, ofs, end, name, dirend);
 		filler(buf, name, NULL, 0);
 		ofs += sizeof(struct erofs_dirent);
 	}
@@ -99,7 +101,7 @@ int erofs_readdir(const char *path, void *buf, fuse_fill_dir_t filler,
 		ret = dev_read_blk(dirsbuf, v.raw_blkaddr + nr_cnt);
 		if (ret != EROFS_BLKSIZ)
 			return -EIO;
-		fill_dir(dirsbuf, filler, buf);
+		fill_dir(dirsbuf, filler, buf, EROFS_BLKSIZ);
 		++nr_cnt;
 	}
 
@@ -113,7 +115,7 @@ int erofs_readdir(const char *path, void *buf, fuse_fill_dir_t filler,
 		ret = dev_read(dirsbuf, dir_off, addr);
 		if (ret < 0 || (uint32_t)ret != dir_off)
 			return -EIO;
-		fill_dir(dirsbuf, filler, buf);
+		fill_dir(dirsbuf, filler, buf, dir_off);
 	}
 
 	return 0;
-- 
2.25.1

