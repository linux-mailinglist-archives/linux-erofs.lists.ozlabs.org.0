Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B5975A35AD
	for <lists+linux-erofs@lfdr.de>; Sat, 27 Aug 2022 09:48:45 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MF82y3m43z3bk0
	for <lists+linux-erofs@lfdr.de>; Sat, 27 Aug 2022 17:48:42 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=QuEdr8ub;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::52a; helo=mail-pg1-x52a.google.com; envelope-from=zbestahu@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=QuEdr8ub;
	dkim-atps=neutral
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MF82q209Nz2xHH
	for <linux-erofs@lists.ozlabs.org>; Sat, 27 Aug 2022 17:48:34 +1000 (AEST)
Received: by mail-pg1-x52a.google.com with SMTP id q9so3349240pgq.6
        for <linux-erofs@lists.ozlabs.org>; Sat, 27 Aug 2022 00:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc;
        bh=/9N+VLWk58L9OYHZ+uiRPBYWV4cbL6pzerCWfj63tGQ=;
        b=QuEdr8ub9t+ajsptYYnDb/m1rez5h/RRO4vJONK+b8vOSw019ccgx0a4WfrRzq7rag
         xXq6hVFgZ4QTIc0ciJ4fCMFH0tv1lyiP4shPV9hWwmEGkKDZgS6/pFTj7k62U/Bh0OCm
         hg5ct20HmOOts3UqMSxtyspbhsylJPTNJ3TloP2Zi9Zafh7V8flaiQzlInMXfRc72g4d
         ieztSsNO8HJFgc0+y701BYLatPaIejsU+2UFM222pfWmJWmRtSUSY5JR/i0bUq6lVPwt
         oFSjHlb+G+nlHfGMd4hTM2VeYEALd0cv1G2drDv++M8VUk+bUxPs2+sdx0AhSKJ/2cLL
         dabA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=/9N+VLWk58L9OYHZ+uiRPBYWV4cbL6pzerCWfj63tGQ=;
        b=DKKDnJ+Jramom8VYuQlyoEDgjBZdrE73AtUdYS3zK6h+rnsIpXTPKdzhTE00vorC/k
         KgmzgirM55+pedM/isDI2kyODQR+Vd/BfY2e3TUiKmXbLhoezRCs5CnS3aXB8MP+gqtA
         xzChjsIXR8KTXXMR7ncO9hrk2G89BRBl018PWRSzlZbj8dhvcnJ6fStm9C83+R+4CoXw
         9YpsANG31s7nk7+2Z3/HG6F76iztNuipZWSLmCzOCyxaSd8SA4Lxs/ZqY0GsOm65t8b2
         SYdreU5AKmkp52LjBE5lXzlTZc+9r9FYGo2DzZpnTGZRM11yfzU7PKGdWU1CvX3mwnky
         PQIg==
X-Gm-Message-State: ACgBeo3ZkPbhwcZuGnwGptrtlRFUq873zIYP9A+Zl+fUYzebnPPdwFn+
	U4Va5l7r7sp6cZ22FuAmtBI=
X-Google-Smtp-Source: AA6agR7XUiAnkAUgsZZykYL44m+7xr6IijcT+mdRGXU02blgfnaOCpncjbvaIOXVfEAJTpCZdy97TA==
X-Received: by 2002:a63:1e12:0:b0:42b:bb36:f898 with SMTP id e18-20020a631e12000000b0042bbb36f898mr37631pge.469.1661586511237;
        Sat, 27 Aug 2022 00:48:31 -0700 (PDT)
Received: from localhost.localdomain ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id q4-20020a656844000000b0042aaaf6e2d9sm2632006pgt.49.2022.08.27.00.48.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Aug 2022 00:48:30 -0700 (PDT)
From: Yue Hu <zbestahu@gmail.com>
To: xiang@kernel.org,
	chao@kernel.org
Subject: [RFC PATCH v2 0/2] erofs: support compressed fragments data
Date: Sat, 27 Aug 2022 15:47:55 +0800
Message-Id: <cover.1661584151.git.huyue2@coolpad.com>
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
Cc: Yue Hu <huyue2@coolpad.com>, linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org, shaojunjun@coolpad.com, zhangwen@coolpad.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Yue Hu <huyue2@coolpad.com>

This feature can merge tail of per-file or the whole files into a
special inode to achieve greater compression ratio.

Meanwhile, also add a interlaced uncompressed data layout support for
compressed files since fragments feature (and later) can use it.

mkfs v4: https://lore.kernel.org/all/cover.1661087840.git.huyue2@coolpad.com/

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
 fs/erofs/zdata.c        | 59 +++++++++++++++++++++++++++++++++++++++--
 fs/erofs/zdata.h        |  3 +++
 fs/erofs/zmap.c         | 35 ++++++++++++++++++++++--
 9 files changed, 155 insertions(+), 18 deletions(-)

-- 
2.17.1

