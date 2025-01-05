Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43915A019F0
	for <lists+linux-erofs@lfdr.de>; Sun,  5 Jan 2025 16:12:36 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YR15B2xVnz3cB3
	for <lists+linux-erofs@lfdr.de>; Mon,  6 Jan 2025 02:12:30 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.101
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1736089944;
	cv=none; b=AceJ2xj/XXTWcyW9NhMQpqm+tsO5cH5StsX4FzHujaW3EMzvDBkikPFBaa7ZfUHkEzrGboGMzrcLOF+C2pDjnc9sEWWd5R1xdhHaq4LJqaainCdPihnRbscmKIOXgmvHl7zHJtKI0AH2GBYiV3ZVm0DM/iwy4zEf0UB9KGQqKjTr7V62YtKqnH8hRDySzejbYsTJ6T/XQkhd0Ri4Yr88JHs/kkhtSlSDp0tMGSWvj7ClXrjFGtBg4oY9y3klpKpZqbMHZ6jRV2y2xLMJ1HyJEzXJ44b78Xadk/O0Au4jAgroadJ4PyJ1EJzWp1JyjECRkQvxQ3EqMa13b8y+Nw4NNg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1736089944; c=relaxed/relaxed;
	bh=oexO+Et4ZN9vbav324BazUyu2cxUUfD0Ek/1Ckffzrw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=S8ZMkv4T93AV2w/SJycIm0mQ96kJ6S2UxRSM7Z5xSqs3i/T6OL/9u5hjHxBxXnTjY9//ZxbWztTjSkSnH099qyx1IdKssAOuFvaftACkBRsrf3OPd2K2mqcK9ok5is6JksoqKdgEg9KGm5R1AaYDVHbO05EkybbcWxrq74qr2+2Nj16vBmW4Dr4xGzm8f0ilDJIsG7VDPvXdNHWSXOhgEvYdwbzu/etJ8+pbb1tCimd/GORyh6B9JQaIhrRoFDeRbZlapwVKMiPrnvs9BuiwlzXPZ7nWe5q/aHD854W4xI9bK+0CA5ZwdxggnNbFINw8GNQbWRpflbWmKNfmWWSBFQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Zy0oDqJB; dkim-atps=neutral; spf=pass (client-ip=115.124.30.101; helo=out30-101.freemail.mail.aliyun.com; envelope-from=hongzhen@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Zy0oDqJB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.101; helo=out30-101.freemail.mail.aliyun.com; envelope-from=hongzhen@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YR1504VRQz30Tx
	for <linux-erofs@lists.ozlabs.org>; Mon,  6 Jan 2025 02:12:18 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1736089931; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=oexO+Et4ZN9vbav324BazUyu2cxUUfD0Ek/1Ckffzrw=;
	b=Zy0oDqJBsSItYN6tQZicWgENz/Pp/bvsQMDgRYsx6y43jChDrk0LtdKwDK5OrjqOdeyKO9NvHiNVn6cizr43tpshToCUTPgmuYQzIlcKBC9b39pO/F+JLkU9njO4Yw+1z9Hbj1l5SH7F08/f6zugSMNDQdaD5SAB26ej1azEqOk=
Received: from localhost(mailfrom:hongzhen@linux.alibaba.com fp:SMTPD_---0WMyljAQ_1736089929 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sun, 05 Jan 2025 23:12:10 +0800
From: Hongzhen Luo <hongzhen@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [RFC PATCH v5 0/4] erofs: page cache share feature
Date: Sun,  5 Jan 2025 23:12:04 +0800
Message-ID: <20250105151208.3797385-1-hongzhen@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.0
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org
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

Hi everyone,

The patch in this version has made the following changes compared to
the previous versionv(patch v4):

- adjusted the code style;
- introduced erofs_pcshr_{read,readahead}_{begin,end}() to switch
  between anonymous inodes and real inodes;
- cleanup work for erofs_pcshr_fadvise();
- adjusted some variable names, etc.

The experiments were repeated, and the results were almost consistent.

v4: https://lore.kernel.org/all/20240902110620.2202586-1-hongzhen@linux.alibaba.com/
v3: https://lore.kernel.org/all/20240828111959.3677011-1-hongzhen@linux.alibaba.com/
v2: https://lore.kernel.org/all/20240731080704.678259-1-hongzhen@linux.alibaba.com/
v1: https://lore.kernel.org/all/20240722065355.1396365-1-hongzhen@linux.alibaba.com/

Hongzhen Luo (4):
  erofs: move `struct erofs_anon_fs_type` to super.c
  erofs: introduce the page cache share feature
  erofs: apply the page cache share feature
  erofs: introduce .fadvise for page cache share

 fs/erofs/Kconfig           |  10 +
 fs/erofs/Makefile          |   1 +
 fs/erofs/data.c            |  15 +-
 fs/erofs/fscache.c         |  13 --
 fs/erofs/inode.c           |   5 +-
 fs/erofs/internal.h        |   9 +
 fs/erofs/pagecache_share.c | 430 +++++++++++++++++++++++++++++++++++++
 fs/erofs/pagecache_share.h |  39 ++++
 fs/erofs/super.c           |  42 ++++
 fs/erofs/zdata.c           |  10 +-
 10 files changed, 556 insertions(+), 18 deletions(-)
 create mode 100644 fs/erofs/pagecache_share.c
 create mode 100644 fs/erofs/pagecache_share.h

-- 
2.43.5

