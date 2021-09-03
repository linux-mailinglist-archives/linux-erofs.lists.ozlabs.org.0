Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8BED4000A9
	for <lists+linux-erofs@lfdr.de>; Fri,  3 Sep 2021 15:41:00 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4H1Jpf4k6Vz2yNv
	for <lists+linux-erofs@lfdr.de>; Fri,  3 Sep 2021 23:40:58 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=oYQSUFFv;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::630;
 helo=mail-pl1-x630.google.com; envelope-from=jnhuang95@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20210112 header.b=oYQSUFFv; dkim-atps=neutral
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com
 [IPv6:2607:f8b0:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4H1JpX1nX3z2xYQ
 for <linux-erofs@lists.ozlabs.org>; Fri,  3 Sep 2021 23:40:51 +1000 (AEST)
Received: by mail-pl1-x630.google.com with SMTP id n4so3320101plh.9
 for <linux-erofs@lists.ozlabs.org>; Fri, 03 Sep 2021 06:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=dbCWzua5ceCAPGS2s/464TCeSQK5geAm/AuLKxl+jNI=;
 b=oYQSUFFvwsaHY4WSYhkAdO3WYYvW1JKPgCnc1m9EX+OLFEAHou5v0n4iNMZGsJdGvb
 7qgJ+XDEajTVmAZmMhC0e5m0xgYR6TCaFnEAlMndUBbfTjrQau4JI5exZGTF5ne95Jr5
 jrnoopbYw8pMPcmNMXroJ3GtOBt1C7HX4GroCmz/GQyoaFKoJdbjqo6+1bDKlOZKN0jx
 84IJia2PfmZjenFJwO9HgKe2P3rHIAXMu5qbJTkpiSJNdNkGC83thy+W+hcYnhGUng12
 USi4LkYVBLrk5V9vsjU7u4O1Aq3cv8L0d7qsAi4m+dEcDLbamacjiIGIVeuTxh/zXf53
 dF7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=dbCWzua5ceCAPGS2s/464TCeSQK5geAm/AuLKxl+jNI=;
 b=cPd4CWEGTmpBR5ZJY4yIEa4ocHrxhuVmMZhwRsBQBNMHTFqYHK4cxi52PGTXq4waqc
 GbH3Sx2H2xaPsrrJa+inRsUGL8LtN+XxqEaAN9nkeqsxJIOq2RCJ1bjVfkmosrh98+PX
 x0vPXf5YfuMFPdvUD9G3MHwwdlR9CPSWJpmUNNa5bCd7m1nAr7vxi7MMvpcL2Uknc7Mn
 O9tIIbRX18S60SrzboT44Kzf7cmg0qJhq55OuXoBgjjKRDIL2liE9ZzNTOxC8CVpBpn3
 dY9IuG0U/sgQPdYLSie7MYN07a1xUYhIb2GW21Bv2pNtVSBCz2UXWgEfusXLVARnk5ho
 dhgg==
X-Gm-Message-State: AOAM532RaQlWsIQQtaoq271I6SI0mCflT7x8c4VdncfGZOGACUJCMnPu
 LY6ydjKAzb/NN/Qk/5Pu4ZoMuZmxERXQFM2t
X-Google-Smtp-Source: ABdhPJyc2pRg+GMPjqol21bMlrSRu5aZMJDc8OGiC68UKFYq9JpE1NrE4meFgT6TdE2pbh476HXhTw==
X-Received: by 2002:a17:90a:f696:: with SMTP id
 cl22mr10081403pjb.216.1630676447731; 
 Fri, 03 Sep 2021 06:40:47 -0700 (PDT)
Received: from hjn-PC.localdomain (li1080-207.members.linode.com.
 [45.33.61.207])
 by smtp.gmail.com with ESMTPSA id o1sm5590948pjk.1.2021.09.03.06.40.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Sep 2021 06:40:47 -0700 (PDT)
From: Huang Jianan <jnhuang95@gmail.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH V2 0/6] erofs-utils: fix checkpatch.pl complains
Date: Fri,  3 Sep 2021 21:40:29 +0800
Message-Id: <20210903134035.12507-1-jnhuang95@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210831165116.16575-1-jnhuang95@gmail.com>
References: <20210831165116.16575-1-jnhuang95@gmail.com>
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
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Huang Jianan <huangjianan@oppo.com>

This patchset fix most of checkpatch.pl complains in erofs-utils, some
problems that also exist in the kernel haven't been fixed.

Changes since v1:
 - remove trailing newline (Gao Xiang);
 - add missing /* fallthrough */ (Gao Xiang);

Huang Jianan (6):
  erofs-utils: clean up file headers & footers
  erofs-utils: fix SPDX comment style
  erofs-utils: fix general style problem
  erofs-utils: remove unnecessary codes
  erofs-utils: fix print style
  erofs-utils: add missing /* fallthrough */

 AUTHORS                    |  1 -
 ChangeLog                  |  1 -
 Makefile.am                |  2 --
 README                     |  1 -
 autogen.sh                 |  1 -
 configure.ac               |  1 -
 fuse/Makefile.am           |  2 --
 fuse/dir.c                 |  3 ---
 fuse/macosx.h              |  1 +
 fuse/main.c                |  8 +-------
 include/erofs/block_list.h |  8 +++-----
 include/erofs/cache.h      |  3 ---
 include/erofs/compress.h   |  3 ---
 include/erofs/config.h     |  3 ---
 include/erofs/decompress.h |  2 --
 include/erofs/defs.h       |  2 --
 include/erofs/err.h        |  3 ---
 include/erofs/exclude.h    |  3 ---
 include/erofs/hashtable.h  |  2 --
 include/erofs/inode.h      |  2 --
 include/erofs/internal.h   |  2 --
 include/erofs/io.h         |  3 ---
 include/erofs/list.h       |  2 --
 include/erofs/print.h      |  4 ----
 include/erofs/trace.h      |  3 ---
 include/erofs/xattr.h      |  4 +---
 include/erofs_fs.h         |  2 --
 lib/Makefile.am            |  2 --
 lib/block_list.c           |  7 +------
 lib/cache.c                |  3 ---
 lib/compress.c             | 12 ++++--------
 lib/compressor.c           |  5 +----
 lib/compressor.h           |  3 ---
 lib/compressor_lz4.c       |  3 ---
 lib/compressor_lz4hc.c     |  3 ---
 lib/config.c               |  3 ---
 lib/data.c                 |  3 ---
 lib/decompress.c           |  2 --
 lib/exclude.c              |  3 ---
 lib/inode.c                | 10 +---------
 lib/io.c                   |  5 +----
 lib/namei.c                |  6 ++----
 lib/super.c                |  3 ---
 lib/xattr.c                |  5 +----
 lib/zmap.c                 |  8 ++++----
 man/Makefile.am            |  1 -
 man/mkfs.erofs.1           |  1 -
 mkfs/Makefile.am           |  2 --
 mkfs/main.c                |  4 +---
 49 files changed, 22 insertions(+), 144 deletions(-)

-- 
2.25.1

