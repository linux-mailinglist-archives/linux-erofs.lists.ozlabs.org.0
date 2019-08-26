Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id C5BB19D189
	for <lists+linux-erofs@lfdr.de>; Mon, 26 Aug 2019 16:21:54 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46HDhv4lFDzDqg4
	for <lists+linux-erofs@lfdr.de>; Tue, 27 Aug 2019 00:21:51 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=huawei.com
 (client-ip=45.249.212.35; helo=huawei.com; envelope-from=gaoxiang25@huawei.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=huawei.com
Received: from huawei.com (szxga07-in.huawei.com [45.249.212.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46HCVg6tSCzDqPn
 for <linux-erofs@lists.ozlabs.org>; Mon, 26 Aug 2019 23:27:55 +1000 (AEST)
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id D51777CE6EC814E9F398;
 Mon, 26 Aug 2019 21:27:52 +0800 (CST)
Received: from architecture4.huawei.com (10.140.130.215) by smtp.huawei.com
 (10.3.19.205) with Microsoft SMTP Server (TLS) id 14.3.439.0; Mon, 26 Aug
 2019 21:27:42 +0800
From: Gao Xiang <gaoxiang25@huawei.com>
To: Chao Yu <yuchao0@huawei.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, <devel@driverdev.osuosl.org>
Subject: [PATCH RESEND] erofs: fix compile warnings when moving out
 include/trace/events/erofs.h
Date: Mon, 26 Aug 2019 21:26:53 +0800
Message-ID: <20190826132653.100731-1-gaoxiang25@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190826132234.96939-1-gaoxiang25@huawei.com>
References: <20190826132234.96939-1-gaoxiang25@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.140.130.215]
X-CFilter-Loop: Reflected
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
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-erofs@lists.ozlabs.org,
 LKML <linux-kernel@vger.kernel.org>, weidu.du@huawei.com,
 Miao Xie <miaoxie@huawei.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

As Stephon reported [1], many compile warnings are raised when
moving out include/trace/events/erofs.h:

In file included from include/trace/events/erofs.h:8,
                 from <command-line>:
include/trace/events/erofs.h:28:37: warning: 'struct dentry' declared inside parameter list will not be visible outside of this definition or declaration
  TP_PROTO(struct inode *dir, struct dentry *dentry, unsigned int flags),
                                     ^~~~~~
include/linux/tracepoint.h:233:34: note: in definition of macro '__DECLARE_TRACE'
  static inline void trace_##name(proto)    \
                                  ^~~~~
include/linux/tracepoint.h:396:24: note: in expansion of macro 'PARAMS'
  __DECLARE_TRACE(name, PARAMS(proto), PARAMS(args),  \
                        ^~~~~~
include/linux/tracepoint.h:532:2: note: in expansion of macro 'DECLARE_TRACE'
  DECLARE_TRACE(name, PARAMS(proto), PARAMS(args))
  ^~~~~~~~~~~~~
include/linux/tracepoint.h:532:22: note: in expansion of macro 'PARAMS'
  DECLARE_TRACE(name, PARAMS(proto), PARAMS(args))
                      ^~~~~~
include/trace/events/erofs.h:26:1: note: in expansion of macro 'TRACE_EVENT'
 TRACE_EVENT(erofs_lookup,
 ^~~~~~~~~~~
include/trace/events/erofs.h:28:2: note: in expansion of macro 'TP_PROTO'
  TP_PROTO(struct inode *dir, struct dentry *dentry, unsigned int flags),
  ^~~~~~~~

That makes me very confused since most original EROFS tracepoint code
was taken from f2fs, and finally I found

commit 43c78d88036e ("kbuild: compile-test kernel headers to ensure they are self-contained")

It seems these warnings are generated from KERNEL_HEADER_TEST feature and
ext4/f2fs tracepoint files were in blacklist.

Anyway, let's fix these issues for KERNEL_HEADER_TEST feature instead
of adding to blacklist...

[1] https://lore.kernel.org/lkml/20190826162432.11100665@canb.auug.org.au/
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---

[RESEND] Cc Stephen as well. no change at all...

Hi Chao and Greg,
 It seems the root cause reported by Stephen is the following (sorry for
 taking some time...) could you kindly review and merge this patch?

Thanks,
Gao Xiang

 include/trace/events/erofs.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/trace/events/erofs.h b/include/trace/events/erofs.h
index bfb2da9c4eee..d239f39cbc8c 100644
--- a/include/trace/events/erofs.h
+++ b/include/trace/events/erofs.h
@@ -6,6 +6,9 @@
 #define _TRACE_EROFS_H
 
 #include <linux/tracepoint.h>
+#include <linux/fs.h>
+
+struct erofs_map_blocks;
 
 #define show_dev(dev)		MAJOR(dev), MINOR(dev)
 #define show_dev_nid(entry)	show_dev(entry->dev), entry->nid
-- 
2.17.1

