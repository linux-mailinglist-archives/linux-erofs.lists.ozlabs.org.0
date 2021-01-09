Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BD1E2EFEAC
	for <lists+linux-erofs@lfdr.de>; Sat,  9 Jan 2021 09:48:52 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DCYXx1T25zDr2y
	for <lists+linux-erofs@lfdr.de>; Sat,  9 Jan 2021 19:48:49 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=fail (SPF fail - not authorized)
 smtp.mailfrom=mail.scut.edu.cn (client-ip=47.90.104.110;
 helo=aliyun-sdnproxy-3.icoremail.net; envelope-from=sehuww@mail.scut.edu.cn;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none)
 header.from=mail.scut.edu.cn
X-Greylist: delayed 727 seconds by postgrey-1.36 at bilbo;
 Sat, 09 Jan 2021 19:48:30 AEDT
Received: from aliyun-sdnproxy-3.icoremail.net (aliyun-cloud.icoremail.net
 [47.90.104.110])
 by lists.ozlabs.org (Postfix) with SMTP id 4DCYXZ5J7ZzDr0f
 for <linux-erofs@lists.ozlabs.org>; Sat,  9 Jan 2021 19:48:23 +1100 (AEDT)
Received: from DESKTOP-N4CECTO.scut-smil.cn (unknown [125.216.246.30])
 by front (Coremail) with SMTP id AWSowAAnLeEbaflfXVeLAQ--.39566S4;
 Sat, 09 Jan 2021 16:28:12 +0800 (CST)
From: Hu Weiwen <sehuww@mail.scut.edu.cn>
To: Gao Xiang <hsiangkao@redhat.com>, Li Guifu <bluce.liguifu@huawei.com>,
 Miao Xie <miaoxie@huawei.com>, Fang Wei <fangwei1@huawei.com>
Subject: [PATCH v2 0/2] Optimize mkfs to O(N), N = #files
Date: Sat,  9 Jan 2021 16:28:08 +0800
Message-Id: <20210109082810.32169-1-sehuww@mail.scut.edu.cn>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210108181545.GA613131@xiangao.remote.csb>
References: <20210108181545.GA613131@xiangao.remote.csb>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AWSowAAnLeEbaflfXVeLAQ--.39566S4
X-Coremail-Antispam: 1UD129KBjvdXoWrurW5Ww1rXr4fKr48Jw1rCrg_yoWxtFX_Aw
 1xArZ7Zw45XF1SvFWfGwsxXFy3Zr45Cr15KF4kJrW5Cry3ZF45WrW8Aw1qgr15ZF4UKr15
 Jr4DtryxZry2gjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUIcSsGvfJTRUUUb48FF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
 6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
 A2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
 Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxVWxJr
 0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
 2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
 W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc2xSY4AK67AK6r43
 MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr
 0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0E
 wIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJV
 W8JwCI42IY6xAIw20EY4v20xvaj40_Wr1j6rW3Jr1lIxAIcVC2z280aVAFwI0_Jr0_Gr1l
 IxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUjNJ55UUUU
 U==
X-CM-SenderInfo: qsqrljqqwxllyrt6zt1loo2ulxwovvfxof0/1tbiAQAIBlepTBC2twAKsm
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
Cc: Hu Weiwen <sehuww@mail.scut.edu.cn>, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Xiang,

Thanks for your review.

Integrating the list_head to struct erofs_buffer_block seems better. And I removed the extra braces.

My previous patches were sent by "git send-email", but unfortunately, Outlook changed my Message-ID, so they did not appear in one thread. Sorry for that, I will try another email provider this time.

Hu Weiwen (2):
  erofs-utils: optimize mkfs to O(N), N = #files
  erofs-utils: refactor: remove end argument from erofs_mapbh

 include/erofs/cache.h |  3 +-
 lib/cache.c           | 90 ++++++++++++++++++++++++++++++++++++-------
 lib/compress.c        |  2 +-
 lib/inode.c           | 10 ++---
 lib/xattr.c           |  2 +-
 mkfs/main.c           |  2 +-
 6 files changed, 86 insertions(+), 23 deletions(-)

--
2.17.1

