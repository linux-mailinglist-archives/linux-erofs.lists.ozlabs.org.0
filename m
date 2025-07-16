Return-Path: <linux-erofs+bounces-639-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 20FB1B07C1C
	for <lists+linux-erofs@lfdr.de>; Wed, 16 Jul 2025 19:33:36 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bj37D4nbcz30Vn;
	Thu, 17 Jul 2025 03:33:28 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1752687208;
	cv=none; b=DHoZjh0uQ50VcYCw5DGekRSrOibkJV6hqVYVLmOXaDvr1QRdV9TFjoSbSX5BockiB2a4Wv9MRA5fzEZ0YhnCIWgcsycfb6jL+wFLkf3Xx3vRtNfeFXMzYo4E2+U9tJpkxJheAaGcAD81shY23lzUmqIe+f/Fhd8FnkJpf2bXSm4Mxs65n/xxTi67KWb7TP4EPsFHcd3apg/cLOvhLkSFkSxPLJWO0jW1SnlDM+Bp4nGuu47sCZ8mXNTTDBxxqrJLtWsL8jgUHUpfs3qDw2I08eL8Ruj60YOMYtjk/HIManzgwVfB3hEun+Bjcc+grRSFcPU+l0Gb6FsK1Gct3/kuaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1752687208; c=relaxed/relaxed;
	bh=zDJCiGHS3GPm13IZWsw1313r2MueLUxvlBMMubXIbYw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WMPRMFmp/pmiFw3TrwLTchQKTj7WfR9q9scet1PMHjA99BZmZ6qPSujIdw06n6+Vv196vcbreNmHo2AEsA2Yirp0h6BMBhSF0ibNpMqarkn+Dm3A3KLsN/F5iL5jHbGztsvMAH8IURWh7Q8HMv1s4u6g9fPBwyyLwhO7sank/Qqm9YWKN6jPPSr+MRFomTQFsSzOPnUlVRP2KGW4E7xFjORen5vf2lTqKPPopEeugpjd+3c5f6nKhPwtA4pwkvbJs9UYlp3bWkI8AqNQsXKrvKraaj1mJ7ifpBhzHv1tyNIT3k94ysEwHkm4ga9JlrvSMk/uqUkOnhTcXX/Xnrgegw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=EnB2R+Su; dkim-atps=neutral; spf=pass (client-ip=115.124.30.131; helo=out30-131.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=EnB2R+Su;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.131; helo=out30-131.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bj37C0M4rz3069
	for <linux-erofs@lists.ozlabs.org>; Thu, 17 Jul 2025 03:33:25 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1752687201; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=zDJCiGHS3GPm13IZWsw1313r2MueLUxvlBMMubXIbYw=;
	b=EnB2R+Suk30bkTwztGuJu/+Y2z+W+EA3s/Rx12XpCh9RyDxCEttFzmUbkoAkHchjF2p09MvQ1g6vWPsv2Fi/1ilr6DRgh1svJKkcy+TWo+kH/st+PYY4+bdqj+y5+rRFdrTaCLNyICw1/wt2Pt5Kcc2h0I5xjk8GPHkdra6eGJU=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wj5Vb3w_1752687195 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 17 Jul 2025 01:33:19 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH v3 0/2] erofs: support metadata compression
Date: Thu, 17 Jul 2025 01:33:12 +0800
Message-ID: <20250716173314.308744-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Hi,

This patchset implements metadata compression since many users are
interested in smaller image sizes (even at the cost of some I/O
latency).

In short, it uses a special "metabox" inode to gather all inode
metadata and then compresses it.  Since EROFS supports multiple
algorithms, you can select a faster algorithm (e.g., LZ4) from
the one used for data compression (e.g., LZMA).

Also see the detailed commit messages for more details.

Here are some preliminary numbers:

Command line: -zlzma,6 -Efragments,ztailpacking -C1048576

  ______________________________________________________________
 |         |_______ Vanilla _______|___ 2554769408 (2437MiB) ___|
 | Fedora  |_______ `-m4096` ______|___ 2524504064 (2408MiB) ___|
 |_________|_ `-m4096` (lz4hc,12) _|___ 2527326208 (2411MiB) ___|
 |         |_______ Vanilla _______|___  378634240 ( 362MiB) ___|
 |  AOSP   |_______ `-m4096` ______|___  377856000 ( 361MiB) ___|
 |_________|_ `-m4096` (lz4hc,12) _|___  377942016 ( 361MiB) ___|

Thanks,
Gao Xiang

v2: https://lore.kernel.org/r/20250711094004.2488-1-liubo03@inspur.com
Changes since v2:
 - refine the ondisk format and implementation.

Bo Liu (1):
  erofs: implement metadata compression

Gao Xiang (1):
  erofs: add on-disk definition for metadata compression

 fs/erofs/data.c         | 59 +++++++++++++++++++++++++----------------
 fs/erofs/decompressor.c |  2 +-
 fs/erofs/erofs_fs.h     | 15 ++++++++---
 fs/erofs/fileio.c       |  2 +-
 fs/erofs/inode.c        |  5 ++--
 fs/erofs/internal.h     | 19 ++++++++++---
 fs/erofs/super.c        | 22 +++++++++++++--
 fs/erofs/xattr.c        | 20 +++++++++-----
 fs/erofs/zdata.c        |  5 +++-
 fs/erofs/zmap.c         | 16 ++++++-----
 10 files changed, 115 insertions(+), 50 deletions(-)

-- 
2.43.5


