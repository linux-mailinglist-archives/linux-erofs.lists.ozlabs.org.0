Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D69A5B6C2F
	for <lists+linux-erofs@lfdr.de>; Tue, 13 Sep 2022 13:07:02 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MRgds1Qrqz3bZ2
	for <lists+linux-erofs@lfdr.de>; Tue, 13 Sep 2022 21:06:57 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=qFUrzB8x;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1035; helo=mail-pj1-x1035.google.com; envelope-from=zbestahu@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=qFUrzB8x;
	dkim-atps=neutral
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MRgdf3Whbz2yX3
	for <linux-erofs@lists.ozlabs.org>; Tue, 13 Sep 2022 21:06:44 +1000 (AEST)
Received: by mail-pj1-x1035.google.com with SMTP id o70-20020a17090a0a4c00b00202f898fa86so1547945pjo.2
        for <linux-erofs@lists.ozlabs.org>; Tue, 13 Sep 2022 04:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=dunHHPlB+nYX+OCkYqb8tHR/AQ3hXA5uxH59CPiYJAU=;
        b=qFUrzB8xdRJpCVirtXiFSX3vO3/sweRrBDdl0rAaFt6mX8ocWdyYpcTabCWpEefvym
         OTIysLoRgQOOxkWP2H45QIYOG30XsLFlxMNPjm9FmEYmL/5y3TCTkNaFhyypND00IFI/
         UYEHE+odGfvPDPpxHsQ1JRQU47x7ep8Ire//mlWpfSaPq/WrkhoZXdOHhg68odVRk5vj
         Sa38xGD+A93QZ4a+oMlvoNZStbjApcctumyde0ZxXyRhfY9cVmTbnu6lDNeKtGXw+vXm
         Bajnro7FS6Rp84kNfqd7S/vOOQiXubd4Zwac6bKIS5A8Uj2KYJClZ5LfDPiFAZaITXrb
         wm5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=dunHHPlB+nYX+OCkYqb8tHR/AQ3hXA5uxH59CPiYJAU=;
        b=X/nqxz0OpDIY2twEqBRQLQhoq9zsSC8yzZ8mc8ryh6MguUm8+3XbwH24Z4gCrap/jd
         rwxNIjN+J62Jfp34QzvB6NSr/QC0Qu0dNylzRbm2a5TQpUwYzt/5XDglEBl2FQjEHKur
         HrcgpUe/uQl2Q42tZh9d+oFNrNPm1xTwAJNOSg9mNndUuJgkDc6BRabf8Mr759parhG2
         d1uSEw+MC/PEjPAgRAv/KjreKxBQrmj/03CB7XDsz+o7eNBR8GqgfYX/YSv4PR8J9HRO
         KKHhW2IxDWIHWeVHmcjpFNnNIoiKQkwhYM2VyZ6+AwReT2NVOdj5POwzxXlty3YhsTfh
         fpjA==
X-Gm-Message-State: ACgBeo0cS0CUm/pB0Ynl+N0V8n7/omb/lEtaFcH6usVvZPbJNUmERDun
	VUplMtVUuVbTUVINQCRgTXY=
X-Google-Smtp-Source: AA6agR6hJ7Qs33AEQ6ghHq11kpJTt1cYC9ayG/d8iuEFMQ7rJOYyqNS0Icn7cPHiTuVMAg2COugXGw==
X-Received: by 2002:a17:90b:23d8:b0:202:a51a:2512 with SMTP id md24-20020a17090b23d800b00202a51a2512mr3429735pjb.106.1663067201311;
        Tue, 13 Sep 2022 04:06:41 -0700 (PDT)
Received: from localhost.localdomain ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id cm3-20020a17090afa0300b002000d577cc3sm6888658pjb.55.2022.09.13.04.06.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Sep 2022 04:06:41 -0700 (PDT)
From: Yue Hu <zbestahu@gmail.com>
To: xiang@kernel.org,
	chao@kernel.org
Subject: [RFC PATCH v4 0/2] erofs: support compressed fragments data
Date: Tue, 13 Sep 2022 19:05:50 +0800
Message-Id: <cover.1663065625.git.huyue2@coolpad.com>
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
Cc: linux-kernel@vger.kernel.org, zhangwen@coolpad.com, Yue Hu <huyue2@coolpad.com>, linux-erofs@lists.ozlabs.org, shaojunjun@coolpad.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Yue Hu <huyue2@coolpad.com>

This feature can merge tail of per-file or the whole files into a
special inode to achieve greater compression ratio.

Meanwhile, also add a interlaced uncompressed data layout support for
compressed files since fragments feature (and later) can use it.

mkfs v8: https://lore.kernel.org/all/cover.1663065968.git.huyue2@coolpad.com/

changes from v3:
 - improve the interlaced layout for non 4K uncompressed data as well (Xiang)
 - support 64bit fragment offset for fragment inode and legacy compress (Xiang)

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

 fs/erofs/decompressor.c | 47 ++++++++++++++++++-------------
 fs/erofs/erofs_fs.h     | 31 +++++++++++++++++----
 fs/erofs/internal.h     | 17 +++++++++--
 fs/erofs/super.c        | 15 ++++++++++
 fs/erofs/sysfs.c        |  2 ++
 fs/erofs/zdata.c        | 48 ++++++++++++++++++++++++++++++-
 fs/erofs/zmap.c         | 62 +++++++++++++++++++++++++++++++++++++----
 7 files changed, 187 insertions(+), 35 deletions(-)

-- 
2.17.1

