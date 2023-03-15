Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 764046BAAB8
	for <lists+linux-erofs@lfdr.de>; Wed, 15 Mar 2023 09:25:46 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Pc3PM49Xdz3cdK
	for <lists+linux-erofs@lfdr.de>; Wed, 15 Mar 2023 19:25:43 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.118; helo=out30-118.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Pc3PD1JB6z3bh3
	for <linux-erofs@lists.ozlabs.org>; Wed, 15 Mar 2023 19:25:34 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R391e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0VdvbHpt_1678868724;
Received: from e18g06460.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VdvbHpt_1678868724)
          by smtp.aliyun-inc.com;
          Wed, 15 Mar 2023 16:25:29 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: fix PERFORMANCE.md typos
Date: Wed, 15 Mar 2023 16:25:23 +0800
Message-Id: <20230315082523.10314-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.24.4
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

Trivial updates.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 docs/PERFORMANCE.md | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/docs/PERFORMANCE.md b/docs/PERFORMANCE.md
index fdf4f79..5431856 100644
--- a/docs/PERFORMANCE.md
+++ b/docs/PERFORMANCE.md
@@ -36,7 +36,9 @@ Note that that dataset can be replaced regularly, and the SHA1 of the snapshot "
 
 ## Sequential data access
 
+```bash
 hyperfine -p "echo 3 > /proc/sys/vm/drop_caches; sleep 1" "tar cf - . | cat > /dev/null"
+```
 
 | Filesystem | Cluster size | Time                            |
 |------------|--------------|---------------------------------|
@@ -49,7 +51,9 @@ hyperfine -p "echo 3 > /proc/sys/vm/drop_caches; sleep 1" "tar cf - . | cat > /d
 
 ## Sequential metadata access
 
+```bash
 hyperfine -p "echo 3 > /proc/sys/vm/drop_caches; sleep 1" "tar cf /dev/null ."
+```
 
 | Filesystem | Cluster size | Time                            |
 |------------|--------------|---------------------------------|
@@ -64,8 +68,10 @@ hyperfine -p "echo 3 > /proc/sys/vm/drop_caches; sleep 1" "tar cf /dev/null ."
 
 ## Small random data access (~7%)
 
+```bash
 find mnt -type f -printf "%p\n" | sort -R | head -n 500 > list.txt
 hyperfine -p "echo 3 > /proc/sys/vm/drop_caches; sleep 1" "cat list.txt | xargs cat > /dev/null"
+```
 
 | Filesystem | Cluster size | Time                            |
 |------------|--------------|---------------------------------|
@@ -79,8 +85,10 @@ hyperfine -p "echo 3 > /proc/sys/vm/drop_caches; sleep 1" "cat list.txt | xargs
 
 ## Small random metadata access (~7%)
 
+```bash
 find mnt -type f -printf "%p\n" | sort -R | head -n 500 > list.txt
 hyperfine -p "echo 3 > /proc/sys/vm/drop_caches; sleep 1" "cat list.txt | xargs stat"
+```
 
 | Filesystem | Cluster size | Time                            |
 |------------|--------------|---------------------------------|
@@ -93,8 +101,10 @@ hyperfine -p "echo 3 > /proc/sys/vm/drop_caches; sleep 1" "cat list.txt | xargs
 
 ## Full random data access (~100%)
 
+```bash
 find mnt -type f -printf "%p\n" | sort -R > list.txt
 hyperfine -p "echo 3 > /proc/sys/vm/drop_caches; sleep 1" "cat list.txt | xargs cat > /dev/null"
+```
 
 | Filesystem | Cluster size | Time                            |
 |------------|--------------|---------------------------------|
@@ -107,8 +117,10 @@ hyperfine -p "echo 3 > /proc/sys/vm/drop_caches; sleep 1" "cat list.txt | xargs
 
 ## Full random metadata access (~100%)
 
+```bash
 find mnt -type f -printf "%p\n" | sort -R > list.txt
 hyperfine -p "echo 3 > /proc/sys/vm/drop_caches; sleep 1" "cat list.txt | xargs stat"
+```
 
 | Filesystem | Cluster size | Time                            |
 |------------|--------------|---------------------------------|
@@ -130,7 +142,7 @@ hyperfine -p "echo 3 > /proc/sys/vm/drop_caches; sleep 1" "cat list.txt | xargs
 |-----------|------------|--------------|-----------------------------------------------------------|
 | 114339840 | squashfs   | 4096         | -b 4096 -comp lz4 -Xhc -no-xattrs                         |
 | 104972288 | erofs      | 4096         | -zlz4hc,12 -C4096                                         |
-|  98033664 | squashfs   | 16384        | -b 4096 -comp lz4 -Xhc -no-xattrs                         |
+|  98033664 | squashfs   | 16384        | -b 16384 -comp lz4 -Xhc -no-xattrs                        |
 |  89571328 | erofs      | 16384        | -zlz4hc,12 -C16384                                        |
 |  85143552 | squashfs   | 65536        | -b 65536 -comp lz4 -Xhc -no-xattrs                        |
 |  81211392 | squashfs   | 131072       | -b 131072 -comp lz4 -Xhc -no-xattrs                       |
@@ -139,7 +151,9 @@ hyperfine -p "echo 3 > /proc/sys/vm/drop_caches; sleep 1" "cat list.txt | xargs
 
 ## Sequential I/Os
 
+```bash
 fio -filename=silesia.tar -bs=4k -rw=read -name=job1
+```
 
 | Filesystem | Cluster size | Bandwidth |
 |------------|--------------|-----------|
@@ -154,7 +168,9 @@ fio -filename=silesia.tar -bs=4k -rw=read -name=job1
 
 ## Full Random I/Os
 
+```bash
 fio -filename=silesia.tar -bs=4k -rw=randread -name=job1
+```
 
 | Filesystem | Cluster size | Bandwidth |
 |------------|--------------|-----------|
@@ -169,7 +185,9 @@ fio -filename=silesia.tar -bs=4k -rw=randread -name=job1
 
 ## Small Random I/Os (~5%)
 
+```bash
 fio -filename=silesia.tar -bs=4k -rw=randread --io_size=10m -name=job1
+```
 
 | Filesystem | Cluster size | Bandwidth |
 |------------|--------------|-----------|
-- 
2.24.4

