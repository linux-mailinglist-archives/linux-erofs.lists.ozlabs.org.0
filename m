Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id B75EE6C5B15
	for <lists+linux-erofs@lfdr.de>; Thu, 23 Mar 2023 01:10:02 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Phm1h4nr5z3chp
	for <lists+linux-erofs@lfdr.de>; Thu, 23 Mar 2023 11:10:00 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.118; helo=out30-118.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Phm1c3RRLz3Wtr
	for <linux-erofs@lists.ozlabs.org>; Thu, 23 Mar 2023 11:09:55 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VeRymBJ_1679530189;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VeRymBJ_1679530189)
          by smtp.aliyun-inc.com;
          Thu, 23 Mar 2023 08:09:49 +0800
From: Jingbo Xu <jefflexu@linux.alibaba.com>
To: xiang@kernel.org,
	chao@kernel.org,
	huyue2@coolpad.com,
	linux-erofs@lists.ozlabs.org
Subject: [PATCH 0/8] erofs: cleanup of xattr handling
Date: Thu, 23 Mar 2023 08:09:41 +0800
Message-Id: <20230323000949.57608-1-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
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
Cc: linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

patch 1-4 are trivial cleanups .

patch 5-7 makes inline_getxattr() and inline_listxattr() unified as
iter_inline_xattr(), shared_getxattr() and shared_listxattr() unified as
iter_shared_xattr().

patch 8 converts the callback styled xattr_foreach() to two separate
xattr handling fucntions for listxattr and getxattr, i.e.
erofs_listxattr_foreach() and erofs_getxattr_foreach().

It has passed erofs/019 testcase of erofs-utils.

Jingbo Xu (8):
  erofs: move several xattr helpers into xattr.c
  erofs: rename init_inode_xattrs with erofs_ prefix
  erofs: simplify erofs_xattr_generic_get()
  erofs: introduce erofs_xattr_iter_fixup_aligned() helper
  erofs: unify xattr_iter structures
  erofs: make the size of read data stored in buffer_ofs
  erofs: unify inline/share xattr iterators for listxattr/getxattr
  erofs: use separate xattr parsers for listxattr/getxattr

 fs/erofs/xattr.c | 705 ++++++++++++++++++++---------------------------
 fs/erofs/xattr.h |  56 ----
 2 files changed, 303 insertions(+), 458 deletions(-)

-- 
2.19.1.6.gb485710b

