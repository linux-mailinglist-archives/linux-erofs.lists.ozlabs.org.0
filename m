Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C95B308C1E
	for <lists+linux-erofs@lfdr.de>; Fri, 29 Jan 2021 19:09:05 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DS5251j9YzDsTD
	for <lists+linux-erofs@lfdr.de>; Sat, 30 Jan 2021 05:09:01 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=mail.scut.edu.cn (client-ip=202.38.213.20; helo=mail.scut.edu.cn;
 envelope-from=sehuww@mail.scut.edu.cn; receiver=<UNKNOWN>)
Received: from mail.scut.edu.cn (stumail1.scut.edu.cn [202.38.213.20])
 by lists.ozlabs.org (Postfix) with ESMTP id 4DS51v5FgYzDsDx
 for <linux-erofs@lists.ozlabs.org>; Sat, 30 Jan 2021 05:08:42 +1100 (AEDT)
Received: from localhost.localdomain (unknown [10.1.129.4])
 by front (Coremail) with SMTP id AWSowAB3fOACTxRg6ZwhAg--.22951S4;
 Sat, 30 Jan 2021 02:08:03 +0800 (CST)
From: Hu Weiwen <sehuww@mail.scut.edu.cn>
To: hsiangkao@redhat.com
Subject: [PATCH v2] erofs-utils: fuse: fix random readlink error
Date: Sat, 30 Jan 2021 02:07:47 +0800
Message-Id: <20210129180747.67731-1-sehuww@mail.scut.edu.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210123152213.GB3167351@xiangao.remote.csb>
References: <20210123152213.GB3167351@xiangao.remote.csb>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AWSowAB3fOACTxRg6ZwhAg--.22951S4
X-Coremail-Antispam: 1UD129KBjvJXoW7Zr4DWrWxCr1fKF4furWkCrg_yoW8ZFW5pr
 Wq9rZ5GF1ftry7Wr4ft3Z8Z3WYq3WkKF1UC3yrCw4fA3srJFn8Z3WrAF909w43Cr1kAF4Y
 qanI9wn5urW7JrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUyG14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
 1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r1j
 6r4UM28EF7xvwVC2z280aVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVCY1x0267AKxVWxJr
 0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
 2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
 W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1l42xK82IYc2Ij64vI
 r41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
 xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1Y6r17MIIYrxkI7VAKI48JMIIF0xvE2Ix0
 cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8V
 AvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7Cj
 xVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7VUbrMaUUUUUU==
X-CM-SenderInfo: qsqrljqqwxllyrt6zt1loo2ulxwovvfxof0/1tbiAQAJBlepTBDjTwAWsW
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
Cc: linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

readlink should fill a **null-terminated** string in the buffer.

To achieve this:
1) memset(0) for unmapped extents;
2) make erofsfuse_read() properly returning the actual bytes read;
3) insert a null character if the path is truncated.

Link: https://lore.kernel.org/r/20210121101233.GC6680@DESKTOP-N4CECTO.huww98.cn
Signed-off-by: Hu Weiwen <sehuww@mail.scut.edu.cn>
---
 fuse/main.c | 8 ++++++++
 lib/data.c  | 6 ++++++
 2 files changed, 14 insertions(+)

diff --git a/fuse/main.c b/fuse/main.c
index c162912..70558b0 100644
--- a/fuse/main.c
+++ b/fuse/main.c
@@ -74,6 +74,10 @@ static int erofsfuse_read(const char *path, char *buffer,
 	ret = erofs_pread(&vi, buffer, size, offset);
 	if (ret)
 		return ret;
+	if (offset + size > vi.i_size)
+		return vi.i_size - offset;
+	if (offset >= vi.i_size)
+		return 0;
 	return size;
 }
 
@@ -83,6 +87,10 @@ static int erofsfuse_readlink(const char *path, char *buffer, size_t size)
 
 	if (ret < 0)
 		return ret;
+	DBG_BUGON(ret > size);
+	if (ret == size)
+		buffer[size - 1] = '\0';
+	erofs_dbg("readlink result %s", buffer);
 	return 0;
 }
 
diff --git a/lib/data.c b/lib/data.c
index 3781846..3641536 100644
--- a/lib/data.c
+++ b/lib/data.c
@@ -29,6 +29,7 @@ static int erofs_map_blocks_flatmode(struct erofs_inode *inode,
 	if (offset >= inode->i_size) {
 		/* leave out-of-bound access unmapped */
 		map->m_flags = 0;
+		map->m_plen = 0;
 		goto out;
 	}
 
@@ -91,9 +92,13 @@ static int erofs_read_raw_data(struct erofs_inode *inode, char *buffer,
 
 		if (!(map.m_flags & EROFS_MAP_MAPPED)) {
 			if (!map.m_llen) {
+				/* reached EOF */
+				memset(buffer + ptr - offset, 0,
+				       offset + size - ptr);
 				ptr = offset + size;
 				continue;
 			}
+			memset(buffer + map.m_la - offset, 0, map.m_llen);
 			ptr = map.m_la + map.m_llen;
 			continue;
 		}
@@ -138,6 +143,7 @@ static int z_erofs_read_data(struct erofs_inode *inode, char *buffer,
 			return ret;
 
 		if (!(map.m_flags & EROFS_MAP_MAPPED)) {
+			memset(buffer + map.m_la - offset, 0, map.m_llen);
 			end = map.m_la;
 			continue;
 		}
-- 
2.25.1

