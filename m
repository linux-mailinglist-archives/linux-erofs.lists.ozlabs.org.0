Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B8DB87C8FF
	for <lists+linux-erofs@lfdr.de>; Fri, 15 Mar 2024 08:24:19 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=ILZObAq+;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4TwwjY1qydz3dW7
	for <lists+linux-erofs@lfdr.de>; Fri, 15 Mar 2024 18:24:17 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=ILZObAq+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.99; helo=out30-99.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4TwwjR2QNGz3brC
	for <linux-erofs@lists.ozlabs.org>; Fri, 15 Mar 2024 18:24:10 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1710487445; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=xM0e16aVLhJtCZ876utV5at64aW2K3janDrkaaiRXaQ=;
	b=ILZObAq+gqAoOch/2f6B/uJzLL4MoaHya7ZMuF1rPkqfxaVEK85pxXDuymUVhK6Cw1+URLVHwwxtwTLnoOWR6RgCvgPl4/nsEwseCPBQUGit4SADdcV8vMPPgQXtUXiZVTDQY9wBg2IsH9Fn7B4MD1e1l81RoLfd4YcV4a8l5Xk=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0W2VYuqk_1710487442;
Received: from 30.221.132.166(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W2VYuqk_1710487442)
          by smtp.aliyun-inc.com;
          Fri, 15 Mar 2024 15:24:04 +0800
Message-ID: <f379e32e-3129-47d3-944e-99214c3afc79@linux.alibaba.com>
Date: Fri, 15 Mar 2024 15:24:01 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 5/5] erofs-utils: mkfs: introduce inner-file
 multi-threaded compression
To: Noboru Asai <asai@sijam.com>
References: <20240315011019.610442-1-hsiangkao@linux.alibaba.com>
 <20240315011019.610442-5-hsiangkao@linux.alibaba.com>
 <CAFoAo-JakJCcf9aW-Wdk+OHS092PRzpeTusAz817N7FUT0ExFQ@mail.gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <CAFoAo-JakJCcf9aW-Wdk+OHS092PRzpeTusAz817N7FUT0ExFQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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
Cc: Yifan Zhao <zhaoyifan@sjtu.edu.cn>, linux-erofs@lists.ozlabs.org, Tong Xin <xin_tong@sjtu.edu.cn>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2024/3/15 15:18, Noboru Asai wrote:
> I think it is easier to understand the source code if the names of
> variables and pointers in the same structure are unified.
> 
> struct z_erofs_compress_ictx inode_ctx; // i stands for inode?
> struct z_erofs_compress_ictx *ictx;
> 
> struct z_erofs_compress_sctx seg_ctx;
> struct z_erofs_compress_sctx *sctx;

"ictx" means "inode context", "sctx" means "segment context".
If there is no confusion, "ctx" naming can be used in a function.

Also I tend to avoid making a huge diff to make ctx->"sctx or
ictx", otherwise "git blame" will be in a mess.

Thanks,
Gao Xiang

