Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 591CA5AC90D
	for <lists+linux-erofs@lfdr.de>; Mon,  5 Sep 2022 05:21:08 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MLYgy6VsNz306r
	for <lists+linux-erofs@lfdr.de>; Mon,  5 Sep 2022 13:21:02 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=oTFlTm37;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::52a; helo=mail-pg1-x52a.google.com; envelope-from=zbestahu@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=oTFlTm37;
	dkim-atps=neutral
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MLYgn2Jqcz2xjl
	for <linux-erofs@lists.ozlabs.org>; Mon,  5 Sep 2022 13:20:51 +1000 (AEST)
Received: by mail-pg1-x52a.google.com with SMTP id x80so7053397pgx.0
        for <linux-erofs@lists.ozlabs.org>; Sun, 04 Sep 2022 20:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=2x1CVvZwxtC17ybrCOH9iYJbvuWGYA3Itll1Ewytvd4=;
        b=oTFlTm37bZl3LpcWRgucfMWbb9z1C0nHrnTqGnsvmCpkS2ETf4Ac3AoW1MnbgBbuwz
         YYKcRZxMxFKDUvynOIP6nwyi4zFA2qjfGK0LkSYioUTkX0wZCYs/PlITA/YMFFTBPx+X
         zs1y+lhGohKdJRfHrG5tbp08aMCO/fcEBTShyzolBooX/bgLDwSNBwBYn8JQQFtlpBz+
         cUJNwIjz3UcU1WRWQyirpt4i8t7IHtjDiVMDnMyRGxDMd7M09wr1v0eYJn6/fbMVejjM
         6oOQvXZHRXhavqIhar2AmGd0BpmpR3U9ZLmm8kD7AXnmoFJSt6dI9ChuC6G56Z7nH40H
         wdig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=2x1CVvZwxtC17ybrCOH9iYJbvuWGYA3Itll1Ewytvd4=;
        b=1CXPbjAgmGN5YXtKg6/LqSL4KJtrTTix6Iitn0l2LYaxk9LiZOGKxQ+lsemqW4wSHa
         WRejQU0fMScS+Jsrh6zs598LzVQVND7B9KUllPPbGmXD2jLgEyyFGGTdSMzXxkcdPRQL
         6iERNAwwP2pmQqZszH/8HqhN5E6qcPAplIiLRT2ag2gPhnwMw4PwarvIP5nlGfV1H3fL
         Rn99ro9kvV9iCyWnlqE/MZ72mWBe+7kLvpxS4PW8m4ZXA66qpGij9I6rIeOkx6BuejBV
         23lx61XXg24cpwkBQly4o8RuiUhUarpTxA7i1jRgcxn7oSsqUYOqSbBW+Q6jAjO8aWpk
         Itdg==
X-Gm-Message-State: ACgBeo0KQzicGrSHeHDMPDkn8QxTJRHQYB2yNYvkw1eRA0rBfLtF1BMQ
	cfND6UCAyW9mbAIm5mEsnfM=
X-Google-Smtp-Source: AA6agR6/5UIS3BCdUojn5irM2bwVVjhd9IDnfVcSg8ZbgrhLuOrCpyZZ8KBXFPTxZG4JzRPjmyYF6g==
X-Received: by 2002:a63:914a:0:b0:42b:4eaf:7c75 with SMTP id l71-20020a63914a000000b0042b4eaf7c75mr40042858pge.306.1662348046857;
        Sun, 04 Sep 2022 20:20:46 -0700 (PDT)
Received: from localhost.localdomain ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id w5-20020a17090ac98500b001f216407204sm5610265pjt.36.2022.09.04.20.20.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Sep 2022 20:20:46 -0700 (PDT)
From: Yue Hu <zbestahu@gmail.com>
To: xiang@kernel.org,
	chao@kernel.org
Subject: [RFC PATCH v3 0/2] erofs: support compressed fragments data
Date: Mon,  5 Sep 2022 11:20:06 +0800
Message-Id: <cover.1662347031.git.huyue2@coolpad.com>
X-Mailer: git-send-email 2.17.1
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
Cc: Yue Hu <huyue2@coolpad.com>, linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org, zhangwen@coolpad.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Yue Hu <huyue2@coolpad.com>

This feature can merge tail of per-file or the whole files into a
special inode to achieve greater compression ratio.

Meanwhile, also add a interlaced uncompressed data layout support for
compressed files since fragments feature (and later) can use it.

mkfs v5: https://lore.kernel.org/all/cover.1661687617.git.huyue2@coolpad.com/

changes from v2:
 - enhance the condition to check if pcluster is interlaced or not;
 - no typo.

changes from v1:
 - fix a compiling error without CONFIG_EROFS_FS_ZIP, reported by kernel test
   robot <lkp@intel.com>;
 - introduce the term 'interlaced' for patch 1/2 suggested by Xiang;
 - fix packed inode failure path when read super pointed out by Xiang;
 - use kmap_local_page instead of kmap_atomic pointed out by Xiang;
 - use a simpler way to avoid call read fragment data twice suggested by Xiang;
 - update commit message change.

Yue Hu (2):
  erofs: support interlaced uncompressed data for compressed files
  erofs: support on-disk compressed fragments data

 fs/erofs/compress.h     |  3 +++
 fs/erofs/decompressor.c | 12 +++++----
 fs/erofs/erofs_fs.h     | 28 ++++++++++++++-----
 fs/erofs/internal.h     | 16 ++++++++---
 fs/erofs/super.c        | 15 +++++++++++
 fs/erofs/sysfs.c        |  2 ++
 fs/erofs/zdata.c        | 60 +++++++++++++++++++++++++++++++++++++++--
 fs/erofs/zdata.h        |  3 +++
 fs/erofs/zmap.c         | 33 ++++++++++++++++++++++-
 9 files changed, 155 insertions(+), 17 deletions(-)

-- 
2.17.1

