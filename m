Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id A742C72C477
	for <lists+linux-erofs@lfdr.de>; Mon, 12 Jun 2023 14:38:05 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4QfrnR32yhz30PC
	for <lists+linux-erofs@lfdr.de>; Mon, 12 Jun 2023 22:38:03 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.110; helo=out30-110.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4QfrnG4FJ6z30BQ
	for <linux-erofs@lists.ozlabs.org>; Mon, 12 Jun 2023 22:37:53 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R501e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VkzKyNE_1686573465;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VkzKyNE_1686573465)
          by smtp.aliyun-inc.com;
          Mon, 12 Jun 2023 20:37:46 +0800
From: Jingbo Xu <jefflexu@linux.alibaba.com>
To: xiang@kernel.org,
	chao@kernel.org,
	huyue2@coolpad.com,
	linux-erofs@lists.ozlabs.org
Subject: [PATCH v7 0/5] erofs: cleanup of xattr handling
Date: Mon, 12 Jun 2023 20:37:40 +0800
Message-Id: <20230612123745.36323-1-jefflexu@linux.alibaba.com>
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

changes since v6:
- patch 1: s/__u32/__le32 in calculation of it->pos (Gao Xiang)
- patch 4: polish the commit message (Gao Xiang)
- patch 5: s/erofs_xattr_handle_string/erofs_xattr_copy_to_buffer (Gao
  Xiang)


changes since v5:
- patch 1: newly added into this series, in preparation for the
  following cleanup
- patch 5: rename erofs_xattr_body() to erofs_xattr_handle_string()

changes since v4:
- patch 1: make conversions from erofs_read_metabuf() in xattr.c
  to "erofs_init_metabuf() + erofs_bread()" a separate patch
- patch 6: add "bool copy" function parameter to erofs_xattr_body(), and
  thus make erofs_xattr_namematch() and erofs_xattr_copy() inlined
  inside erofs_xattr_body()

changes since v3:
- patch 1: make a unified erofs_xattr_iter_fixup() API with newly
  introduced "bool nospan" argument; call erofs_init_metabuf() and
  erofs_bread() separately instead of erofs_read_metabuf()
- patch 2: avoid duplicated strlen() calculation in erofs_getxattr(); no
  need zeroing other fields when initializing 'struct erofs_xattr_iter'
- patch 4: don't explode 'struct erofs_xattr_iter' with inode/getxattr
  fields; instead pass inode/getxattr parameters through function
  parameters of erofs_iter_[inline|shared]_xattr()
- patch 5: don't explode 'struct erofs_xattr_iter' with remaining field;
  instead  calculate and check the remaining inside
  erofs_iter_inline_xattr()

changes since v2:
- rebase to v6.4-rc2
- passes xattr tests (erofs/019,020,021) of erofs-utils [1]

[1] https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs-utils.git/log/?h=experimental-tests

v6: https://lore.kernel.org/all/20230608113020.66626-1-jefflexu@linux.alibaba.com/
v5: https://lore.kernel.org/all/20230601024347.108469-1-jefflexu@linux.alibaba.com/
v4: https://lore.kernel.org/all/20230531031330.3504-1-jefflexu@linux.alibaba.com/
v3: https://lore.kernel.org/lkml/20230518024551.123990-1-jefflexu@linux.alibaba.com/
v2: https://lore.kernel.org/all/20230330082910.125374-1-jefflexu@linux.alibaba.com/
v1: https://lore.kernel.org/all/20230323000949.57608-1-jefflexu@linux.alibaba.com/



Jingbo Xu (5):
  erofs: use absolute position in xattr iterator
  erofs: unify xattr_iter structures
  erofs: make the size of read data stored in buffer_ofs
  erofs: unify inline/shared xattr iterators for listxattr/getxattr
  erofs: use separate xattr parsers for listxattr/getxattr

 fs/erofs/xattr.c | 662 +++++++++++++++++------------------------------
 1 file changed, 235 insertions(+), 427 deletions(-)

-- 
2.19.1.6.gb485710b

