Return-Path: <linux-erofs+bounces-1402-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E3E8C65575
	for <lists+linux-erofs@lfdr.de>; Mon, 17 Nov 2025 18:09:16 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4d9Dk21M0Kz2yvM;
	Tue, 18 Nov 2025 04:09:14 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.97
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1763399354;
	cv=none; b=b1h5rQn7VP5Y0Xi1cBZWSgAtz1lJKDWyRnuDkRkyJPkori6ECEwe1ie6B7c44zbdup5XIsqNcBKpJgJ+PZjErY6Te1iAU3ant5kvlViNrZ4FQ5WjyXd/rYS3PUp7HclJqNThiFdeOS4cF+Ph5+ReXnl+QZpUWKZHb51v+pyeeWSP468peJX9yF/IwBDVU+nekNZDNbDcpoEguIF2ttzbYLdmzZDhQ0C4s4dTD9ms74VeL3O3LtRqlpR0ns9huUbs3VyHQ8e2dD8wyNgK7qXlB2eD0XsJwXHkVenUb/xGSbGD40dR/U1WRKz82TMKgwBGI4AzLpuJ8OQfAYEPxMDtOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1763399354; c=relaxed/relaxed;
	bh=zM/R4Dr9RpUZUo8HSaf8GZKE3kicTTpfzgR/zeFwliY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S3ut12pOsPAXy4y6FPlHureLZ+teVRCB88CFPvKNyoim+vGbzeIMa7ZSS7H//tbvcgSm1WXWnkL8h8tr/3z/s6Dzc/v0Ae3q2XKjLTJXHHpd9hMJjgLX4B4j+xLHSb6x/766kPZ+FqRXmxFZtF5tzDv79crNQwOh1BSx4cu+M+sgxJ+lxA7sqn23xgRY7+DhMBGUn5is10sYHO00L3Rzhq9sddiehtmHMISwP13pYudYveH+IeW7eSGQe0IjOSURXCpdco9Bw1Fz2qF6BayWw7pfj2WxdIkiuCbXrLJvWOdY1Ogi9XGv3WbhUWeIHd88ZqGoiK8vvfXEdvywNgiyJQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=VcHJfkjz; dkim-atps=neutral; spf=pass (client-ip=115.124.30.97; helo=out30-97.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=VcHJfkjz;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.97; helo=out30-97.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4d9Djt5Ph2z2ypw
	for <linux-erofs@lists.ozlabs.org>; Tue, 18 Nov 2025 04:09:04 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1763399339; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=zM/R4Dr9RpUZUo8HSaf8GZKE3kicTTpfzgR/zeFwliY=;
	b=VcHJfkjzNUKyWLhWaf8C4j32Ddx/5dl1twWUhHML/48uvZmLJBncRmQyxvoF4b22zx0e03dl63IhnVtOLxC/J3ZXhfd0Tswz5l6eMBKRcTB1vZU9rJlooUZwCvc+74eT4lu4Vj6J4USdlriI8Wpz4yLEiLUXbWsFIvDQvW+TvEM=
Received: from 30.170.82.147(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WsegVOK_1763399336 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 18 Nov 2025 01:08:57 +0800
Message-ID: <f3938037-1292-470d-aace-e5c620428a1d@linux.alibaba.com>
Date: Tue, 18 Nov 2025 01:08:56 +0800
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
Subject: Re: [PATCH v9 01/10] iomap: stash iomap read ctx in the private field
 of iomap_iter
To: brauner@kernel.org, djwong@kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Chao Yu <chao@kernel.org>,
 Amir Goldstein <amir73il@gmail.com>, Joanne Koong <joannelkoong@gmail.com>,
 Hongbo Li <lihongbo22@huawei.com>
References: <20251117132537.227116-1-lihongbo22@huawei.com>
 <20251117132537.227116-2-lihongbo22@huawei.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20251117132537.227116-2-lihongbo22@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Hi Darrick, Christian,

On 2025/11/17 21:25, Hongbo Li wrote:
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
> Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>

Could you help review this iomap change, since erofs uses iomap
and erofs page cache sharing needs this change, as I told
Joanne months ago.

Even without the page cache sharing feature, introducing
iomap_iter_ctx for .iomap_{begin,end}, like the current DIO
does, is still useful for erofs, as patch 2 mentioned.

Thanks,
Gao XIang

