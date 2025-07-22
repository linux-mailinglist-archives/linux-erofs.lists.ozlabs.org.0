Return-Path: <linux-erofs+bounces-695-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id A802DB0CED1
	for <lists+linux-erofs@lfdr.de>; Tue, 22 Jul 2025 02:44:09 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bmJRq3L87z2yhX;
	Tue, 22 Jul 2025 10:44:07 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.112
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1753145047;
	cv=none; b=Pf3APfGAtSKM7a/xuxazG+NQ9TqX6a5xj3kfJcgtzO0zNN/Uxsn4pdJY8N05RsCCHaMD3MDp+lEaPnzPeg78KooBKOo0B+LYrUTXJ1qHuaNnf/TIlz/+swxv9YaGERjWuusPbT82+vWbCNJVm3vYte0zIMnZlWv3jyPnMIDbMNxDhNKtrB5DhGDIbs0vW8lJ0QT3uOBTa1rE/O1+BOcrlbJV0NSBqq+YJ5Ybp7+pqYi1Fbea+S/VCI9uRcjCVCapT1xW+C5jf0FkhMcnLhldfDBTltd9+R4+Y4XXu8RRSWn5t4zSLfhwRVEt2rOy3Insoj6SLEJcbMm9RQR4u+LAuA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1753145047; c=relaxed/relaxed;
	bh=gZkB6oAI3ayRod1op0xsOxq89vDBkQO5DG9RVIOAOG4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iTb41UOlwm2mzjJ2MKEUlg/rFGr/uKbH6b4mJm9pMKvlcHRn4Apw5HWcJmNlhjAway9Iax8NkNf8wsq+LBjLKvO1kaVuWCwanw0j/BpHeyTH0LG1L585CDPzOeV8ygelWOTk4w/CFbqf7eD1kyQEWHRfsAjJHn6FJHgwrbM1mNZP/wp3i0so2ErTEDwVGNfnG0bBZSWRl9lyyiiAuvzkGdM2je84mgyX8jB54Jba7ZkFW/yaNAY/bKRIuODtq2MXBfFN5TEAuD63dEkrSxhTQzbqU8e29Foh0sFngrEqKjNjk9nRHgjGtIqDJOh8MYBelMgrgycxPOZVx7lDWIi4/A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=iSlYWGKX; dkim-atps=neutral; spf=pass (client-ip=115.124.30.112; helo=out30-112.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=iSlYWGKX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.112; helo=out30-112.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bmJRn3hlsz2xTh
	for <linux-erofs@lists.ozlabs.org>; Tue, 22 Jul 2025 10:44:04 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1753145041; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=gZkB6oAI3ayRod1op0xsOxq89vDBkQO5DG9RVIOAOG4=;
	b=iSlYWGKXFrSGdsYXPYb1TS9CuIuMbrZZ1EAs6p8b95M8txgXlVhtr7+BUgMWIO1GRNNITQfJle9QCCayt7/VmLSGKBPzDh+mKsJWGI4yXLIWEa31wBkt8TAtB5Dwrrj2SootM3X3DMFFreX0xj5f5W/L7CvF1v6OK36BTuJpRwQ=
Received: from 30.170.233.0(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WjTR0ng_1753145038 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 22 Jul 2025 08:43:59 +0800
Message-ID: <293202c8-68e0-45fd-aed8-5ec9aac39872@linux.alibaba.com>
Date: Tue, 22 Jul 2025 08:43:57 +0800
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
Subject: Re: linux-next: Tree for Jul 21 (fs/erofs/*.c)
To: Randy Dunlap <rdunlap@infradead.org>,
 Stephen Rothwell <sfr@canb.auug.org.au>,
 Linux Next Mailing List <linux-next@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-fsdevel@vger.kernel.org, Gao Xiang <xiang@kernel.org>,
 Chao Yu <chao@kernel.org>, linux-erofs@lists.ozlabs.org,
 Bo Liu <liubo03@inspur.com>
References: <20250721174126.75106f39@canb.auug.org.au>
 <b555f01c-4e9e-4b42-aa5a-2d35ef9c1c50@infradead.org>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <b555f01c-4e9e-4b42-aa5a-2d35ef9c1c50@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Hi Randy,

On 2025/7/22 05:31, Randy Dunlap wrote:
> 
> 
> On 7/21/25 12:41 AM, Stephen Rothwell wrote:
>> Hi all,
>>
>> Changes since 20250718:
>>
> 
> on i386 (i.e., 32-bit):
> 
> In file included from ../include/linux/bits.h:5,
>                   from ../include/linux/string_helpers.h:5,
>                   from ../include/linux/seq_file.h:7,
>                   from ../fs/erofs/super.c:8:
> ../fs/erofs/internal.h: In function 'erofs_inode_in_metabox':
> ../include/vdso/bits.h:7:40: warning: left shift count >= width of type [-Wshift-count-overflow]
>      7 | #define BIT(nr)                 (UL(1) << (nr))
>        |                                        ^~
> ../fs/erofs/internal.h:305:38: note: in expansion of macro 'BIT'
>    305 |         return EROFS_I(inode)->nid & BIT(EROFS_DIRENT_NID_METABOX_BIT);
>        |                                      ^~~
> 

Thanks for the report.

I checked this just now. This warning is due to another
helper erofs_inode_in_metabox().

I've fixed it up and just push it out but not sure if
it will catch up with the today's next (20250722).

Thanks,
Gao Xiang

