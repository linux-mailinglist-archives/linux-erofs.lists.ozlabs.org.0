Return-Path: <linux-erofs+bounces-323-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B2FDAB7B29
	for <lists+linux-erofs@lfdr.de>; Thu, 15 May 2025 03:50:22 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZyY7c1MG9z2yDk;
	Thu, 15 May 2025 11:50:20 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.130
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1747273820;
	cv=none; b=bEoH6UYJDgfF0s9+KKLicJXTyF6YSRuHhn4gE69q0zbYndd2f7ZoLNwk8dLJzJnBZHce8DIRyQH6TYvH5vi6FakYoWH/v9dW3qtk17wIqLWAjhv0SepvWDk03W7qMPsllrxC5t9RNHkB8x/M7dN5K94FONJ6Qi7RO/4LdhRcLZu5uHRQpf9Wp/n6W5K6zaj1PTMBlL8FoPiDra07TcINOWlE3+IW5xtn2/TnXRxmKB9uDijX9HY2hAtO/hmdmjQ75kGDsWpmnllFYgrfquI/gkbrdhsAMKUNzAKljY5PbTRX0RKMwOZmJ1rGUMsF+x1ZY+PypS52VXx4wC/DGDECdg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1747273820; c=relaxed/relaxed;
	bh=DcsB84nX40o0xieU4YWyEEfypRZWXyBBrf1GVCswHG4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=faaNol/k/rJiOJJsQrQvBLSW7qv5KfzfzbXg5LcJ7D1AiWJbDenl5d8hxSLc25cPGPVlnXR3NdIada2XVZA60CfahbSYeGikwF5qRxrjnnvU/A2QCjDrnd/AeFa2o2iEeTcCuBS1gZOQ3QllGMl9OaQnAI9TU1Ww0Yucte2kGrQMLDo18UubfPoQSr2LfAWCQEpmEo5VW/LK/avk68LNQWVTpxOLf03V3p5wLO36S7ygGSvXHn0ntBCpMwudYYC5ESaSH/H9b5wLB8OYFzOt2ENW71oZvvW0i9/o0qzO67MIbAXwnh+gLOauCsaqvNe0NOvM07dSbsV64muh5dvZAQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=WwfKbMzE; dkim-atps=neutral; spf=pass (client-ip=115.124.30.130; helo=out30-130.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=WwfKbMzE;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.130; helo=out30-130.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZyY7Z00Lkz2y8p
	for <linux-erofs@lists.ozlabs.org>; Thu, 15 May 2025 11:50:16 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1747273805; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=DcsB84nX40o0xieU4YWyEEfypRZWXyBBrf1GVCswHG4=;
	b=WwfKbMzEJm+uAmrs5MGwd+E634a5j7uSBmq1rkvGaXuch98U0+wjCbsDVQIXh6NWTzzhJ+EC18fiUgsEavYJuj5Gj7eewsj2UqT0uW6fLnVn208VFX3VbputTHoaX04SEIm0gtzS7JlOk0xZ2T0HN8x+H2FXVCwb/vwTy0ErEho=
Received: from 30.221.131.36(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WaoYTwg_1747273802 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 15 May 2025 09:50:03 +0800
Message-ID: <d6dbcc0a-71d8-472a-aa62-89d7ba586cbc@linux.alibaba.com>
Date: Thu, 15 May 2025 09:50:02 +0800
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
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] erofs: avoid using multiple devices with different
 type
To: Sheng Yong <shengyong2021@gmail.com>, xiang@kernel.org, chao@kernel.org,
 zbestahu@gmail.com, jefflexu@linux.alibaba.com, dhavale@google.com,
 lihongbo22@huawei.com
Cc: linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Sheng Yong <shengyong1@xiaomi.com>
References: <20250515014837.3315886-1-shengyong1@xiaomi.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20250515014837.3315886-1-shengyong1@xiaomi.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2025/5/15 09:48, Sheng Yong wrote:
> From: Sheng Yong <shengyong1@xiaomi.com>
> 
> For multiple devices, both primary and extra devices should be the
> same type. `erofs_init_device` has already guaranteed that if the
> primary is a file-backed device, extra devices should also be
> regular files.
> 
> However, if the primary is a block device while the extra device
> is a file-backed device, `erofs_init_device` will get an ENOTBLK,
> which is not treated as an error in `erofs_fc_get_tree`, and that
> leads to an UAF:
> 
>    erofs_fc_get_tree
>      get_tree_bdev_flags(erofs_fc_fill_super)
>        erofs_read_superblock
>          erofs_init_device  // sbi->dif0 is not inited yet,
>                             // return -ENOTBLK
>        deactivate_locked_super
>          free(sbi)
>      if (err is -ENOTBLK)
>        sbi->dif0.file = filp_open()  // sbi UAF
> 
> So if -ENOTBLK is hitted in `erofs_init_device`, it means the
> primary device must be a block device, and the extra device
> is not a block device. The error can be converted to -EINVAL.
> 
> Fixes: fb176750266a ("erofs: add file-backed mount support")
> Signed-off-by: Sheng Yong <shengyong1@xiaomi.com>

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang

