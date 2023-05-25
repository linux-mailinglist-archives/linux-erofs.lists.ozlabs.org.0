Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DBEB710768
	for <lists+linux-erofs@lfdr.de>; Thu, 25 May 2023 10:32:21 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4QRhBC0X4Hz3f8j
	for <lists+linux-erofs@lfdr.de>; Thu, 25 May 2023 18:32:19 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.130; helo=out30-130.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4QRhB14xqtz3bqw
	for <linux-erofs@lists.ozlabs.org>; Thu, 25 May 2023 18:32:08 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VjRZXN9_1685003521;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VjRZXN9_1685003521)
          by smtp.aliyun-inc.com;
          Thu, 25 May 2023 16:32:02 +0800
From: Jingbo Xu <jefflexu@linux.alibaba.com>
To: xiang@kernel.org,
	chao@kernel.org,
	huyue2@coolpad.com,
	linux-erofs@lists.ozlabs.org
Subject: [PATCH 0/5] erofs-utils: tests: restructure test cases for xattr
Date: Thu, 25 May 2023 16:31:56 +0800
Message-Id: <20230525083201.23740-1-jefflexu@linux.alibaba.com>
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

This series restructures some existing test cases for xattr.

- patch 1/2: some generic helpers are extracted from erofs/019 [1]
- patch 3/4: the previous posted test case [2] checking xattrs in
  different layouts are split into two test cases, i.e. erofs/020 and
  erofs/021.
    - erofs/020 checks xattrs in different layouts and is independent on
      the "-b#" feature of mkfs.erofs
    - erofs/021 checks xattrs crossing block boundary.  It is dependent
      on the "-b#" feature of mkfs.erofs and will "notrun" if mkfs.erofs
      doesn't support this feature yet
- patch 5: it's the previous posted test case [3] checking long xattr
  name prefixes, except that it will "notrun" if mkfs.erofs doesn't
  support "--xattr-prefix" feature yet

[1] https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs-utils.git/tree/tests/erofs/019?h=experimental-tests
[2] https://lore.kernel.org/all/20230327123926.92934-1-jefflexu@linux.alibaba.com/
[3] https://lore.kernel.org/all/20230411103004.104064-1-jefflexu@linux.alibaba.com/

Huang Jianan (1):
  erofs-utils: tests: add test for xattrs

Jingbo Xu (4):
  erofs-utils: tests: add generic helper for xattrs
  erofs-utils: tests: add test for xattrs in different layouts
  erofs-utils: tests: add test for xattr crossing block boundary
  erofs-utils: tests: add test for long xattr name prefixes

 tests/Makefile.am   | 12 +++++++++
 tests/common/rc     | 44 ++++++++++++++++++++++++++++++
 tests/erofs/019     | 55 ++++++++++++++++++++++++++++++++++++++
 tests/erofs/019.out |  2 ++
 tests/erofs/020     | 77 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/erofs/020.out |  2 ++
 tests/erofs/021     | 60 +++++++++++++++++++++++++++++++++++++++++
 tests/erofs/021.out |  2 ++
 tests/erofs/022     | 77 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/erofs/022.out |  2 ++
 10 files changed, 333 insertions(+)
 create mode 100755 tests/erofs/019
 create mode 100644 tests/erofs/019.out
 create mode 100755 tests/erofs/020
 create mode 100644 tests/erofs/020.out
 create mode 100755 tests/erofs/021
 create mode 100644 tests/erofs/021.out
 create mode 100755 tests/erofs/022
 create mode 100644 tests/erofs/022.out

-- 
1.8.3.1

