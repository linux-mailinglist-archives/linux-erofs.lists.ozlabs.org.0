Return-Path: <linux-erofs+bounces-1549-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A63CCD7DFE
	for <lists+linux-erofs@lfdr.de>; Tue, 23 Dec 2025 03:32:23 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dZzYb3YXwz2xlP;
	Tue, 23 Dec 2025 13:32:19 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.112
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1766457139;
	cv=none; b=NtFiJtibEVaCbghAGfK/PfX3xYeoHbTvkxX9TRYaCk1uzH5e97P5B5bh1AWi+GD09TWvvBgU6tb8XvpJ5Fp0NQnqkNuzEC4CaRMP75KSQ+5Cncj3fkCcERwzZPI2AYLlfBUWtnwoQ7BOQJrgmnHPd/biXj40coQTxpnbm/4iNrb89w2Batrb3mCty+FZ/gJuEoipEpldiEuVxNTmdHcYqVl1uws0pQmkn5wkqNid7verhzN+Hr3dfnRXEUo9E0+FxDqQQ5LnloOqkwC92TEvzBPIxjdDvMQ8SVkMeYQRnS9O0DklBEjPJIQ5fOxDt58J9vDx2jzwa6FwGEB/pIz87w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1766457139; c=relaxed/relaxed;
	bh=P7yuWWW0S7jbDDkt/SoyrOQc7euoUuNF2KjMNdz0I+g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P0uXMwS9vQv0A5OGCspU0n8MTkxi1n/HPXQSWnW4za2zlubuO61lg6YT3SEF1onh4xRNvzaE4n7hbmgvuXyd6QkuerAd1nzChbO3M3Eaz1l/aM3r/O5l2bjnDKv2cMS3KwF/JplOQKLzT08wi6HBZ0bSqI8gn4JdaBqtWki0vPLL6mC/F76CVU8NH1KT+ebh/jjsaKSzP07ubfvThpdynphAro89qVjysRmGe7J6U6EHgJhGGQgze0krDONs0458SkX2f5jQ4gcT4BVVthv6mc3PutWgV61WkkKbLs5hE1H2hog/+mDvZ9lyY0CnhafwZ9YP5NxhOAV4IWSmNyxxcg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=hDlmawTr; dkim-atps=neutral; spf=pass (client-ip=115.124.30.112; helo=out30-112.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=hDlmawTr;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.112; helo=out30-112.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dZzYX73rkz2xdY
	for <linux-erofs@lists.ozlabs.org>; Tue, 23 Dec 2025 13:32:14 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1766457130; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=P7yuWWW0S7jbDDkt/SoyrOQc7euoUuNF2KjMNdz0I+g=;
	b=hDlmawTrQh21w/t5FT1w29E8bm623kKu36hl1AgVXxRG3SKUGPjlKRsuVbZsFttcJn6Wf15dluZyOw+Nm0TYtVHKN9rmLdfoGDfgW9x00g5LeV2th9KKOCZhidDpu/sSaRrlnzebjjdk9YPVCJ564+G49ppB4HofvtmlGdmxLT4=
Received: from 30.221.131.244(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WvW2.0d_1766457128 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 23 Dec 2025 10:32:09 +0800
Message-ID: <665e4ff3-0289-431b-b718-4cf71925fc29@linux.alibaba.com>
Date: Tue, 23 Dec 2025 10:32:08 +0800
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
Subject: Re: [PATCH v10 01/10] iomap: stash iomap read ctx in the private
 field of iomap_iter
To: Hongbo Li <lihongbo22@huawei.com>, chao@kernel.org, brauner@kernel.org,
 djwong@kernel.org, amir73il@gmail.com, hch@lst.de
Cc: linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
References: <20251223015618.485626-1-lihongbo22@huawei.com>
 <20251223015618.485626-2-lihongbo22@huawei.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20251223015618.485626-2-lihongbo22@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2025/12/23 09:56, Hongbo Li wrote:
> It's useful to get filesystem-specific information using the
> existing private field in the @iomap_iter passed to iomap_{begin,end}
> for advanced usage for iomap buffered reads, which is much like the
> current iomap DIO.
> 
> For example, EROFS needs it to:
> 
>   - implement an efficient page cache sharing feature, since iomap
>     needs to apply to anon inode page cache but we'd like to get the
>     backing inode/fs instead, so filesystem-specific private data is
>     needed to keep such information;
> 
>   - pass in both struct page * and void * for inline data to avoid
>     kmap_to_page() usage (which is bogus).
> 
> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang

