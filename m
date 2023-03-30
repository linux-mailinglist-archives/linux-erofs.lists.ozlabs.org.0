Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA8016CFE3D
	for <lists+linux-erofs@lfdr.de>; Thu, 30 Mar 2023 10:29:32 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PnGmp4sx8z3fRR
	for <lists+linux-erofs@lfdr.de>; Thu, 30 Mar 2023 19:29:30 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.119; helo=out30-119.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PnGmY5jh1z3c8T
	for <linux-erofs@lists.ozlabs.org>; Thu, 30 Mar 2023 19:29:16 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VezvKlX_1680164950;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VezvKlX_1680164950)
          by smtp.aliyun-inc.com;
          Thu, 30 Mar 2023 16:29:11 +0800
From: Jingbo Xu <jefflexu@linux.alibaba.com>
To: xiang@kernel.org,
	chao@kernel.org,
	huyue2@coolpad.com,
	linux-erofs@lists.ozlabs.org
Subject: [PATCH v2 0/8] erofs: cleanup of xattr handling
Date: Thu, 30 Mar 2023 16:29:02 +0800
Message-Id: <20230330082910.125374-1-jefflexu@linux.alibaba.com>
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

changes since v1:
- patch 1: keep erofs_xattr_handler() and erofs_getxattr() untouched in
  xattr.h (Gao Xiang)
- patch 2/3: add Reviewed-by tags (Gao Xiang)
- this refactoring can be tested by [1]

[1] https://lore.kernel.org/all/20230327123926.92934-1-jefflexu@linux.alibaba.com/

v1: https://lore.kernel.org/all/20230323000949.57608-1-jefflexu@linux.alibaba.com/

Jingbo Xu (8):
  erofs: move several xattr helpers into xattr.c
  erofs: rename init_inode_xattrs with erofs_ prefix
  erofs: simplify erofs_xattr_generic_get()
  erofs: introduce erofs_xattr_iter_fixup_aligned() helper
  erofs: unify xattr_iter structures
  erofs: make the size of read data stored in buffer_ofs
  erofs: unify inline/share xattr iterators for listxattr/getxattr
  erofs: use separate xattr parsers for listxattr/getxattr

 fs/erofs/xattr.c | 683 +++++++++++++++++++----------------------------
 fs/erofs/xattr.h |  23 --
 2 files changed, 281 insertions(+), 425 deletions(-)

-- 
2.19.1.6.gb485710b

