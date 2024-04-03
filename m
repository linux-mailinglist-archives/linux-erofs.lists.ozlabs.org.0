Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48CF5897CC5
	for <lists+linux-erofs@lfdr.de>; Thu,  4 Apr 2024 01:57:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1712188665;
	bh=+Um4A5cAG7dBv1Bj9P4DMkFBm9NLvt8tKF7Oyu6sBZQ=;
	h=Date:Subject:To:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:Cc:From;
	b=BSyJhc9b9ZeH3EKILsjVM3Bvzb3Hsf67OHlyC9PYQ2QGA+A02Ihb/Dmorq7juW6HZ
	 X8BXRt++WbvhKGeyR3wcksoeP1Npdky6xupP74qG+tiqimzHSYHrjTAb3Uw5IDlmqk
	 hVuawXpQ4CZQRdOVmwhc/kP7NjA42a0OLjnTNB5dd4Nv+Zaf549dxHd2ekY99uwkZm
	 X6y7SdplIp3LvCD1+mSblrlDlpBtI+HClw3xOXEVP18S7aYZQAsnW12jq+hrpuDPbX
	 c95FLQozeOv1GBxvyJWonXxMLVWkqqInITD9L/EOMAfWvvjAxT2vbkefNldDRmHQGQ
	 fa7/8Nauzvpqw==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4V91s50Y5pz3dRJ
	for <lists+linux-erofs@lfdr.de>; Thu,  4 Apr 2024 10:57:45 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20230601 header.b=FuJI3EN4;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--dhavale.bounces.google.com (client-ip=2607:f8b0:4864:20::114a; helo=mail-yw1-x114a.google.com; envelope-from=37uwnzgckczcwatotexzhhzex.vhfebgnq-xkhyleblml.hsetul.hkz@flex--dhavale.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4V91rz4TCXz2yt0
	for <linux-erofs@lists.ozlabs.org>; Thu,  4 Apr 2024 10:57:38 +1100 (AEDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-61510f72bb3so7784797b3.0
        for <linux-erofs@lists.ozlabs.org>; Wed, 03 Apr 2024 16:57:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712188655; x=1712793455;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+Um4A5cAG7dBv1Bj9P4DMkFBm9NLvt8tKF7Oyu6sBZQ=;
        b=NhYIRCBtRF74UpSIqlzamSu2f82AJzVUohfswWOQjixiyCTFVMn+jPXeOEDfpR4tyV
         YbedQer+wpgvpbs169BQJSwgO09HJGPWTZcfdpS8tkOLBypG2im7oQMDERlqvWHdsfkc
         yuEf6Re5dJnYTthB1rn8Ui5DL363jbu5vLI9Ip4yw2pxkYYiLLJ3rZJp3uNTxhwvfiwZ
         8VduquEXK8GRE2ABamor3TLFaB8dw2MJSqNtDbJbtiAfTW1dnulm8u4Nlx0bCJbcGKNw
         ez+khLH/M0nWwT4VqCbG26s5YHsu+Jpasy2dm9/PmMHPK09PpoW69AU0zKCJl62MFWY9
         N4sw==
X-Gm-Message-State: AOJu0YwyScMKki55vaUd6cPmW/qXN0Ci/bZeVU0EPD1Vq9tOaXbLPhTJ
	xkUz4jaeRBut2MxbZhj+cycPGVBEG9QMhABEc5R49YzI18S+r7i2SOFB5saeIvwyolFKGePofuc
	v9GD3wvTI/xrIRFHScrSWD77JOyJfSavSNgDCBuXCfHKy94DDVEktn/xW2CT+miJ/hO/EdG58D7
	BT4oUmCq3y5byUnyPGo4XwF0xGiWuBCsa0kBzHH1Py/6Yb7g==
X-Google-Smtp-Source: AGHT+IEKbAlMJdvVD23OrfsuWlM28P+g4+iSDamiVG1BJ8iGswXN/PcJNPYidK4o5iAjyuj+rcjGaEkGfcDi
X-Received: from dhavale-desktop.mtv.corp.google.com ([2620:15c:211:201:70db:9f14:826f:fa92])
 (user=dhavale job=sendgmr) by 2002:a05:6902:2b83:b0:dc6:dfc6:4207 with SMTP
 id fj3-20020a0569022b8300b00dc6dfc64207mr228920ybb.10.1712188654911; Wed, 03
 Apr 2024 16:57:34 -0700 (PDT)
Date: Wed,  3 Apr 2024 16:57:23 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240403235724.1919539-1-dhavale@google.com>
Subject: [PATCH 0/1] Opportunistically making files sparse
To: linux-erofs@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
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
From: Sandeep Dhavale via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Sandeep Dhavale <dhavale@google.com>
Cc: hsiangkao@linux.alibaba.com, kernel-team@android.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi,
We noticed that in android if you build erofs images with ELFs which
have higher alignment say 16K or 64K, there was a considerable increase
in the size of the uncompressed erofs image. The size increase could be
mitigated with -Ededupe or --chunksize=4096 but that still results in
lot of redundant disk IOs during file read as all the zero blocks are
mapped to a single block on disk. Treating data blocks filled with zeros
as hole will save the diskspace and also will save us lot of disk IOs
during read.

Using EROFS tracepoints for the image built without the fix

md5sum-7535    [001] ..... 620668.748558: erofs_map_blocks_enter: dev = (7,0), nid = 60, la 364544 llen 45056 flags RAW
md5sum-7535    [001] ..... 620668.748559: erofs_map_blocks_exit: dev = (7,0), nid = 60, flags RAW la 364544 pa 40960 llen 4096 plen 4096 mflags M ret 0
md5sum-7535    [001] ..... 620668.748560: erofs_map_blocks_enter: dev = (7,0), nid = 60, la 368640 llen 40960 flags RAW
md5sum-7535    [001] ..... 620668.748560: erofs_map_blocks_exit: dev = (7,0), nid = 60, flags RAW la 368640 pa 40960 llen 4096 plen 4096 mflags M ret 0
md5sum-7535    [001] ..... 620668.748561: erofs_map_blocks_enter: dev = (7,0), nid = 60, la 372736 llen 36864 flags RAW
md5sum-7535    [001] ..... 620668.748561: erofs_map_blocks_exit: dev = (7,0), nid = 60, flags RAW la 372736 pa 40960 llen 4096 plen 4096 mflags M ret 0
md5sum-7535    [001] ..... 620668.748562: erofs_map_blocks_enter: dev = (7,0), nid = 60, la 376832 llen 32768 flags RAW

As you can see, all the reads are being redirected to read the same pa 40960.
Also this causes fragmentation.

Using EROFS tracepoints for the image built with detection of zero blocks

md5sum-7496    [000] ..... 620150.387246: erofs_map_blocks_enter: dev = (7,0), nid = 60, la 0 llen 65536 flags RAW
md5sum-7496    [000] ..... 620150.387249: erofs_map_blocks_exit: dev = (7,0), nid = 60, flags RAW la 0 pa 0 llen 262144 plen 262144 mflags  ret 0
md5sum-7496    [000] ..... 620150.387358: erofs_map_blocks_enter: dev = (7,0), nid = 60, la 65536 llen 131072 flags RAW
md5sum-7496    [000] ..... 620150.387358: erofs_map_blocks_exit: dev = (7,0), nid = 60, flags RAW la 0 pa 0 llen 262144 plen 262144 mflags  ret 0
md5sum-7496    [000] ..... 620150.387460: erofs_map_blocks_enter: dev = (7,0), nid = 60, la 196608 llen 212992 flags RAW

I think this optimization has wins on diskspace and IO cost so its better to be
default than enable conditionally with --sparse flag.

Thanks,
Sandeep.

PS: This patch is based on erofs-utils.git/experimental as it builds on the
previous fix of minextblks at
https://lore.kernel.org/all/20240403070700.1716252-1-dhavale@google.com/
which is not in erofs-utils.git/dev yet.


Sandeep Dhavale (1):
  erofs-utils: lib: treat data blocks filled with 0s as a hole

 lib/blobchunk.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

-- 
2.44.0.478.gd926399ef9-goog

