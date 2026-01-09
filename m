Return-Path: <linux-erofs+bounces-1777-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2DF4D07446
	for <lists+linux-erofs@lfdr.de>; Fri, 09 Jan 2026 06:56:31 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dnWHK3wjSz2xJ6;
	Fri, 09 Jan 2026 16:56:29 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.100
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1767938189;
	cv=none; b=NOfyjdLfXZtvg1Rb+DofVE0Iv2E6JbDp1YKPkQBUcTZe/7P1HsFdqnSsB/km+XGqkwY7wMc6WMpWbvQ4aev8YILd+vt9Cj+X1V/SE2CxZmxKfzGdJReNLWFCTIHQg/9loqV6ZFaq/31biLPFAUCVo5r30tSu9roN+XmXL2rcHPq3cfhunXqvANrNxwPmw98NEKppuBn1p/1fqK1iyVtJyYEYMIACLghL85yDcWDgtd1he7l8kZIF+4ywjVlRzFMbogLBLEO9FaM95jCH/ZHEdOtqvHCbmTp/RG6ZppzS6ZKzvlMyu/EK9Pd/OEnYu2hRxeM4r9X6vfhE6YFDNCAFsw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1767938189; c=relaxed/relaxed;
	bh=htMczdh8oSn3FZWxwjQi/ljmic3LiX154yV0o2PuC4w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GVy2q7YifNmOXKIYxAzohwNjy7nFsppAgP9rRUMhCTAqc1HD4Lg1Pnr4k7MG1BLqUGEnyfBMitVYLB/nVb3N1o1B0m5csOuDPYx+FYpr3um7HBeA02cL866Zt24jfgN6tPqrkodmMu6vVzXbekneDi/SFXmdcjVuHX0zg9LklMwJe+MoRYxWDe8Mk/n4hWGaliZKvQR+oVxYA96yBII0+3S5tEm6UzGThEHp0qUC+7qNFlLeefRFH8wEECf8RngGk8CTXWmUxwa6nvZ5bzX9o/NbHChHQxmPTRKGm2ntUkVzNpedCOsAB0rlx/aum2S9eSZxGpGPWyu88iBdZlHhKA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=N2A2KVbn; dkim-atps=neutral; spf=pass (client-ip=115.124.30.100; helo=out30-100.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=N2A2KVbn;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.100; helo=out30-100.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dnWHH0GZWz2xGF
	for <linux-erofs@lists.ozlabs.org>; Fri, 09 Jan 2026 16:56:24 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1767938180; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=htMczdh8oSn3FZWxwjQi/ljmic3LiX154yV0o2PuC4w=;
	b=N2A2KVbnTqWBWAWg8Q8ejCIYpwE3n6K5I3h5VCvx/xNUMGg0cc4KJck1sAeWHYqU1PA9T217OtEkjfOy80vMEib5TTrAPIg0AVowPEe2AmbE88o1/NKuvBAZIK4h0EryXW5dmF1b0vr8beAEL1UBg/ciYDPx3l/Gdqxfd5Ntw8A=
Received: from 30.221.131.232(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wwf6bI-_1767938178 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 09 Jan 2026 13:56:19 +0800
Message-ID: <97a97322-cf80-428b-a59c-d83080d16800@linux.alibaba.com>
Date: Fri, 9 Jan 2026 13:56:18 +0800
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
Subject: Re: [PATCH v13 09/10] erofs: support compressed inodes for page cache
 share
To: Hongbo Li <lihongbo22@huawei.com>
Cc: djwong@kernel.org, amir73il@gmail.com, hch@lst.de,
 linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Chao Yu <chao@kernel.org>,
 Christian Brauner <brauner@kernel.org>
References: <20260109030140.594936-1-lihongbo22@huawei.com>
 <20260109030140.594936-10-lihongbo22@huawei.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20260109030140.594936-10-lihongbo22@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2026/1/9 11:01, Hongbo Li wrote:
> From: Hongzhen Luo <hongzhen@linux.alibaba.com>
> 
> This patch adds page cache sharing functionality for compressed inodes.
> 
> Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang

