Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C7FD5146C0
	for <lists+linux-erofs@lfdr.de>; Fri, 29 Apr 2022 12:26:34 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4KqTDS1d0Nz3bck
	for <lists+linux-erofs@lfdr.de>; Fri, 29 Apr 2022 20:26:32 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=bytedance-com.20210112.gappssmtp.com header.i=@bytedance-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=k34t64cr;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::102c;
 helo=mail-pj1-x102c.google.com; envelope-from=yinxin.x@bytedance.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=bytedance-com.20210112.gappssmtp.com
 header.i=@bytedance-com.20210112.gappssmtp.com header.a=rsa-sha256
 header.s=20210112 header.b=k34t64cr; dkim-atps=neutral
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com
 [IPv6:2607:f8b0:4864:20::102c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4KqTDD1f2xz2ybB
 for <linux-erofs@lists.ozlabs.org>; Fri, 29 Apr 2022 20:26:17 +1000 (AEST)
Received: by mail-pj1-x102c.google.com with SMTP id
 w5-20020a17090aaf8500b001d74c754128so10176011pjq.0
 for <linux-erofs@lists.ozlabs.org>; Fri, 29 Apr 2022 03:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20210112.gappssmtp.com; s=20210112;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=R9vQyV3VXopoorldZBhqjQOAWXe3vDxv13+Q7J/GRjI=;
 b=k34t64cr0M1Pd5rgryr65LjFpeQq9cxLmOP8dt0bLLIiDZpB/xS5ywbHML+rq9KFP8
 qJ5A+kupDtJAPClN2y/KVp/wmfyCXAiD8zycTA1LxjqAnGio7h27B2W7G/3ZJesFTrjM
 EnDPcOoc3gcd8Vqn4zEj8OSqB8ALRpoQSaB5/Ys78FUGef/K5+WjSe3oDpII+HyKYsmX
 GmwRDT5ozDLcDIIstFsM15Ngm6eRMbVIW4bONfEkNlRaRaI8q/KMv3b1A7OAC+Aw2qaK
 1Aix8Y6hUaMSXiQuUiyH2cLQXQlMjf/OdcwNQJvLgA7oVsXVG9SWzrPU2sZPpa9XDWSv
 Jotw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=R9vQyV3VXopoorldZBhqjQOAWXe3vDxv13+Q7J/GRjI=;
 b=2BNTUexhpOo+W87PGY1I/+/Q1f1vh+iGrLRcwvb7HvVusfNWv86aBh31/kd0HtSAxW
 NtW4Uek8Y5XIGKOk3JuRmFBxzl4m3sg5ELL2vRU1DPpE7lJ/bRAzLyb6wcdtCZJiKhat
 f1oJmuIRXNLbAWiUPTIQgx59qaw9wGpVrKUXZP04/3lWHeSFdUdfe6ZeQJJYCVbiZfcI
 wMb1S2pzG5pwmT2Jef6scbwEstJU+oR7IEuMwwiwFSl53u35EeonMl2Xn0o7YVBBejJa
 MtD+AWwcLEIHRLmoARYBrSkoHvBmFXn2psUr2H/x5faoUTnYNmGOhQ/a47JkztnpKwT6
 BeYg==
X-Gm-Message-State: AOAM532c0BVQrH5FrcKa5EBdpJ63j/QI9fO20+17a6ts2jkhG7QywV5l
 p0iRCiF1xQxPbjSTDTnkWhL7/A==
X-Google-Smtp-Source: ABdhPJy6M+E3y/ei0uS1zFcgKhBsp3sk6J3D0I/zhjzkWgMr5WPhz+ZNkg/j9ZjgM0cUVu0Yt3heaw==
X-Received: by 2002:a17:90b:1c01:b0:1d2:add6:805f with SMTP id
 oc1-20020a17090b1c0100b001d2add6805fmr3086211pjb.29.1651227973166; 
 Fri, 29 Apr 2022 03:26:13 -0700 (PDT)
Received: from yinxin.bytedance.net ([139.177.225.228])
 by smtp.gmail.com with ESMTPSA id
 l5-20020a63ea45000000b003c1b2bea056sm1042659pgk.84.2022.04.29.03.26.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Apr 2022 03:26:12 -0700 (PDT)
From: Xin Yin <yinxin.x@bytedance.com>
To: jefflexu@linux.alibaba.com,
	xiang@kernel.org,
	dhowells@redhat.com
Subject: [RFC PATCH 0/1] erofs: change to use asynchronous io for fscache
 readahead
Date: Fri, 29 Apr 2022 07:38:48 +0800
Message-Id: <20220428233849.321495-1-yinxin.x@bytedance.com>
X-Mailer: git-send-email 2.25.1
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
Cc: linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
 linux-erofs@lists.ozlabs.org, Xin Yin <yinxin.x@bytedance.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Jeffle & Xiang

I have tested your fscache,erofs: fscache-based on-demand read semantics 
v9 patches sets https://www.spinics.net/lists/linux-fsdevel/msg216178.html.
For now , it works fine with the nydus image-service. After the image data 
is fully loaded to local storage, it does have great IO performance gain 
compared with nydus V5 which is based on fuse.

For 4K random read , fscache-based erofs can get the same performance with 
the original local filesystem. But I still saw a performance drop in the 4K 
sequential read case. And I found the root cause is in erofs_fscache_readahead() 
we use synchronous IO , which may stall the readahead pipelining.

I have tried to change to use asynchronous io during erofs fscache readahead 
procedure, as what netfs did. Then I saw a great performance gain.

Here are my test steps and results:
- generate nydus v6 format image , in which stored a large file for IO test.
- launch nydus image-service , and  make image data fully loaded to local storage (ext4).
- run fio with below cmd.
fio -ioengine=psync -bs=4k -size=5G -direct=0 -thread -rw=read -filename=./test_image  -name="test" -numjobs=1 -iodepth=16 -runtime=60

v9 patches: 202654 KB/s
v9 patches + async readahead patch: 407213 KB/s
ext4: 439912 KB/s


Xin Yin (1):
  erofs: change to use asynchronous io for fscache readahead

 fs/erofs/fscache.c | 256 ++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 245 insertions(+), 11 deletions(-)

-- 
2.11.0

