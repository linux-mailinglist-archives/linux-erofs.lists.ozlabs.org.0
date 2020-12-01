Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id EDAC92CA133
	for <lists+linux-erofs@lfdr.de>; Tue,  1 Dec 2020 12:23:31 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ClfqN4VFkzDqcc
	for <lists+linux-erofs@lfdr.de>; Tue,  1 Dec 2020 22:23:28 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::536;
 helo=mail-pg1-x536.google.com; envelope-from=zbestahu@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=CHju6BxW; dkim-atps=neutral
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com
 [IPv6:2607:f8b0:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Clfq81Hl7zDqND
 for <linux-erofs@lists.ozlabs.org>; Tue,  1 Dec 2020 22:23:11 +1100 (AEDT)
Received: by mail-pg1-x536.google.com with SMTP id q3so1026933pgr.3
 for <linux-erofs@lists.ozlabs.org>; Tue, 01 Dec 2020 03:23:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:mime-version
 :content-transfer-encoding;
 bh=lbS0g720OCnGtLtl1ikwjZpztN8o0jDqxfNYGjDV0Ok=;
 b=CHju6BxWjW+QhT7OeZnpVuSVaeAiy3+nQwouB32cBs2AkpxpzzwAYG4O5GIZhbjCHR
 4JsJ0Dzt7xo805jYO7FTnpTuQSzFokrjvf6RQ+NHKBSyU6BUdKTYNzilHLewdh3lzRtw
 VwctNipm16xNWacIe0BxD8YAXFP/TY/LXVaXneqVuDMu+pBTV+1QDDM3h8pgC8zomvVI
 BLj3GgjoofyDZ1uu5diug2ECb2/hx/MPUwWE4Yq1C67X5EXhvyyKy2pnQzDx6MrhYb/k
 nrLQJ4MFwmSh59N0G7GdZ7EYpMIn/VCfhoEmMRJ0o3Tw2JuxffiEFesDh+wSpFmMA6er
 cIpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-transfer-encoding;
 bh=lbS0g720OCnGtLtl1ikwjZpztN8o0jDqxfNYGjDV0Ok=;
 b=Bf8AcsPZtrX2Tkujmgf10d+sRVSHihe/EDEd5Uz6/O9geVe3+8ZfVEd3CvZZgRc9Df
 rjmhKqR+5Sg84g5rHAWgQ8k4lnqlgFWgYFT2716+w47MFNWjST4zTin5fDoCRGugMAot
 EL72IdDyehZjuY1W2T2wNMRTao60q4Vg6TgJPfDebOigCO96xWjTvKGIRsO5QKRyB1h7
 WQ3w1yl+WFk8+StDZi4qZj1MO0nHLSt4ZVkhSCuz079oFtpUpi9RvGqQQZqJ2JNJ35kM
 SnH5t76xM460DM9jfRm90Q76JMT4UzRauL2/4KvvN3g9IPdnyrd8pB0VCd5XwkgYINg6
 Kd9Q==
X-Gm-Message-State: AOAM532ZT4+5/NcsIpMEfx/npyjaZ1NePNHukEcgk29vFvy1D4gA4clu
 dBkAMP6QZkrPM/9qpwDFTbA=
X-Google-Smtp-Source: ABdhPJyks2nPUpT7eXJvp1+TGmHYbl+Yc4pfBQmELb9CBlGvO8p8J+myY/mjB3M6hSHoJkVtCcXD4Q==
X-Received: by 2002:a63:5315:: with SMTP id h21mr1894030pgb.43.1606821788279; 
 Tue, 01 Dec 2020 03:23:08 -0800 (PST)
Received: from localhost ([103.220.76.197])
 by smtp.gmail.com with ESMTPSA id q6sm2267140pfu.23.2020.12.01.03.23.06
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 01 Dec 2020 03:23:08 -0800 (PST)
Date: Tue, 1 Dec 2020 19:23:09 +0800
From: Yue Hu <zbestahu@gmail.com>
To: bluce.lee<bluce.lee@aliyun.com>, hsiangkao<hsiangkao@aol.com>,
 hsiangkao<hsiangkao@redhat.com>
Subject: About Segmentation fault of mkfs.erofs in AOSP
Message-ID: <20201201192309.00007531.zbestahu@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
Cc: huyue2@yulong.com, linux-erofs <linux-erofs@lists.ozlabs.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

hi guys,

I'm trying using erofs for super.img(dynamic partition) under Android 10. But i have met an issue below when building images:

```log
EROFS: write_uncompressed_block() Line[140] Writing 3517 uncompressed data to block 63950
EROFS: erofs_mkfs_build_tree() Line[1011] add file /tmp/merge_target_files_jnIVhM/output/VENDOR/etc/xtwifi.conf (nid 8185600, type 1)
EROFS: erofs_mkfs_build_tree() Line[1011] add file /tmp/merge_target_files_jnIVhM/output/VENDOR/etc (nid 1790208, type 2)
out/host/linux-x86/bin/mkerofsimage.sh: line 79: 188014 Segmentation fault      (core dumped) $MAKE_EROFS_CMD
```

Have you met this kind of issue? I'm trying to debug the problem, looks like memory related.

BTW: i'm using latest erofs-utils in AOSP master branch (https://android.googlesource.com/platform/external/erofs-utils/).

Thx.
