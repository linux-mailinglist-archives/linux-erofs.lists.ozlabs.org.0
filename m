Return-Path: <linux-erofs+bounces-1158-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AEF1BB3863
	for <lists+linux-erofs@lfdr.de>; Thu, 02 Oct 2025 11:56:51 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ccnJK0P8Qz30NF;
	Thu,  2 Oct 2025 19:56:49 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.101
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1759399009;
	cv=none; b=jwI+wbq5Bf0ZrJtHK6FlAKsUyyj3JWgMXU93tfA+6fqsyNlbkNZtnAy1CbczVmHpo3JoWReOrEiDib0Ib196r+MhUUkGktwtIvoyKr7t+HijwXI3xBG59jBKoVOCpvJ/QK3e6BjB3OmJ1FBwt7ihthJMNNw2RGuavjWrAsOR0UjMejf5X6ornANrNvIg94gQ5ePTX4q+pPMIQzM1UVkE2WTOyYIp/D54sCOvPPjKp68mL80tW4RWMWqlJkSRQPquqbh6IKSFZbPkbCHZI7CB25uS46XCzhR1hag5ISjkKQ00pJmWQN+QmDWszBBHu5VSjw5r2sKvXekgA5imIhk1NA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1759399009; c=relaxed/relaxed;
	bh=zU/ZYJ+D2n8/dVgVgaXyjGrPm+1HugcI+uSWE2FIKfs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ODcBNImnnm0s4I8WABJokrgFq4MAhn5QF0OXYUruZvTD1+jSp/OwG5qpMOIlE30NxPST/TIYx9Y4p9HLKcNvCu9Nz9QGasiaiIgcy4dr5QYuA+bqUuGzGiGDm+j6ya1PG2UBqXz2pkq3p4ey3boX7x9fmRNbD/slEA5a5QrcpCL7bCxz2QlgFcexWhcft5aTAlBKEf8RW2gkDd4ZorH8vhCbhLsy2qvAQd5jJHL/edmwCnTszRk3cCm0h7DJqqvoxRjvHsJ0vnKzMKnfOj0CR2NDZAuoirVwlow62q2z9gqZI8Ob6IS8FeG5Ig/qkQFSu/2b1GVJTUNq7U8BJFFUuQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=KM+GoRoI; dkim-atps=neutral; spf=pass (client-ip=115.124.30.101; helo=out30-101.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=KM+GoRoI;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.101; helo=out30-101.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ccnJH0tRhz3069
	for <linux-erofs@lists.ozlabs.org>; Thu,  2 Oct 2025 19:56:45 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1759399001; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=zU/ZYJ+D2n8/dVgVgaXyjGrPm+1HugcI+uSWE2FIKfs=;
	b=KM+GoRoImOcbeSFnQbXojadc7/Qs2Q4qODD1EFFaqVJXVODNOTGTVVmJV+gkXdGSoB1gOvZToOzxxYtXt55BfmB108Rzj9Us2WjzK0Z5v/zdw059NnNdyW2QnkLGQuX9jYV8nNIyW/81ElwqouFsSC4TC61SEjj/OvYq77AeRAw=
Received: from 30.180.0.242(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WpHewx5_1759398998 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 02 Oct 2025 17:56:39 +0800
Message-ID: <68b155c5-65b2-4b03-a8a3-69dffc41dd1c@linux.alibaba.com>
Date: Thu, 2 Oct 2025 17:56:37 +0800
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
Subject: Re: [PATCH] dax: fix assertion in dax_iomap_rw()
To: Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>
Cc: Dan Williams <dan.j.williams@intel.com>, linux-fsdevel@vger.kernel.org,
 Matthew Wilcox <willy@infradead.org>, chao@kernel.org,
 linux-erofs@lists.ozlabs.org,
 syzbot+47680984f2d4969027ea@syzkaller.appspotmail.com,
 Yuezhang Mo <yuezhang.mo@sony.com>
References: <20251002081311.10488-2-jack@suse.cz>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20251002081311.10488-2-jack@suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Hi Jan,

On 2025/10/2 16:13, Jan Kara wrote:
> dax_iomap_rw() asserts that inode lock is held when reading from it. The
> assert triggers on erofs as it indeed doesn't hold any locks in this
> case - naturally because there's nothing to race against when the
> filesystem is read-only. Check the locking only if the filesystem is
> actually writeable.
> 
> Reported-by: syzbot+47680984f2d4969027ea@syzkaller.appspotmail.com
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
>   fs/dax.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/dax.c b/fs/dax.c
> index 20ecf652c129..187f8c325744 100644
> --- a/fs/dax.c
> +++ b/fs/dax.c
> @@ -1752,7 +1752,7 @@ dax_iomap_rw(struct kiocb *iocb, struct iov_iter *iter,
>   	if (iov_iter_rw(iter) == WRITE) {
>   		lockdep_assert_held_write(&iomi.inode->i_rwsem);
>   		iomi.flags |= IOMAP_WRITE;
> -	} else {
> +	} else if (!IS_RDONLY(iomi.inode)) {

Thanks, Yuezheng also wrote a similiar patch
days ago (but it seems he didn't cc more related
people),
https://lore.kernel.org/r/20250930054256.2461984-2-Yuezhang.Mo@sony.com

both patches look good to me, thanks for the fix.

Thanks,
Gao Xiang

>   		lockdep_assert_held(&iomi.inode->i_rwsem);
>   	}
>   


