Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E91B309B41
	for <lists+linux-erofs@lfdr.de>; Sun, 31 Jan 2021 10:47:55 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DT5pw5DR3zDrRF
	for <lists+linux-erofs@lfdr.de>; Sun, 31 Jan 2021 20:47:52 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=mail.scut.edu.cn (client-ip=202.38.213.20; helo=mail.scut.edu.cn;
 envelope-from=sehuww@mail.scut.edu.cn; receiver=<UNKNOWN>)
Received: from mail.scut.edu.cn (stumail1.scut.edu.cn [202.38.213.20])
 by lists.ozlabs.org (Postfix) with ESMTP id 4DT5pm0ZpGzDrQ6
 for <linux-erofs@lists.ozlabs.org>; Sun, 31 Jan 2021 20:47:43 +1100 (AEDT)
Received: from localhost.localdomain (unknown [10.1.129.140])
 by front (Coremail) with SMTP id AWSowAAXH+OnfBZgFiIqAg--.19873S4;
 Sun, 31 Jan 2021 17:47:20 +0800 (CST)
From: Hu Weiwen <sehuww@mail.scut.edu.cn>
To: Gao Xiang <hsiangkao@redhat.com>,
	linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: fix BUILD_BUG_ON
Date: Sun, 31 Jan 2021 17:47:32 +0800
Message-Id: <20210131094732.168784-1-sehuww@mail.scut.edu.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AWSowAAXH+OnfBZgFiIqAg--.19873S4
X-Coremail-Antispam: 1UD129KBjvdXoWrCFyfKF1kXryUZF4rXF4DXFb_yoWxXrg_Zw
 1xXrs29348Z3yxtws8WFZ8tryIgw48Gr1j9rs0gFZxCF4jvan8Wrn8uay5Jrs5Ga18WF45
 ZF1ayr98A3W3GjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUIcSsGvfJTRUUUb2xFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
 6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
 A2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Jr0_
 Gr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4j6r
 4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
 I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
 4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY02Avz4vE-syl42xK
 82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGw
 C20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1Y6r17MIIYrxkI7VAKI48J
 MIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMI
 IF0xvE42xK8VAvwI8IcIk0rVW3JVWrJr1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2
 z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjfUozVbDUUUU
X-CM-SenderInfo: qsqrljqqwxllyrt6zt1loo2ulxwovvfxof0/1tbiAQAJBlepTBDjTwAasa
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

Signed-off-by: Hu Weiwen <sehuww@mail.scut.edu.cn>
---
 include/erofs/defs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/erofs/defs.h b/include/erofs/defs.h
index b54cd9d..2e40944 100644
--- a/include/erofs/defs.h
+++ b/include/erofs/defs.h
@@ -87,7 +87,7 @@ typedef int64_t         s64;
 #ifndef __OPTIMIZE__
 #define BUILD_BUG_ON(condition) ((void)sizeof(char[1 - 2 * !!(condition)]))
 #else
-#define BUILD_BUG_ON(condition) assert(condition)
+#define BUILD_BUG_ON(condition) assert(!(condition))
 #endif
 
 #define DIV_ROUND_UP(n, d) (((n) + (d) - 1) / (d))
-- 
2.25.1

