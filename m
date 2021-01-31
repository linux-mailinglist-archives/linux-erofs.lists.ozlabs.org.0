Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 38607309B40
	for <lists+linux-erofs@lfdr.de>; Sun, 31 Jan 2021 10:46:40 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DT5nS4g5wzDrR7
	for <lists+linux-erofs@lfdr.de>; Sun, 31 Jan 2021 20:46:36 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=mail.scut.edu.cn (client-ip=202.38.213.20; helo=mail.scut.edu.cn;
 envelope-from=sehuww@mail.scut.edu.cn; receiver=<UNKNOWN>)
Received: from mail.scut.edu.cn (stumail1.scut.edu.cn [202.38.213.20])
 by lists.ozlabs.org (Postfix) with ESMTP id 4DT5nD6VLfzDrPq
 for <linux-erofs@lists.ozlabs.org>; Sun, 31 Jan 2021 20:46:20 +1100 (AEDT)
Received: from localhost.localdomain (unknown [10.1.129.140])
 by front (Coremail) with SMTP id AWSowAAXHuJKfBZguSAqAg--.32341S4;
 Sun, 31 Jan 2021 17:45:46 +0800 (CST)
From: Hu Weiwen <sehuww@mail.scut.edu.cn>
To: Gao Xiang <hsiangkao@redhat.com>,
	linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: fix mkfs flush inode i_u
Date: Sun, 31 Jan 2021 17:45:25 +0800
Message-Id: <20210131094525.168251-1-sehuww@mail.scut.edu.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AWSowAAXHuJKfBZguSAqAg--.32341S4
X-Coremail-Antispam: 1UD129KBjvdXoWrKrW3ZF1fury3XF1UWryUJrb_yoWkWwc_Zw
 s5Wr48Jr17ZanYvrs5Jw4rJrs0yw4DGFsF9w4S9FWft34jqw4kWr47Wr4DCF1UWF1DWrZ3
 GFsakFWxAwn5GjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUIcSsGvfJTRUUUb2kFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
 6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
 A2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Jr0_
 Gr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4j6r
 4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
 I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
 4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY02Avz4vE-syl42xK
 82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGw
 C20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1Y6r17MIIYrxkI7VAKI48J
 MIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMI
 IF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvE
 x4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7VUbrMaUUUUUU==
X-CM-SenderInfo: qsqrljqqwxllyrt6zt1loo2ulxwovvfxof0/1tbiAQAJBlepTBDjTwAYsY
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

When choosing which field of i_u to use, it should be `inode->i_mode & S_IFMT'

Previously, the default branch is always taken. Fortunately, all 3 field has
the same data type, and they are in the same union, so it happens to work.

Signed-off-by: Hu Weiwen <sehuww@mail.scut.edu.cn>
---
 lib/inode.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/inode.c b/lib/inode.c
index 73a7e69..0ed4264 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -412,7 +412,7 @@ static bool erofs_bh_flush_write_inode(struct erofs_buffer_head *bh)
 		u.dic.i_uid = cpu_to_le16((u16)inode->i_uid);
 		u.dic.i_gid = cpu_to_le16((u16)inode->i_gid);
 
-		switch ((inode->i_mode) >> S_SHIFT) {
+		switch (inode->i_mode & S_IFMT) {
 		case S_IFCHR:
 		case S_IFBLK:
 		case S_IFIFO:
@@ -445,7 +445,7 @@ static bool erofs_bh_flush_write_inode(struct erofs_buffer_head *bh)
 		u.die.i_ctime = cpu_to_le64(inode->i_ctime);
 		u.die.i_ctime_nsec = cpu_to_le32(inode->i_ctime_nsec);
 
-		switch ((inode->i_mode) >> S_SHIFT) {
+		switch (inode->i_mode & S_IFMT) {
 		case S_IFCHR:
 		case S_IFBLK:
 		case S_IFIFO:
-- 
2.25.1

